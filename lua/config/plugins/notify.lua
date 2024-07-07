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
      background_color = "#202020",
      minimum_width = 50,
      render = "wrapped-compact",
      stages = "static",
      timeout = 3000,
      top_down = true,
    }
    vim.keymap.set("n", ",;", function()
      require("telescope").extensions.notify.notify {
        layout_strategy = "vertical",
        layout_config = {
          width = 0.7,
          height = 0.8,
          -- preview_height = 0.1,
        },
        wrap_results = true,
        previewer = false,
      }
    end, { noremap = true, silent = true, desc = "Notify Telescope" })
  end,
}
