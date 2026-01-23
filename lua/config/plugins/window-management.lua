---@type LazyPluginSpec[]
return {
  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = true,
    event = { "WinNew", "WinLeave" },
    opts = {
      animate = {
        enabled = true,
      },
    },
  },
  {
    "dhruvasagar/vim-zoom",
    event = "VeryLazy",
  },
}
