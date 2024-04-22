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
		"savq/melange-nvim",
		enabled = true,
		config = function()
			vim.cmd([[colorscheme melange]])
		end,
	},
}
