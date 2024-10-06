local function find_git_root()
  local dotgitpath = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dotgitpath, ":h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
  local git_root = find_git_root()
  if type(git_root) == "nil" then
    print("Not in a git repository.")
  else
    vim.api.nvim_set_current_dir(git_root)
  end
end, {})
