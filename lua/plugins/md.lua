return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  keys = {
    {
      mode = "n",
      "<leader>mm",
      ":MarkdownPreview <cr>",
      desc = "",
    },
    {
      "<leader>ms",
      ":MarkdownPreviewStop <cr>",
      mode = "n",
      desc = "",
    },
    {
      "<leader>mt",
      ":MarkdownPreviewToggle <cr>",
      mode = "n",
      desc = "",
    },
  },
}
