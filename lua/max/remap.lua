-- Theprimeagen's stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Use netrw and none of this other stuff
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>pr', vim.cmd.Rexplore)

-- Center when moving or searching, stay put when joining
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Repeatably replace text!
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Clip it, Johnson!
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- To hell with it, Johnson!
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Replace word under cursor
vim.keymap.set('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Jess Archer stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- The same, but put it in a new tab
vim.keymap.set('', 'gt', ':tabedit <cfile><CR>')

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- ORIGINAL MAX THINGS

-- Move tabs
vim.keymap.set('n', '<leader><tab><tab>', vim.cmd.tabnew)
vim.keymap.set('n', '<leader><tab>K', vim.cmd.tabnext)
vim.keymap.set('n', '<leader><tab>J', vim.cmd.tabprev)
vim.keymap.set('n', '<leader><tab>x', vim.cmd.tabclose)
