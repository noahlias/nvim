local M = {}

local F = {}

M.config = {
  ---@type LazyPluginSpec
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        opts = {
          use_diagnostic_signs = true,
          action_keys = {
            close = "<esc>",
            previous = "u",
            next = "e",
          },
          modes = {
            lsp = {
              win = { position = "right" },
            },
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
      },
      {
        "williamboman/mason.nvim",
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "ray-x/lsp_signature.nvim", event = "LspAttach" },
      "b0o/SchemaStore.nvim",
      -- "mjlbach/lsp_signature.nvim",
      { "airblade/vim-rooter" },
    },

    config = function()
      local lsp = require "lsp-zero"
      M.lsp = lsp

      require("mason").setup {}
      require("mason-lspconfig").setup {
        -- 'tsserver',
        "gopls",
        "jsonls",
        "html",
        "clangd",
      }

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps { buffer = bufnr }
        client.server_capabilities.semanticTokensProvider = nil
        require("config.plugins.autocomplete").configfunc()
        require("lsp_signature").on_attach(F.signature_config, bufnr)

        vim.diagnostic.config {
          severity_sort = true,
          underline = true,
          signs = true,
          virtual_text = false,
          update_in_insert = false,
          float = true,
        }
      end)

      lsp.set_sign_icons {
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      }

      lsp.set_server_config {
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      }

      local lspconfig = require "lspconfig"

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            hint = {
              enable = true,
              setType = true,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
              postfix = ".",
              showWord = "Disable",
              workspaceWord = false,
            },
          },
        },
      }
      --- NOTE: This is for sourcekit lsp
      --  lspconfig.sourcekit.setup {
      --   -- capabilities = {
      --   --   workspace = {
      --   --     didChangeWatchedFiles = {
      --   --       dynamicRegistration = true,
      --   --     },
      --   --   },
      --   -- },
      -- }
      require("config.lsp.json").setup(lspconfig, lsp)
      require("config.lsp.flutter").setup(lsp)
      require("config.lsp.html").setup(lspconfig, lsp)
      require("config.lsp.c").setup(lspconfig, lsp)
      require("config.lsp.python").setup(lspconfig, lsp)
      require("config.lsp.zig").setup(lspconfig, lsp)
      require("config.lsp.yaml").setup(lspconfig, lsp)
      require("config.lsp.gleam").setup(lspconfig, lsp)
      require("config.lsp.r").setup(lspconfig, lsp)
      require("config.lsp.go").setup(lspconfig, lsp)
      require("config.lsp.vue").setup(lspconfig, lsp)

      -- TODO: need to add other languages server
      ---Odin LSP
      lspconfig.ols.setup {}
      lspconfig.texlab.setup {}
      lspconfig.elixirls.setup {
        server_capabilities = {
          -- completionProvider = true,
          -- definitionProvider = false,
          documentFormattingProvider = false,
        },
      }
      lspconfig.svelte.setup {}
      ---bashls
      lspconfig.bashls.setup {}

      lspconfig.ocamllsp.setup {
        settings = {
          codelens = { enable = true },
          inlayHints = { enable = true },
        },
      }
      lspconfig.tinymist.setup {
        single_file_support = true,
        root_dir = function()
          return vim.fn.getcwd()
        end,
        settings = {
          --NOTE: maybe need to change this to auto export
          exportPdf = "never",
          formatterMode = "typstyle",
        },
      }
      lspconfig.tailwindcss.setup {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "tmpl",
        },
      }
      lspconfig.ruff.setup {
        on_attach = function(client, bufnr)
          if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "debug",
            logFile = "~/.local/state/nvim/ruff.log",
          },
        },
      }
      lsp.setup()
      require("fidget").setup {}

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      F.configureDocAndSignature()
      F.configureKeybinds()
    end,
  },
}

F.configureDocAndSignature = function()
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      -- silent = true,
      focusable = false,
      border = "rounded",
      zindex = 60,
    })
end

local documentation_window_open_index = 0
local function show_documentation()
  documentation_window_open_index = documentation_window_open_index + 1
  local current_index = documentation_window_open_index
  ---@diagnostic disable-next-line: lowercase-global
  documentation_window_open = true
  vim.defer_fn(function()
    if current_index == documentation_window_open_index then
      ---@diagnostic disable-next-line: lowercase-global
      documentation_window_open = false
    end
  end, 500)
  vim.lsp.buf.hover()
end

F.configureKeybinds = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local opts = { buffer = event.buf, noremap = true, nowait = true }

      vim.keymap.set("n", "<leader>lh", show_documentation, {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Hover documentation",
      })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set(
        "n",
        "gD",
        ":tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>",
        opts
      )
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("i", "<c-f>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Rename",
      })
      vim.keymap.set(
        "n",
        "<leader>td",
        "<cmd>Trouble diagnostics toggle<cr>",
        opts
      )

      vim.keymap.set(
        "n",
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        {
          buffer = event.buf,
          noremap = true,
          nowait = true,
          desc = "Symbols (Trouble)",
        }
      )

      vim.keymap.set(
        "n",
        "<leader>tS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        {
          buffer = event.buf,
          noremap = true,
          nowait = true,
          desc = "LSP references/definitions/... (Trouble)",
        }
      )
      -- keymap for toggle inlay hints
      vim.keymap.set("n", "<leader>li", function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf },
          { bufnr = event.buf }
        )
      end, {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Toggle inlay hints",
      })
      --NOTE: neovim 0.10 add [ d and ] d for diagnostic navigation
    end,
  })
end

return M
