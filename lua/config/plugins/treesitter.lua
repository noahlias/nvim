---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    priority = 1000,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "LiadOz/nvim-dap-repl-highlights",
    },
    config = function()
      require("nvim-dap-repl-highlights").setup()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "query",
          "typescript",
          "dart",
          "java",
          "c",
          "prisma",
          "bash",
          "go",
          "lua",
          "html",
          "vim",
          "cpp",
          "javascript",
          "norg",
          "org",
          "vimdoc",
          "haskell",
          "rust",
          "markdown",
          "markdown_inline",
          "yaml",
          "python",
          "dockerfile",
          "latex",
          "tsx",
          "dap_repl",
        },
        highlight = {
          enable = true,
          -- additional_vim_regex_highlighting = false,
          -- use_languagetree = false,
          disable = function(_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size =
              vim.api.nvim_call_function("getfsize", { buf_name })
            return file_size > 256 * 1024 or vim.bo.ft == "latex"
          end,
        },
        ident = {
          enable = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-n>",
            node_incremental = "<c-n>",
            node_decremental = "<c-h>",
            scope_incremental = "<c-l>",
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      local tscontext = require "treesitter-context"
      tscontext.setup {
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
      end, { silent = true })
    end,
  },
}
