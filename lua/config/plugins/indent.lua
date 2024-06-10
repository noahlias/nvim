---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    branch = "dev",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          style = {
            { fg = "#806d9c" },
            { fg = "#c21f30" },
          },
        },
        indent = {
          enable = true,
          chars = { "│" },
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        exclude_filetypes = {
          ["copilot-chat"] = true,
          ["neotest-outputpanel"] = true,
          ["neotest-summary"] = true,
        },
      }
    end,
  },
}
