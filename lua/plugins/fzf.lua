return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    vim.keymap.set('n', '<leader>F', ':FzfLua <cr>')
    vim.keymap.set('n', '<leader>cf', ':FzfLua complete_file <cr>')
  end
}
