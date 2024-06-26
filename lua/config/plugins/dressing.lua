---@type LazyPluginSpec
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      border = "rounded",
    },
    select = {
      backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
      builtin = {
        border = "rounded",
      },
      fzf_lua = {
        winopts = {
          height = 0.4,
        },
      },
    },
  },
}
