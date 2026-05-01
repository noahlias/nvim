---@type LazyPluginSpec
return {
  "Bekaboo/dropbar.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    bar = {
      update_events = {
        buf = {
          "OptionSet",
          "FileChangedShellPost",
          "TextChanged",
          "ModeChanged",
        },
      },
    },
    sources = {
      path = {
        modified = function(sym)
          return sym:merge {
            name = sym.name .. " [+]",
            name_hl = "DiffAdded",
          }
        end,
      },
    },
  },
}
