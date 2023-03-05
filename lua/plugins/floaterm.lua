return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<esc>', '<C-\\><C-n>')
    -- keybind toggles a floating ipython repl buffer
    vim.keymap.set('n', '<leader>fi', ":FloatermNew --wintype='vsplit' powershell.exe -ExecutionPolicy ByPass -NoExit -Command 'C:\\Users\\maxde\\anaconda3\\shell\\condabin\\conda-hook.ps1' ; conda activate 'C:\\Users\\maxde\\anaconda3' ", { desc = "Interactive python repl" })
    -- keybind sends vselected buffer contents to aforementioned ipython repl buffer
  end
}
