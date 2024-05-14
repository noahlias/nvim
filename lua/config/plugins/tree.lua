return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    require("mini.files").setup()
    vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "File Explorer" })
  end,
}
