-- Kickstart.nvim keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Theprimeagen's stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Center when moving or searching, stay put when joining
vim.keymap.set("n", "J", "mzJ`z", { desc = "Stay put when joining"})
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center screen when scrolling"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center screen when scrolling"})
vim.keymap.set("n", "n", "nzzzv", { desc = "Center screen when searching"})
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center screen when searching"})

-- Repeatably replace text!
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste and don't store" })

-- Clip it, Johnson!
vim.keymap.set("n", "<leader>y", "\"+y", { desc = '[Y]ank word to clipboard' })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = '[Y]ank selection to clipboard' })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = '[Y]ank line to clipboard' })

-- To hell with it, Johnson!
vim.keymap.set("n", "<leader>d", "\"_d", { desc = '[D]elete to black-hole' })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = '[D]elete selection to black-hole' })

-- Replace word under cursor
vim.keymap.set('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = '[R]eplace [w]ord under cursor' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make current file executable' })

-- TODO: Fuzzy find a word from the buffer to replace
-- vim.keymaps.set('n', '<leader>rs' '', {desc = "[R]eplace [s]earch term"})
-- function ()
--   local search_selection = 
-- end

-- Jess Archer stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- The same, but put it in a new tab
vim.keymap.set('', 'gt', ':tabedit <cfile><CR>', { desc = 'Tabedit the file under cursor' })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Resize up' })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Resize down' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Resize left' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Resize right' })

-- Inspired by LazyVim
vim.keymap.set('n', '<leader><tab><tab>', vim.cmd.tabnew, { desc = 'New tab' }) -- always was nice
vim.keymap.set('n', '<leader><tab>]', vim.cmd.tabnext, { desc = '---> Next tab' })  -- ] or l
vim.keymap.set('n', '<leader><tab>[', vim.cmd.tabprev, { desc = '<--- Prev tab' })  -- [ or h
vim.keymap.set('n', '<leader><tab>q', vim.cmd.tabclose, { desc = 'Quit tab' }) -- q or d

vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { desc = "Open lazy menu" })

-- vim.keymap.set('n', '<A-h>', ':TmuxNavigateLeft<cr>', { silent = true })
-- vim.keymap.set('n', '<A-j>', ':TmuxNavigateDown<cr>', { silent = true })
-- vim.keymap.set('n', '<A-k>', ':TmuxNavigateUp<cr>', { silent = true })
-- vim.keymap.set('n', '<A-l>', ':TmuxNavigateRight<cr>', { silent = true })

-- ORIGINAL MAX THINGS
-- yikes lol 2/19/2023

-- Go to the Alpha shortcuts. Maybe remap them in the future
vim.keymap.set('n', '<leader>h', ':Alpha <CR>', { desc = "Alpha homescreen" })

-- Need a general Telescope binding
vim.keymap.set('n', '<leader>t', ':Telescope <CR>', { desc = "Open Telescope" })

-- FzfLua bindings c.f. $NVIM_CONFIG/lua/plugins/fzf.lua
-- vim.keymap.set("n", "<leader>F", ":FzfLua <CR>", {desc = "lua♡fzf"})

-- Finally vim-easy-align
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

vim.keymap.set('n', 'gh', '^')
vim.keymap.set('n', 'gl', '$')

-- emacs shit for command and insert mode
vim.keymap.set({'c', 'i'}, '<C-a>', '<Home>')
vim.keymap.set({'c', 'i'}, '<C-e>', '<End>')
vim.keymap.set({'c', 'i'}, '<C-b>', '<Left>')
vim.keymap.set({'c', 'i'}, '<C-f>', '<Right>')
vim.keymap.set({'c', 'i'}, '<A-b>', '<S-Left>')
vim.keymap.set({'c', 'i'}, '<A-f>', '<S-Right>')
vim.keymap.set({'c', 'i'}, '<C-d>', '<Del>')

-- run current file
vim.keymap.set('n', '<leader>b', function ()
  local path = vim.fn.expand("%")
  if vim.bo.filetype == 'lua' then
    vim.cmd("luafile " .. path)
  elseif vim.bo.filetype == 'python' then
    vim.cmd("pyfile " .. path)
  end
end, {desc="Run the current [b]uffer"})

vim.keymap.set("n", "<leader>alg", function ()
  coroutine.wrap(function ()
    require('max.aguila.adder').choose(nil, 'upcoming')
  end)()
end)

-- should do a require('max.capture').to_table(selection)
vim.keymap.set("x", "<leader>W", ":'<,'>w ! <CR>", {desc="Send visual selection to an external command."})

vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis <CR>", {desc="Do a git diff of the current buffer."})

vim.keymap.set('n', '<leader>af', function ()
  local opts = {
    cwd = "$AGUILA",
    prompt_title = "Search over the aguila project",
  }
  require('telescope.builtin').find_files(opts)
end, {desc = "Search [f]iles in [a]guila project"})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {desc="Toggle NvimTree"})
vim.keymap.set('n', '<leader>E', function()
  vim.cmd(':CdGitRoot')
  vim.cmd(':NvimTreeToggle')
end, {desc="Toggle NvimTree"})

vim.keymap.set('n', '<leader>vp', function()
  coroutine.wrap(function ()
    local prefix = "/users/max/code/"
    local projects = {'aguila', 'universal-mail'}
    local fzf = require('fzf')
    local dir = fzf.fzf(projects, '--prompt="Which project folder do you want to visit?>"')
    local path = prefix..dir
    print(string.format("Moving to %s", path))
    require('nvim-tree.api').tree.change_root(path)
  end)()
end, {desc = '[V]iew [P]roject folders'})

-- BASH-RUNNER MAPPINGS
vim.keymap.set("n", "<leader>ssv", function ()
  local current_buffer = vim.fn.expand("%")
  local cmd = string.format("./%s", current_buffer)
  local results = require('max.capture').to_table(cmd)
  vim.cmd(':new')
  vim.api.nvim_buf_set_lines(0, -1, -1, false, results)
end, {desc="Write the output of the current bashfile to :new."})

vim.keymap.set('n', '<leader>sss', function ()
  -- get absolute path to current buffer
  vim.cmd(':terminal %:p')
end, {desc="Run shell script in terminal"})

vim.keymap.set('n', '[b', ':bprevious<CR>', {desc='Go to previous buffer'})
vim.keymap.set('n', ']b', ':bnext<CR>', {desc='Go to next buffer'})
vim.keymap.set('n', '<leader>bx', ':bdelete<CR>', {desc='Delete the current buffer.'})

vim.keymap.set('n', '<leader>-', function() require('oil').toggle_float() end, {desc='Go to previous buffer'})


-- local l = vim.fn.system("bat $LIENS/liens.csv -p -f | fzf-tmux --ansi --header-lines=1 --multi | awk -F ',' '{print $1}'")
-- print(l)
--
--
vim.keymap.set('n', "<leader>so", function ()
  local pdf = vim.api.nvim_get_current_line():match(".+%.pdf")
  vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', pdf})
end)
