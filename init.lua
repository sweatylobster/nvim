-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set the damn leader
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

-- And get the package manager going
require('lazy').setup('plugins')

-- Also load timewarp greeting, personal options, and keymaps
require('max')

-- Load my snippets bro
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets"})
require("luasnip.loaders.from_vscode").lazy_load()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
