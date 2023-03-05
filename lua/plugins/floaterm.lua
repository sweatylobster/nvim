return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<esc>', '<C-\\><C-n>')
    -- keybind sends vselected buffer contents to aforementioned ipython repl buffer
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
      let g:lazygit_bufnr=floaterm#terminal#get_bufnr('lazygit')
      let g:buflist=floaterm#buflist#gather()
      let g:ys = count(g:buflist, g:lazygit)
      if g:ys
        :FloatermToggle lazygit
      else
        :FloatermNew --width=0.5 --height=0.8 --name=lazygit lazygit
      endif
    endfunction
    ]])
    vim.keymap.set('n', '<leader>gg', ":FloatermNew! --name=lazygit lazygit <CR>", { desc = "Lazygit lol" })
    vim.keymap.set('t', '<leader>gg', "<C-\\><C-n>:FloatermToggle --name=lazygit <CR>", { desc = "Lazygit lol" })
  end
}
