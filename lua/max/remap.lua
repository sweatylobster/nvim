-- Kickstart.nvim keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Theprimeagen's stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Center when moving or searching, stay put when joining
vim.keymap.set("n", "J", "mzJ`z", { desc = "Stay put when joining" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center screen when scrolling" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center screen when scrolling" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center screen when searching" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center screen when searching" })

-- Repeatably replace text!
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste and don't store" })

-- Clip it, Johnson!
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank word to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank line to clipboard" })

-- To hell with it, Johnson!
vim.keymap.set("n", "<leader>d", '"_d', { desc = "[D]elete to black-hole" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "[D]elete selection to black-hole" })

-- Replace word under cursor
vim.keymap.set(
  "n",
  "<leader>rw",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "[R]eplace [w]ord under cursor" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- Jess Archer stuff
-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

-- Allow gf to open non-existent files
vim.keymap.set("", "gf", ":edit <cfile><CR>")

-- The same, but put it in a new tab
vim.keymap.set("", "gt", ":tabedit <cfile><CR>", { desc = "Tabedit the file under cursor" })

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize up" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize down" })
vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", { desc = "Resize left" })
vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", { desc = "Resize right" })

-- Inspired by LazyVim
vim.keymap.set("n", "<leader><tab><tab>", vim.cmd.tabnew, { desc = "New tab" }) -- always was nice
vim.keymap.set("n", "<leader><tab>]", vim.cmd.tabnext, { desc = "---> Next tab" }) -- ] or l
vim.keymap.set("n", "<leader><tab>[", vim.cmd.tabprev, { desc = "<--- Prev tab" }) -- [ or h
vim.keymap.set("n", "<leader><tab>q", vim.cmd.tabclose, { desc = "Quit tab" }) -- q or d

-- Go to the Alpha shortcuts. Maybe remap them in the future
vim.keymap.set("n", "<leader>h", ":Alpha <CR>", { desc = "Alpha [h]omescreen" })

-- Need a general Telescope binding
vim.keymap.set("n", "<leader>t", ":Telescope <CR>", { desc = "Open [T]elescope" })

-- Finally vim-easy-align
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")

vim.keymap.set({ "n", "x", "o" }, "gh", "^")
vim.keymap.set({ "n", "x", "o" }, "gl", "$")

-- emacs shit for command and insert mode
vim.keymap.set({ "c", "i" }, "<C-a>", "<Home>")
vim.keymap.set({ "c", "i" }, "<C-e>", "<End>")
vim.keymap.set({ "c", "i" }, "<C-b>", "<Left>")
vim.keymap.set({ "c", "i" }, "<C-f>", "<Right>")
vim.keymap.set({ "c", "i" }, "<A-b>", "<S-Left>")
vim.keymap.set({ "c", "i" }, "<A-f>", "<S-Right>")
vim.keymap.set({ "c", "i" }, "<C-d>", "<Del>")

-- run current buffer
vim.keymap.set("n", "<leader>%", function()
  local ft = vim.bo.filetype

  -- Define vim.cmd dispatchers for filetypes.
  local dispatcher = {
    lua = "luafile",
    python = "pyfile",
    sh = ":terminal",
  }

  -- Break if there's no dispatcher for the filetype.
  assert(
    dispatcher[ft],
    string.format("No dispatcher for filetype: '%s' with extension '%s'", ft, vim.fn.expand("%:e"))
  )

  -- See `:help %:p`, `help %:e`.
  vim.cmd(dispatcher[ft] .. " %:p")
end, { desc = "Run the current [b]uffer" })

-- BASH-RUNNER MAPPINGS.
-- Could be generalized to work with dispatchers.
vim.keymap.set("n", "<leader>ssv", function()
  local current_buffer = vim.fn.expand("%")
  local cmd = string.format("./%s", current_buffer)
  local results = require("max.capture").to_table(cmd)
  vim.cmd(":new")
  vim.api.nvim_buf_set_lines(0, -1, -1, false, results)
end, { desc = "Write the output of the current bashfile to :new." })

vim.keymap.set("n", "<leader>sss", function()
  -- get absolute path to current buffer
  vim.cmd(":terminal %:p")
end, { desc = "Run shell script in terminal" })

-- buffer stuff
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Delete the current buffer." })

-- quickfix stuff
vim.keymap.set("n", "[c", ":cprevious<CR>", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "]c", ":cnext<CR>", { desc = "Go to next buffer quickfix item" })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "Close quickfix list" })

vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis <CR>", { desc = "Do a git diff of the current buffer." })

vim.keymap.set("n", "<leader>af", function()
  local opts = {
    cwd = "$AGUILA",
    prompt_title = "Search over the aguila project",
  }
  require("telescope.builtin").find_files(opts)
end, { desc = "Search [f]iles in [a]guila project" })
