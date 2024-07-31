---@type LazyPluginSpec
return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("scrollbar").setup {
      show = true,
      max_lines = 50000,
      handle = {
        text = " ",
        color = "#928374",
        hide_if_all_visible = true,
      },
      marks = {
        Search = { color = "yellow" },
        Misc = { color = "purple" },
      },
      handlers = {
        cursor = false,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = true,
      },
    }
  end,
}
