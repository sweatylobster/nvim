-- Kickstart.nvim keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Theprimeagen's stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Use netrw and none of this other stuff
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = "Open netrw" })
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = "Open netrw" })
vim.keymap.set('n', '<leader>pr', vim.cmd.Rexplore, { desc = "Return to buffer" })

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

-- Jess Archer stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- The same, but put it in a new tab
vim.keymap.set('', 'gt', ':tabedit <cfile><CR>', { desc = 'Tabedit the file under cursor' })

-- Easy insertion of a trailing ; or , from insert mode
-- Honestly this is clunky trash
-- I tend to think when punctuating
-- vim.keymap.set('i', ';;', '<Esc>A;<Esc>', { desc = "Trailing semi-colon" })
-- vim.keymap.set('i', ',,', '<Esc>A,<Esc>', { desc = "Trailing comma" })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Resize up' })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Resize down' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize left' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize right' })

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi', { desc = 'Move text down' })
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi', { desc = 'Move text up' })
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", { desc = 'Move text down' })
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", { desc = 'Move text up' })

-- Inspired by LazyVim
vim.keymap.set('n', '<leader><tab><tab>', vim.cmd.tabnew, { desc = 'New tab' }) -- always was nice
vim.keymap.set('n', '<leader><tab>]', vim.cmd.tabnext, { desc = '---> Next tab' })  -- ] or l
vim.keymap.set('n', '<leader><tab>[', vim.cmd.tabprev, { desc = '<--- Prev tab' })  -- [ or h
vim.keymap.set('n', '<leader><tab>q', vim.cmd.tabclose, { desc = 'Quit tab' }) -- q or d

vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { desc = "Open lazy menu" })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- ORIGINAL MAX THINGS
-- yikes lol 2/19/2023

-- Go to the Alpha shortcuts. Maybe remap them in the future
vim.keymap.set('n', '<leader>h', ':Alpha <CR>', { desc = "Alpha homescreen" })

-- start a netrw window in the right pane like one of the trees
vim.keymap.set('n', '<leader>vv', ':vnew Explore <CR>', { desc = "Netrw explore tree" })

-- Need a general Telescope binding
vim.keymap.set('n', '<leader>t', ':Telescope <CR>', { desc = "Open Telescope" })

-- Very self-explanatory
vim.keymap.set('n', "<leader>py", ":pyfile % <CR>", { desc = "Execute python file"})

-- Kinda ridiculous considering you have floaterm tbh
vim.keymap.set("n", "<leader>vt", ":vert terminal <CR>", { desc = "[V]split [t]erminal"} )

vim.keymap.set("n", "<leader>lg", ":FloatermToggle lazygit <CR>", { desc = "Honestly idk" } )
