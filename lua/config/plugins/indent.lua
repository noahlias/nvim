return {
  {
    "shellRaining/hlchunk.nvim",
    ft = {
      "lua",
      "sh",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "c",
      "cpp",
      "rust",
      "python",
      "java",
      "go",
      "html",
      "css",
      "scss",
      "dockerfile",
      "zig",
      "haskell",
    },
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
      require("hlchunk").setup {
        chunk = {
          notify = false,
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#806d9c" },
          },
        },
        indent = {
          chars = { "│", "¦", "┆", "┊" },
          use_treesitter = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
        },
      }
    end,
  },
  -- {
  -- 	"lukas-reineke/indent-blankline.nvim",
  -- 	opts = {
  -- 		show_current_context = true,
  -- 		show_current_context_start = false,
  -- 	}
  -- },
}
