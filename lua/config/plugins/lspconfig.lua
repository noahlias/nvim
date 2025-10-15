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
    end,
  },
}

return M
