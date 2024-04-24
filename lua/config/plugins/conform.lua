return {
	'stevearc/conform.nvim',
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		lua = { "stylua" },
		python = { "black", "isort", "ruff" },
		go = { "goimports", "gofmt" },

		html = { "prettier" },
		css = { "prettier" },
		less = { "prettier" },
		scss = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "markdownlint" }
	},
	config = function()
		require("conform").setup()
	end,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format { lsp_fallback = true }
			end,
			desc = "Format Document",
			mode = { "n", "v" }
		},
	},
}
