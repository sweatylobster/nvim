return {
  { dir = "~/code/nvim-plugins/aguila.nvim",
    enabled = true,
    init = function ()
      require("aguila").setup()
    end
  },
  { dir = "~/code/nvim-plugins/zettelkasten.nvim", enabled = false },
}
