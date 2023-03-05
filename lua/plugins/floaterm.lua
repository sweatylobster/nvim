return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader>fj', ':FloatermToggle main <CR>', { desc = "Quick terminal browser" })
    -- add the ipython function
    vim.keymap.set('n', '<leader>fi', ":FloatermNew --wintype='vsplit' powershell.exe -ExecutionPolicy ByPass -NoExit -Command 'C:\\Users\\maxde\\anaconda3\\shell\\condabin\\conda-hook.ps1' ; conda activate 'C:\\Users\\maxde\\anaconda3' ", { desc = "Interactive python repl" })
  end
}
