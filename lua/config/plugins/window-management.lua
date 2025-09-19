---@type LazyPluginSpec[]
return {
  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    event = { "WinNew", "WinLeave" },
    opts = {
      animate = {
        enabled = false,
      },
    },
  },
  {
    "dhruvasagar/vim-zoom",
    event = "VeryLazy",
  },
}
