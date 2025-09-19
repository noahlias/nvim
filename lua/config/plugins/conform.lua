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
        if
          vim.g.disable_autoformat == false
          and vim.b[bufnr].disable_autoformat == false
        then
          return { timeout_ms = 1000, lsp_format = "fallback" }
        end

        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Get disabled workspace paths from environment variables
        local function get_disabled_workspaces()
          local paths = {}
          -- Read from NVIM_DISABLED_FORMAT_PATHS environment variable
          -- Paths should be separated by colons (:) like PATH variable
          local env_paths = vim.env.NVIM_DISABLED_FORMAT_PATHS
          if env_paths then
            for path in string.gmatch(env_paths, "[^:]+") do
              -- Expand ~ to home directory if present
              path = path:gsub("^~", vim.env.HOME or "")
              table.insert(paths, path)
            end
          end
          return paths
        end

        -- Check if current file is in a disabled workspace
        local current_file = vim.api.nvim_buf_get_name(bufnr)
        local disabled_workspaces = get_disabled_workspaces()
        for _, path in ipairs(disabled_workspaces) do
          if current_file:find(path, 1, true) then
            return
          end
        end
        ---NOTE: disable autoformat for minifiles

        local ignore_filetypes = { "minifiles" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
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
        just = { "just" },
        markdown = { "autocorrect", "prettier", "markdownlint-cli2" },
        sh = { "shfmt" },
        r = { "r_format" },
        toml = { "taplo" },
        -- http = { "kulala-fmt" },
        mysql = { "sqruff" },
        ruby = { "rubyfmt" },
        rust = { "rustfmt" },
        cpp = { "clang_format" },
        cmake = { "cmake_format" },
        -- New API
        ["_"] = { "trim_whitespace", lsp_format = "last" },
      },
      -- NOTE: mayebe need to fix this with path variable  <04/25, 2024, noahlias> --
      formatters = {
        ["markdownlint-cli2"] = {
          command = "markdownlint-cli2",
          args = { "--stdin" },
          require_cwd = false,
        },
        cmake_format = {
          command = "cmake-format",
          args = { "-" },
          require_cwd = false,
        },
        sqruff = {
          command = "sqruff",
          require_cwd = false,
        },
        r_format = {
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
