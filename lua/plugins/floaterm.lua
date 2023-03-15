return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader><esc>', ':FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>:FloatermToggle --name=main <CR>', { desc = "Quick terminal browser" })
    -- Maybe edit to <leader>fsi for ipython
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=repl <CR>", { desc = "Send visual selection to ipython" })
    --TODO: Make a keymap to send *ONE* approved of ipython input to *A* buffer
    --NOTE: Strategy is probably to:
    -- list and name buffer windows
    -- filter for .py
    -- display it in a telescope list
    -- paste at current cursor location OR end of file OR marker
    -- NOTE: Marker strategy would simply take the marker as argument when in floaterm
    -- vim.keymap.set("t", "<leader>fr", "", { desc = "[F]loaterm [R]etrieve/[F]etch to buffer such-and-such"})
    --TODO: Emend this to do several commands
    -- FIX: But I only need to do this for ipython commands so far.
    -- Therefore I'll just activate %autosource so that ipython resources the edited buffer every time the function is called.
    -- This means that nvim is for editing with all comfort, and ipython for evaluatin n visualizin commands thank god
    -- Now the question is whether fzf-lua is going to be useful for this project. But Telescope didn't come to mind
    -- But wait also I don't need the past 15 lines because FloatermSend is to send functions
    -- BRUH

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
