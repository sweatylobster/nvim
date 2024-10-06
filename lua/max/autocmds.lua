local function augroup(name, opts)
  return vim.api.nvim_create_augroup(name, opts)
end

-- Disable line numbers in terminal mode
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup("terminal", { clear = false }),
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
    vim.cmd("startinsert")
    vim.cmd("setlocal nospell")
  end,
})

vim.cmd([[au BufRead,BufNewFile *.jq setfiletype jq]])

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = "*",
})
