local M = {}

local F = {}

M.config = {
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
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
        tag = "legacy",
      },
      {
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              vim.env.LAZY .. "/luvit-meta/library", -- see below
              vim.env.LAZY .. "/lazy.nvim",
            },
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

      lsp.ensure_installed {
        -- 'tsserver',
        "gopls",
        "jsonls",
        "html",
        "clangd",
      }

      -- F.configureInlayHints()

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

      lsp.format_on_save {
        format_opts = {
          -- async = false,
          -- timeout_ms = 10000,
        },
      }

      local lspconfig = require "lspconfig"

      -- require("config.lsp.lua").setup(lspconfig, lsp)
      require("config.lsp.json").setup(lspconfig, lsp)
      require("config.lsp.flutter").setup(lsp)
      require("config.lsp.html").setup(lspconfig, lsp)
      require("config.lsp.c").setup(lspconfig, lsp)
      require("config.lsp.python").setup(lspconfig, lsp)
      require("config.lsp.zig").setup(lspconfig, lsp)
      require("config.lsp.yaml").setup(lspconfig, lsp)
      require("config.lsp.vue").setup(lspconfig, lsp)
      require("config.lsp.gleam").setup(lspconfig, lsp)
      require("config.lsp.r").setup(lspconfig, lsp)

      lspconfig.ols.setup {}
      lsp.setup()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup {
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        }
      end
      require("fidget").setup {}

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("nvim-dap-projects").search_project_config()

      F.configureDocAndSignature()
      F.configureKeybinds()

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      -- 	pattern = "*",
      -- 	callback = function()
      -- 		if format_on_save_filetypes[vim.bo.filetype] then
      -- 			local lineno = vim.api.nvim_win_get_cursor(0)
      -- 			vim.lsp.buf.format({ async = false })
      -- 			pcall(vim.api.nvim_win_set_cursor, 0, lineno)
      -- 		end
      -- 	end,
      -- })
    end,
  },
}

F.configureDocAndSignature = function()
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    -- silent = true,
    focusable = false,
    border = "rounded",
    zindex = 60,
  })
  local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(0, {
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
      })
    end,
    group = group,
  })
  -- vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
  -- 	pattern = "*",
  -- 	command = "silent! lua vim.lsp.buf.signature_help()",
  -- 	group = group,
  -- })

  -- F.signature_config = {
  -- 	bind = false,
  -- 	floating_window = true,
  -- 	hint_inline = function() return false end,
  -- 	handler_opts = {
  -- 		border = "rounded"
  -- 	}
  -- }
  -- local lspsignature = require('lsp_signature')
  -- lspsignature.setup(F.signature_config)
end

local documentation_window_open_index = 0
local function show_documentation()
  documentation_window_open_index = documentation_window_open_index + 1
  local current_index = documentation_window_open_index
  documentation_window_open = true
  vim.defer_fn(function()
    if current_index == documentation_window_open_index then
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

      vim.keymap.set("n", "<leader>h", show_documentation, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", ":tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>", opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("i", "<c-f>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>,", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", opts)

      vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Symbols (Trouble)",
      })

      vim.keymap.set("n", "<leader>tS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "LSP references/definitions/... (Trouble)",
      })
      -- keymap for toggle inlay hints
      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf })
      end, {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Toggle inlay hints",
      })
      --NOTE: neovim 0.10 add [ d and ] d for diagnostic navigation
      -- vim.keymap.set("n", "<leader>-", vim.diagnostic.goto_prev, opts)
      -- vim.keymap.set("n", "<leader>=", vim.diagnostic.goto_next, opts)
    end,
  })
end

return M
