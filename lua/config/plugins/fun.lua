---@type LazyPluginSpec[]
return {
  {
    "Eandrju/cellular-automaton.nvim",
    enabled = false,
  },
  {
    "NStefan002/donut.nvim",
    version = "*",
    cmd = "Donut",
    event = "VeryLazy",
    config = function()
      require("donut").setup {
        timeout = 0, --- disable this plugin
        sync_donuts = true,
      }
    end,
  },
  {
    "chrishrb/gx.nvim",
    submodules = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "gx",
        function()
          vim.cmd.Browse()
        end,
      },
    },
    cmd = {
      "Browse",
    },
    opts = {},
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    config = function()
      require("better_escape").setup {
        ---NOTE: only work in insertmode
        default_mappings = false,
        mappings = {
          i = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
        },
      }
    end,
  },
}
