---@type LazyPluginSpec
return {
  "luckasRanarison/tailwind-tools.nvim",
  ft = {
    "javascriptreact",
    "typescriptreact",
    "html",
    "markdown",
    "mdx",
    "vue",
    "svelte",
  },
  opts = {
    conceal = {
      symbol = "…",
    },
  },
  config = function(_, opts)
    require("tailwind-tools").setup(opts)
  end,
}
