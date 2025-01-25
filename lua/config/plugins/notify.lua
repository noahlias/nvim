---@type LazyPluginSpec
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    vim.notify = notify

    ---@diagnostic disable-next-line: missing-fields
    notify.setup {
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      minimum_width = 50,
      render = "simple",
      stages = "static",
      timeout = 3000,
      top_down = true,
    }
    vim.keymap.set("n", ",;", function()
      require("notify.integrations.fzf").open {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.7,
          height = 0.8,
          -- preview_height = 0.1,
        },
        wrap_results = true,
      }
    end, { noremap = true, silent = true, desc = "Notify Fzf" })
  end,
}
