---@type LazyPluginSpec[]
return {
  {
    "Eandrju/cellular-automaton.nvim",
    enabled = false,
  },
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
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
