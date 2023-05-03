return {
  'voldikss/vim-floaterm',
  dependencies = {
    'voldikss/fzf-floaterm',
    {'junegunn/fzf', build = ":call fzf#install()"}},
  config = function()
    -- Switch between floating terminals
    vim.keymap.set('n', "<leader>ff", ":Floaterms", { desc = "fzf-floaterms" })
    vim.keymap.set('t', "<leader>ff", "<C-\\><C-n>:Floaterms", { desc = "fzf-floaterms" })

    -- Maybe edit to <leader>fsi for ipython
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=repl <CR>", { desc = "Send visual selection to ipython" })

    -- Use fzf to yank the current ipython session's inputs
    vim.keymap.set('n', '<leader>fph', ":lua print('Store ipython_history into a table') <CR>", { desc="fzf python history yanker" })

    -- TODO: Implement all of these with a single lua function and table arguments
    -- This is only necessary on Windows, really, since I should do this with a tmux floating window.
    vim.cmd([[
    function MainTerminal()
      if count(floaterm#buflist#gather(), floaterm#terminal#get_bufnr('main'))
        :FloatermToggle main
      else
        :FloatermNew --width=0.67 --height=0.67 --name=main
      endif
    endfunction
    ]])
    -- Define a main terminal
    vim.keymap.set('n', '<leader><esc>', ':call MainTerminal()<CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:call MainTerminal()<CR>', { desc = "Quick terminal browser" })

    vim.cmd([[
    function Ipython()
      if count(floaterm#buflist#gather(), floaterm#terminal#get_bufnr('repl'))
        :FloatermToggle repl
      else
        :FloatermNew --width=0.95 --height=0.95 --name=repl ipython --profile="nvim"
      endif
    endfunction
    ]])
    vim.keymap.set("n", "<leader>fi", ":call Ipython()<CR>", { desc = "Open or close ipython buffer" })
    vim.keymap.set("t", "<leader>fi", "<C-\\><C-n> :call Ipython()<CR>", { desc = "Open or close ipython buffer" })

    vim.cmd([[
    function Lazygit()
      if count(floaterm#buflist#gather(), floaterm#terminal#get_bufnr('lg'))
        :FloatermToggle lg
      else
        :FloatermNew --width=0.95 --height=0.95 --name=lg lazygit
      endif
    endfunction
    ]])
    vim.keymap.set('n', '<leader>gg', ":call Lazygit() <CR>", { desc = "Lazygit lol" })
    vim.keymap.set('t', '<leader>gg', "<C-\\><C-n> :call Lazygit() <CR>", { desc = "Lazygit lol" })

    vim.keymap.set('n', '<leader>tt', ':FloatermNew --autoclose=1 pdflatex % <CR>')
  end
}
