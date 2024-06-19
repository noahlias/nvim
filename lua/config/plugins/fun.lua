---@type LazyPluginSpec[]
return {
  {
    "Eandrju/cellular-automaton.nvim",
    enabled = true,
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
  {
    "tamton-aquib/duck.nvim",
    enabled = false,
    config = function()
      vim.keymap.set("n", "<leader>du", function()
        require("duck").hatch "🐈"
      end, { desc = "Hatch a duck" })
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, { desc = "Cook a duck" })
      vim.keymap.set("n", "<leader>da", function()
        require("duck").cook_all()
      end, { desc = "Cook all ducks" })
    end,
  },
}
