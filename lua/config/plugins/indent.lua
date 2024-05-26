local utils = require "utils"
---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {

        chunk = {
          enable = true,
          style = {
            { fg = "#806d9c" },
          },
          --NOTE: Maybe this is useful
          textobject = "",
        },
        indent = {
          enable = true,
          chars = { "│", "¦", "┆", "┊" },
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        supported_filetypes = {
          "*.zig",
        },
      }
    end,
  },
}
