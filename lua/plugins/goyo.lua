return {
  'junegunn/goyo.vim',
  config = function ()
    vim.keymap.set('n', "<leader>G", ":Goyo<CR>")
    vim.keymap.set({'n', 'i'}, "<C-g>", "<Esc>:Goyo<CR>")
  end
}
