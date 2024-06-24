local M = {}

local fzf = require('fzf')
local fzf_helpers = require('fzf.helpers')

local aguila = os.getenv("AGUILA") or "/users/max/code/aguila"

local target = aguila.."/billing/liens/liens.csv"

M.sources = {
  upcoming = aguila.."/billing/come/upcoming.json",
  appts = aguila.."/billing/appts/appts.json"
}

local filename = M.sources.appts

function M.filter(t, date, interpreter, source)
  local a = {}
  for i, v in ipairs(t) do
    local name = v
    -- get the list of unique patients from the schedule
    local get_patient_json = string.format(
      [[jq -r --arg date %s --arg patient "%s" 'map(select(.dos | test($date))) | map(select(.name | test($patient))) | unique | .[] | [.dos,.doctor,.name,.dob][]' %s]],
      date, name, M.sources[source])

    local json = assert(io.popen(get_patient_json, 'r'))

    -- get and set line number
    -- thanks
    -- NOTE: https://vi.stackexchange.com/questions/39964/how-to-get-the-total-lines-of-a-file-before-its-loaded-into-a-buffer
    local invoice = tonumber(vim.fn.system({ 'wc', '-l', vim.fn.expand("%") }):match("%d+")) -1 + i
    local lines = {}
    table.insert(lines, invoice)
    for l in json:lines() do
      -- get rid of doctor title
      l = l:gsub("(,%sD%.C%.)", "")
      l = l:gsub(",%sL%.Ac", "")
      l = l:gsub("Tae Young", "Young Tae")
      -- if l == date then l = os.date("%Y-%m-%d") end
      if l == date then l = l:gsub("(%d%d)-(%d%d)-(%d%d%d%d)", "%3-%1-%2") end
      table.insert(lines, l)
    end

    interpreter = interpreter or "INTERPRETER"
    -- insert index i
    -- table.insert(lines, "Erika Gonzalez #019816")
    table.insert(lines, interpreter)
    table.insert(lines, i)

    -- save as a string
    local result = table.concat(lines, ",")
    -- write it to the bottom of the liens.csv file
    assert(vim.api.nvim_buf_get_name(0) == target, "Error: calling adder on an unauthorized buffer.")
    vim.api.nvim_buf_set_lines(1, -1, -1, false, {result})
    table.insert(a, result)
  end
  return a
end

function M.test_write_to_liens()
  local l = vim.api.nvim_get_current_line()
  local b = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(1, -1, -1, false, {"cow", "sow", "stove", "glave", "knave"})
end

-- vim.api.nvim_buf_set_text
--
function M.expand_interpreter(keypress)
  return require('max.aguila.interpreters')[keypress]
end

function M.concat_keys(t, sep)
  local a = {}
  for k, _ in pairs(t) do
    table.insert(a, k)
  end
  return table.concat(a, sep)
end

function M.choose(date, source)
  -- local fzf_fn = fzf_helpers.cmd_line_transformer(jq_unique_patients, function (x)
  --   return x
  -- end)

  if source then
  else
    source = "appts"
  end

  local expect_keys = M.concat_keys(require('max.aguila.interpreters'), ',')

  local options = table.concat({
    '--multi',
    '--reverse',
    -- '--expect=ctrl-m,ctrl-e,ctrl-o,ctrl-x,ctrl-a,ctrl-b',
    '--header="ctrl-j:next-page ; ctrl-k:prev-page"',
    '--expect='..expect_keys,
    '--prompt="Happy hunting!"',
    '--bind="tab:toggle-up+clear-query"',
    '--bind="ctrl-j:execute(sioyek --execute-command next_page)"',
    '--bind="ctrl-k:execute(sioyek --execute-command previous_page)"',
  }, " ")

  if type(date) == "nil" then
    date = os.date("%m-%d-%Y")
  end

  local jq_unique_patients = string.format(
    [[jq --arg date %s 'map(select(.dos | test($date))) | unique | .[].name' -r %s]],
    date, M.sources[source])

  local selection = fzf.fzf(jq_unique_patients, options)

  local interpreter = M.expand_interpreter(selection[1])
  if interpreter then
    for i=1,#selection do
      selection[i] = selection[i+1]
    end
  end

  -- TODO: missing a lot of steps in API
  -- 1) change the source
  --      can i write the jq query?
  -- 2) change the output
  --      to json, csv, whatever
  -- 3) explicitly state the file to write to
  --      do i always wanna write to a file?
  --      do i always want it at the end of the file?
  --      do i wanna choose the current line with vim.api.nvim_get_current_line()
  return M.filter(selection, date, interpreter, source)

end

vim.api.nvim_create_user_command("AddLiens", function (args)
  coroutine.wrap(function ()
    local a = args['args']
    -- local words = M.split_words(a)
    -- local d, s = words[1], words[2]
    local d, s = string.match(a, "([%d%-%/]+)%s(%a+)")
    -- set today as default arg
    if a == ""  then
      a = os.date("%m-%d-%Y")
    else
      a = require('adjust_date').strftime(a, "%m-%d-%Y")
    end
    M.choose(a)
  end)()
end, {desc="Make boob huge", nargs="*"})

function M.split_words(s)
  local a = {}
  for m in string.gmatch(s, "%S+") do
    table.insert(a, m)
  end
  return a
end

function M.parse_args(s)
  local parsed = {}
  local words = M.split_words(s)
  assert(#words <= 2, "Error: expecting two args at most.")
  for i=1,#words do
    local is_date = words[i]:match("%d%d%d%d%-%d%d%-%d%d")
    if require('adjust_date').Tabulate(words[i]) and is_date then
      parsed["date"] = words[i]
    elseif type(M.sources[words[i]]) == "string" then
      parsed["source"] = words[i]
    end
  end
  return parsed
end

--
-- local x = "2024-02-02 appts"
-- local y = "1995-04-02"
--
-- local t1 = M.parse_args(x)
-- local t2 = M.parse_args("2024-02-02 appts")
--
-- for k, v in pairs(t2) do
--   print(k,v)
-- end
--
-- local o, t = M.split_words("2024-02-02 appts")
-- local d, s = string.match(x, "([%d%-%/]+)%s?(%a?)")
-- print(d, s)

-- local s = tostring(os.date(":AddLiens %Y-%m"))
vim.keymap.set('n', '<leader>all', tostring(os.date(":AddLiens %Y-%m-")), {desc='AddLiens shortcut'})

return M
