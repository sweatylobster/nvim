return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function ()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format the buffer :)",
      }
    },
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "jq" },
			lua = { "stylua" },
			markdown = { "prettier" },
			nix = { "nixpkgs_fmt" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			sql = { "pg_format", "sql_formatter" },
			yaml = { "prettier" },
			zig = { "zigfmt" },
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
