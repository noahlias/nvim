---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    -- branch = "dev",
    commit = "a7cb0da6286156c4e601c5d0f47a82bda25b37a9",
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
