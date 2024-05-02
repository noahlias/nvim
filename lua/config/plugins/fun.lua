return {
  {
    "Eandrju/cellular-automaton.nvim",
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
}
