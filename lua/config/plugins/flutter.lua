return {
  "theniceboy/flutter-tools.nvim",
  ft = "dart",
  event = {
    "BufRead *.dart",
    "BufNewFile *.dart",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
}
