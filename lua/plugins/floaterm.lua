return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    -- Maybe edit to <leader>fsi for ipython
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=repl <CR>", { desc = "Send visual selection to ipython" })

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
