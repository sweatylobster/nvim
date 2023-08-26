-- See `:help vim.o`

-- Hide .gitignore, .pyc files
-- :help netrw-gitignore
-- Need to write lua patterns, lua lsp is linting
vim.g.netrw_list_hide = "*.bak, *.gitignore, *.pyc, *.git"

-- Name, +time, wide, tree
vim.g.netrw_liststyle = 0

-- Set the provider python variable
vim.g.python3_host_prog = "python"

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Relative line numbers too
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight-night]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
