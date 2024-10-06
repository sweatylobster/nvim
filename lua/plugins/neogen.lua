return {
  "danymat/neogen",
  config = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
  opts = {
    snippet_engine = "luasnip",
  },
  keys = {
    {
      "<leader>gco",
      function()
        require("neogen").generate()
      end,
      mode = "n",
    },
  },
}
