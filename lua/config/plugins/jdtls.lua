---@type LazyPluginSpec
return {
  "mfussenegger/nvim-jdtls",
  event = {
    "BufRead *.java",
    "BufNewFile *.java",
  },
}
