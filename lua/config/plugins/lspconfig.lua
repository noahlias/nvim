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

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps { buffer = bufnr }
        client.server_capabilities.semanticTokensProvider = nil
        require("config.plugins.autocomplete").configfunc()
        require("lsp_signature").on_attach(F.signature_config, bufnr)
        local diagnostic_signs = require("utils.static").icons.diagnostics

        vim.diagnostic.config {
          severity_sort = true,
          underline = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = diagnostic_signs.DiagnosticSignError,
              [vim.diagnostic.severity.WARN] = diagnostic_signs.DiagnosticSignWarn,
              [vim.diagnostic.severity.HINT] = diagnostic_signs.DiagnosticSignHint,
              [vim.diagnostic.severity.INFO] = diagnostic_signs.DiagnosticSignInfo,
            },
          },
          virtual_text = false,
          update_in_insert = false,
          float = true,
          virtual_lines = false,
        }
      end)

      lsp.set_server_config {
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      }

      local lspconfig = require "lspconfig"

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
