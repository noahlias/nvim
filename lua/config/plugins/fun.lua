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
    enabled = false,
    config = true,
    event = "VeryLazy",
  },
}
