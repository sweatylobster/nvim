local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Disable line numbers in terminal mode
vim.api.nvim_create_autocmd({ "TermEnter"}, {
  group = augroup("terminal"),
  callback = function ()
    vim.o.number = false
    vim.o.relativenumber = false
    vim.cmd('startinsert')
  end
})

-- Highlight on yank 
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

