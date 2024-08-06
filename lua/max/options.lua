-- See `:help vim.o`

-- Hide .gitignore, .pyc files
-- :help netrw-gitignore
-- Need to write lua patterns, lua lsp is linting
vim.g.netrw_list_hide = "*.bak, *.gitignore, *.pyc, *.git"

-- Name, +time, wide, tree
vim.g.netrw_liststyle = 0

local function get_python3_host_prog()
  -- if os.getenv("AGUILA") then
  --   return os.getenv("AGUILA")..'/.devenv/state/venv/bin/python'
  -- else
    return '/opt/homebrew/anaconda3/bin/python'
  -- end
end

-- Set the provider python variable
-- NOTE: expand this per definite project
vim.g.python3_host_prog = get_python3_host_prog()

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

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
vim.cmd [[colorscheme catppuccin-mocha]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.spelllang = 'en_us'
vim.o.spell = true

vim.o.shiftwidth = 2
