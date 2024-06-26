---@type LazyPluginSpec[]
return {
  {
    "Eandrju/cellular-automaton.nvim",
    enabled = false,
  },
  -- 	{
  -- 		'ryoppippi/bad-apple.vim',
  -- 		dependencies = {
  -- 			'vim-denops/denops.vim'
  -- 		}
  -- 	}
  -- }
  {
    "NStefan002/donut.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("donut").setup {
        timeout = 0, --- disable this plugin
        sync_donuts = true,
      }
    end,
  },
}
