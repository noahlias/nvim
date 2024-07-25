---@type LazyPluginSpec
return {
  "nvim-lua/plenary.nvim",
  lazy = true,
  keys = {
    {
      "<leader>hpb",
      function()
        require("plenary.profile").start("profile.log", { flame = true })
      end,
      desc = "Begin profiling",
    },
    {
      "<leader>hpe",
      function()
        require("plenary.profile").stop()
      end,
      desc = "End profiling",
    },
  },
  config = function()
    local wk = require "which-key"
    wk.add {
      { "<leader>hp", group = "profile" },
    }
  end,
}
