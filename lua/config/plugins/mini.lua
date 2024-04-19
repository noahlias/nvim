return {

	{
		'echasnovski/mini.animate',
		enabled = false,
		version = false,
		config = function()
			require('mini.animate').setup()
		end
	},
	{
		'echasnovski/mini.align',
		version = false,
		config = function()
			require('mini.align').setup()
		end
	},
	{
		'echasnovski/mini.trailspace',
		enabled = true,
		version = false,
		config = function()
			local mini = require('mini.trailspace')
			mini.setup({
			})
			vim.api.nvim_set_keymap('n', '<leader>mt', '<cmd>lua MiniTrailspace.trim()<CR>',
				{ noremap = true, silent = true, desc = "trim" })
			vim.api.nvim_set_keymap('n', '<leader>ms', '<cmd>lua MiniTrailspace.trim_last_lines()<CR>',
				{ desc = "trim_last_lines", noremap = true, silent = true })
		end,
	},
	{
		'echasnovski/mini.splitjoin',
		version = false,
		config = function()
			require('mini.splitjoin').setup({
				mappings = {
					toggle = 'gj',
					split = '',
					join = '',
				},
			})
		end
	},
}
