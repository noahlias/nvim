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
    -- "OXY2DEV/markview.nvim",
    dir = "~/.config/nvim/dev/markview.nvim",
    ft = { "markdown" },
    name = "markview",
    dev = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("markview").setup()
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Mandatory
      "nvim-tree/nvim-web-devicons", -- Optional but recommended
    },
    config = function()
      require("render-markdown").setup {}
    end,
  },
}
