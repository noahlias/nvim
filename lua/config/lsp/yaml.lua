return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          keyOrdering = false,
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    }
  end,
}
