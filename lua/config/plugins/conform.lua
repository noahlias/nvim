return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function()
    require("conform").setup {
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort", "ruff" },
        go = { "goimports", "gofmt" },

        html = { "prettier" },
        css = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- vue = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "markdownlint" },
        sh = { "shellcheck", "shfmt" },
      },
      -- NOTE: mayebe need to fix this with path variable  <04/25, 2024, noahlias> --
      formatters = {
        isort = {
          command = "/Users/alias/.rye/shims/isort",
        },
        black = {
          command = "/Users/alias/.rye/shims/black",
        },
        ruff = {
          command = "/Users/alias/.rye/shims/ruff",
        },
      },
    }
  end,
}
