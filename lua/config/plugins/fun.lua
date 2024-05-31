return {
  {
    "Eandrju/cellular-automaton.nvim",
    enabled = false,
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
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
  },
}
