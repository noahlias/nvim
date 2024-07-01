---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      format_on_save = function(bufnr)
        ---NOTE: disable autoformat for minifiles
        local ignore_filetypes = { "minifiles" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = function(bufnr)
          if
            require("conform").get_formatter_info("ruff_format", bufnr).available
          then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
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
        sh = { "shfmt" },
        r = { "my_styler" },
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
        my_styler = {
          command = "R",
          -- A list of strings, or a function that returns a list of strings
          -- Return a single string instead of a list to run the command in a shell
          args = {
            "-s",
            "-e",
            "styler::style_file(commandArgs(TRUE)[1])",
            "--args",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    }
  end,
}
