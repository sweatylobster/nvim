local M = {}

local fzf = require('fzf')
local fzf_helpers = require('fzf.helpers')

-- get the list of unique patients from the schedule
local date = os.date("%m-%d-%Y")

local aguila = os.getenv("AGUILA")

local filename = aguila.."/billing/come/upcoming.json"

local jq_unique_patients = string.format(
  [[jq --arg date %s 'map(select(.dos | test($date))) | .[].name' -r %s]],
  date, filename)

function M.filter(t)
  local a = {}
  for i, v in ipairs(t) do
    local name = v
    local get_patient_json = string.format(
      [[jq -r --arg date %s --arg patient "%s" 'map(select(.dos | test($date))) | map(select(.name | test($patient)))[] | [.dos,.doctor,.name,.dob][]' %s]],
      date, name, filename)

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
      if l == date then l = os.date("%Y-%m-%d") end
      table.insert(lines, l)
    end
    -- insert index i
    -- table.insert(lines, "Erika Gonzalez #019816")
    table.insert(lines, "INTERPRETER")
    table.insert(lines, i)

    -- save as a string
    local result = table.concat(lines, ",")
    -- write it to the bottom of the liens.csv file
    vim.api.nvim_buf_set_lines(1, -1, -1, false, {result})
    print(result)
    table.insert(a, result)
  end
  return a
end

function M.write_to_liens()
  local l = vim.api.nvim_get_current_line()
  local b = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(1, -1, -1, false, {"cow", "sow", "stove", "glave", "knave"})
end

-- vim.api.nvim_buf_set_text

function M.choose()
  -- local fzf_fn = fzf_helpers.cmd_line_transformer(jq_unique_patients, function (x)
  --   return x
  -- end)
  local options = table.concat({
    '--multi',
    '--reverse',
    '--prompt="Happy hunting!"',
  }, " ")

  local selection = fzf.fzf(jq_unique_patients, options)

  -- TODO: missing a lot of steps in API
  -- 1) change the source
  --      can i write the jq query?
  -- 2) change the output
  --      to json, csv, whatever
  -- 3) explicitly state the file to write to
  --      do i always wanna write to a file?
  --      do i always want it at the end of the file?
  --      do i wanna choose the current line with vim.api.nvim_get_current_line()
  return M.filter(selection)

end

return M
