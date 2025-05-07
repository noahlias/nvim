return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.html.setup {
      on_attach = function() end,
      capabilities = capabilities,
    }
  end,
}
