return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.jsonls.setup {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      capabilities = capabilities,
    }
  end,
}
