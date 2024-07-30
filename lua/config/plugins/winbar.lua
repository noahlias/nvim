---@type LazyPluginSpec
return {
  "Bekaboo/dropbar.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
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
