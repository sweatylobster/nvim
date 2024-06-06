local M = {}

local fzf = require('fzf')

local aguila = os.getenv("AGUILA") or '/users/max/code/aguila'

M.demographics = {
    main = aguila .. '/billing/liens/demographics.json',
    simple = aguila .. '/billing/liens/simple_demographics.json'
}

function M.boob()
  print("boob")
end

function M.demos()

  local options = table.concat({
    [[--multi]],
    [[--reverse]],
    [[--prompt="Choose a patient."]],
    [[--preview="jq 'map(select(.name == {}))' "]]
    -- '--bind="tab:toggle-up+clear-query"'
    -- 
  }, " ")

  local jq_unique_patients = string.format(
    [[jq 'map(.name) | unique' -r %s]],
    M.demographics.simple)

  local selection = fzf.fzf(jq_unique_patients, options)

  for i=1,#selection do
    print(selection[i])
  end

  return selection

end


vim.keymap.set("n", "<leader>aD", function ()
  coroutine.wrap(function ()
    require('max.aguila.peruse').demos()
  end)()
end)
