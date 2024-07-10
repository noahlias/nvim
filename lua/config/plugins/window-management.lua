---@type LazyPluginSpec[]
return {
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  {
    "dhruvasagar/vim-zoom",
    event = "VeryLazy",
  },
}
