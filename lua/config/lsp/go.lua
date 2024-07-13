return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.gopls.setup {
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
      end,
      capabilities = capabilities,
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    }
  end,
}
