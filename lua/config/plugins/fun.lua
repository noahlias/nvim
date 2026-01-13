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
        "<cmd>Browse<CR>",
        mode = { "n", "x" },
      },
    },
    cmd = {
      "Browse",
    },
    opts = {
      open_browser_app = "gx-open",
    },
  },
  {
    "chrisgrieser/nvim-early-retirement",
    enabled = true,
    config = true,
    event = "VeryLazy",
  },
}
