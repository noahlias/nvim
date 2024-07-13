return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.volar.setup {
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
      end,
      capabilities = capabilities,
      ft = { "vue" },
    }
  end,
}
