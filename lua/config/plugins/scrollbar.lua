---@type LazyPluginSpec
return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "kevinhwang91/nvim-hlslens",
  },
  config = function()
    require("scrollbar.handlers.search").setup {}
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar").setup {
      show = true,
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
