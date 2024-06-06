return {
  "lervag/vimtex",
  config = function ()
    vim.g.vimtex_view_method = "sioyek"
    vim.g.tex_flavor = "lualatex"
    vim.g.vimtex_quickfix_mode = 0
    -- vim.o.conceallevel = 1  --always a terrible default; just use zathura!
    vim.g.tex_conceal='abdmg'
    -- vim.keymap.set('n', '<leader>lp', function()
    --   local filepath = vim.fn.expand('%:r')..".pdf"
    --   os.execute('lpr '..filepath) end)
  end
}
