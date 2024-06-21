---@type LazyPluginSpec
return {
  "shellRaining/hlchunk.nvim",
  enabled = true,
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
      --FIXME: Some bug in the new version
      indent = {
        chars = { "│ " },
        enable = true,
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
}
