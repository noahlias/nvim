---@type LazyPluginSpec
return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = {
    "BufRead *.jsx,,*tsx,*.vue,*.html,*.css,*.scss,*.sass,*.less,*.stylus",
    "BufNewFile *.jsx,*tsx,*.vue,*.html,*.css,*.scss,*.sass,*.less,*.stylus",
  },
  config = function()
    require("tailwind-tools").setup {}
  end,
}
