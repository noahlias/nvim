---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>fo",
      function()
        require("conform").format { lsp_fallback = true, async = true }
      end,
      desc = "Format Document",
      mode = { "n", "v" },
    },
  },
  config = function()
    require("conform").setup {
      format_on_save = function(bufnr)
        ---NOTE: disable autoformat for minifiles
        local ignore_filetypes = { "minifiles" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
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
        markdown = { "autocorrect", "prettier", "markdownlint-cli2" },
        sh = { "shfmt" },
        r = { "my_styler" },
        toml = { "taplo" },
        sql = { "sqlfluff" },
      },
      -- NOTE: mayebe need to fix this with path variable  <04/25, 2024, noahlias> --
      formatters = {
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        isort = {
          command = "~/.rye/shims/isort",
        },
        black = {
          command = "~/.rye/shims/black",
        },
        ruff = {
          command = "~/.rye/shims/ruff",
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
