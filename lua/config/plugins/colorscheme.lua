return {
	{
		"theniceboy/nvim-deus",
		enabled = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme deus]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = true,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-storm]])
		end,
		opts = {},
	},
	{
		"savq/melange-nvim",
		enabled = false,
		config = function()
			vim.cmd([[colorscheme melange]])
		end,
	},
}
