return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function ()
	vim.keymap.set("n", "<leader>mm", ":MarkdownPreview <cr>")
	vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop <cr>")
	vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle <cr>")
    end
}
