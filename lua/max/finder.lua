local function find_git_root()
  local dotgitpath = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dotgitpath, ':h')
end

vim.api.nvim_create_user_command('CdGitRoot', function ()
  local git_root = find_git_root()
  if type(git_root) == "nil" then
    print("Not in a git repository.")
  else
    vim.api.nvim_set_current_dir(git_root)
  end
end, {})

vim.keymap.set('n', '<leader>vp', function()
  local prefix = "/users/max/code/"
  local projects = {'aguila', 'universal-mail'}
  coroutine.wrap(function ()
    local fzf = require('fzf')
    local dir = fzf.fzf(projects, '--prompt="Which project folder do you want to visit?>"')
    if dir then
      local path = prefix..dir
      print(string.format("Moving to %s", path))
      require('nvim-tree.api').tree.change_root(path)
    end
  end)()
end, {desc = '[V]iew [P]roject folders'})


