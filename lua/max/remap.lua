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

vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { desc = "Open lazy menu" })

vim.keymap.set('n', '<A-h>', '<C-w><C-h>')
vim.keymap.set('n', '<A-j>', '<C-w><C-j>')
vim.keymap.set('n', '<A-k>', '<C-w><C-k>')
vim.keymap.set('n', '<A-l>', '<C-w><C-l>')

-- ORIGINAL MAX THINGS
-- yikes lol 2/19/2023

-- Go to the Alpha shortcuts. Maybe remap them in the future
vim.keymap.set('n', '<leader>h', ':Alpha <CR>', { desc = "Alpha homescreen" })

-- Need a general Telescope binding
vim.keymap.set('n', '<leader>t', ':Telescope <CR>', { desc = "Open Telescope" })

-- Netrw bindings
vim.keymap.set("n", "<leader>e", ":Explore <CR>", {desc = "Toggle netrw"})
-- vim.keymap.set("n", "<leader>E", ":Explore <CR>", {desc = "Toggle netrw"})

-- FzfLua bindings c.f. $NVIM_CONFIG/lua/plugins/fzf.lua
-- vim.keymap.set("n", "<leader>F", ":FzfLua <CR>", {desc = "lua♡fzf"})

-- Finally vim-easy-align
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

-- emacs shit for command and insert mode
vim.keymap.set({'c', 'i'}, '<C-a>', '<Home>')
vim.keymap.set({'c', 'i'}, '<C-e>', '<End>')
vim.keymap.set({'c', 'i'}, '<C-b>', '<Left>')
vim.keymap.set({'c', 'i'}, '<C-f>', '<Right>')
vim.keymap.set({'c', 'i'}, '<A-b>', '<S-Left>')
vim.keymap.set({'c', 'i'}, '<A-f>', '<S-Right>')
vim.keymap.set({'c', 'i'}, '<C-d>', '<Del>')

vim.keymap.set('n', '<leader>j', ':NoiceDismiss <CR>')

vim.keymap.set('n', '<leader>nt', ':NoiceTelescope <CR>')

-- run current file
vim.keymap.set('n', '<leader>b', function ()
  local path = vim.fn.expand("%")
  if vim.bo.filetype == 'lua' then
    vim.cmd("luafile " .. path)
  elseif vim.bo.filetype == 'python' then
    vim.cmd("pyfile " .. path)
  end
  end)

vim.keymap.set("n", "<leader>alg", function ()
  require('max.adder').choose()
end)
