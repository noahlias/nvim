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
		version = false,
		config = function()
			require('mini.trailspace').setup()
		end
	},
}
