return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=repl <CR>")
    --TODO: Make a keymap to send *ONE* approved of ipython input to *A* buffer
    --NOTE: Strategy is probably to:
    -- list and name buffer windows
    -- filter for .py
    -- display it in a telescope list
    -- paste at current cursor location OR end of file OR marker
    -- NOTE: Marker strategy would simply take the marker as argument when in floaterm
    -- vim.keymap.set("t", "<leader>fr", "", { desc = "[F]loaterm [R]etrieve/[F]etch to buffer such-and-such"})
    --TODO: Emend this to do several commands

    vim.cmd([[
    function Ipython()
      if count(floaterm#buflist#gather(), floaterm#terminal#get_bufnr('repl'))
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
      if count(floaterm#buflist#gather(), floaterm#terminal#get_bufnr('lg'))
        :FloatermToggle lg
      else
        :FloatermNew --width=0.95 --height=0.95 --name=lg lazygit
      endif
    endfunction
    ]])
    vim.keymap.set('n', '<leader>gg', ":call Lazygit() <CR>", { desc = "Lazygit lol" })
    vim.keymap.set('t', '<leader>gg', "<C-\\><C-n> :call Lazygit() <CR>", { desc = "Lazygit lol" })

  end
}
