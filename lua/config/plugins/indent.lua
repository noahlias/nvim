---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    -- branch = "dev",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {

        chunk = {
          enable = true,
          style = {
            { fg = "#806d9c" },
            { fg = "#c21f30" },
          },
          --NOTE: Maybe this is useful
          textobject = "",
        },
        indent = {
          enable = true,
          chars = { "│" },
          exclude_filetypes = {
            ["copilot-chat"] = true,
          },
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        exclude_filetypes = {
          ["copilot-chat"] = true,
        },
      }
    end,
  },
}
