---@type LazyPluginSpec
return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("tailwind-tools").setup {}
  end,
}
