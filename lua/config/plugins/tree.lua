---@type LazyPluginSpec
return {
  "echasnovski/mini.files",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.files").setup {
      options = {
        use_as_default_explorer = false,
      },
    }
    vim.keymap.set(
      "n",
      "<leader>te",
      "<cmd>lua MiniFiles.open()<CR>",
      { desc = "File Explorer" }
    )
  end,
}
