return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>",
	{silent = true, noremap = true, desc = "[T]odo [T]rouble"}
      ),
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
	{silent = true, noremap = true, desc = "TroubleToggle"}
      ),
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
	{silent = true, noremap = true, desc = "Trouble [W]orkspace"}
      ),
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
	{silent = true, noremap = true, desc = "[D]ocument diagnostics"}
      ),
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
	{silent = true, noremap = true, desc = "[L]ocation list"}
      ),
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
	{silent = true, noremap = true, desc = "[Q]uick fix"}
      ),
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
	{silent = true, noremap = true, desc = "[G]et [R]eferences"}
      ),
    }
  end
}
