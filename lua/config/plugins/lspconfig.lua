local M = {}

local F = {}

M.config = {
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      {
        "folke/trouble.nvim",
        -- branch = "dev",
        opts = {
          use_diagnostic_signs = true,
          action_keys = {
            close = "<esc>",
            previous = "u",
            next = "e",
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        event = {
          "Filetype",
        },
        dependencies = {
          {
            "folke/neoconf.nvim",
            event = "BufReadPre",
            config = function()
              require("neoconf").setup()
            end,
          },
        },
      },
      {
        "williamboman/mason.nvim",
        build = function()
          vim.cmd [[MasonInstall]]
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        config = function()
          require("fidget").setup {
            notification = {
              window = {
                winblend = 0,
              },
            },
          }
        end,
      },
      {
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              { path = "luvit-meta/library", words = { "vim%.uv" } },
              "lazy.nvim",
            },
            -- debug = true,
            enabled = function(root_dir)
              return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
            end,
          },
        },
        { "Bilal2453/luvit-meta", lazy = true },
      },
      { "ray-x/lsp_signature.nvim", event = "VeryLazy" },
      "ldelossa/nvim-dap-projects",
      "b0o/SchemaStore.nvim",
      -- "mjlbach/lsp_signature.nvim",
      "airblade/vim-rooter",
    },

    config = function()
      local lsp = require("lsp-zero").preset {}
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
        -- FIX: it's too slow for me
        -- vim.lsp.inlay_hint.enable()

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

      lspconfig.lua_ls.setup {}
      --- NOTE: This is for sourcekit lsp
      -- lspconfig.sourcekit.setup {
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
      ---NOTE: This lsp not working
      -- require("config.lsp.vue").setup(lspconfig, lsp)
      require("config.lsp.gleam").setup(lspconfig, lsp)
      require("config.lsp.r").setup(lspconfig, lsp)

      lspconfig.ols.setup {}
      lspconfig.texlab.setup {}
      lsp.setup()
      require("fidget").setup {}

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      require("nvim-dap-projects").search_project_config()

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
  local group =
    vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float {
        scope = "cursor",
        focusable = false,
        zindex = 10,
        close_events = {
          "CursorMoved",
          "CursorMovedI",
          "BufHidden",
          "InsertCharPre",
          "InsertEnter",
          "WinLeave",
          "ModeChanged",
        },
      }
    end,
    group = group,
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

      vim.keymap.set("n", "<leader>hh", show_documentation, {
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
      vim.keymap.set("n", "<leader>,", vim.lsp.buf.code_action, opts)
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
      vim.keymap.set("n", "<leader>ih", function()
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
