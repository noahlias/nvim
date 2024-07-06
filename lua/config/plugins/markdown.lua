---@type LazyPluginSpec[]
return {
  {
    "instant-markdown/vim-instant-markdown",
    ft = { "markdown" },
    build = "yarn install",
    config = function()
      vim.g.instant_markdown_autostart = 0
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    submodules = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
