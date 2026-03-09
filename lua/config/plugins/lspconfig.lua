local M = {}

M.config = {
  ---@type LazyPluginSpec
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
        "williamboman/mason.nvim",
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "ray-x/lsp_signature.nvim", event = "LspAttach" },
      "b0o/SchemaStore.nvim",
    },

    config = function()
      require("mason").setup {}

      local lspconfig = require "lspconfig"
      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require "config.capabilities"
      )
      lsp_defaults.on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end

      require "config.lsp"
    end,
  },
}

return M
