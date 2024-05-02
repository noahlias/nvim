return {
  "hedyhli/outline.nvim",
  keys = {
    { "<leader>ao", "<Cmd>Outline<CR>", desc = "Outline" },
  },
  opts = {
    preview_window = {
      border = "rounded",
      live = true,
    },
    symbols = {
      icon_source = "lspkind",
    },
  },
}
