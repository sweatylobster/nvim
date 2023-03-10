return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=repl")
    vim.cmd([[
    function Ipython()
      let g:ipython_bufnr=floaterm#terminal#get_bufnr('repl')
      let g:buflist=floaterm#buflist#gather()
      let g:xs = count(g:buflist, g:ipython_bufnr)
      if g:xs
        :FloatermToggle repl
      else
        :FloatermNew --width=0.5 --height=0.8 --name=repl ipython --profile="nvim"
      endif
    endfunction
    ]])
    vim.keymap.set("n", "<leader>fi", ":call Ipython()<CR>", { desc = "Open or close ipython buffer" })
    vim.keymap.set("t", "<leader>fi", "<C-\\><C-n> :call Ipython()<CR>", { desc = "Open or close ipython buffer" })

    vim.cmd([[
    function Lazygit()
      let g:lazygit_bufnr=floaterm#terminal#get_bufnr('lg')
      let g:dabuflist=floaterm#buflist#gather()
      let g:ys = count(g:dabuflist, g:lazygit_bufnr)
      if g:ys
        :FloatermToggle lg
      else
        :FloatermNew --width=0.95 --height=0.95 --name=lg lazygit
      endif
    endfunction
    ]])
    vim.keymap.set('n', '<leader>gg', ":call Lazygit() <CR>", { desc = "Lazygit lol" })
  end
}
