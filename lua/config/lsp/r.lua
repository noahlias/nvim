return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.r_language_server.setup {
      on_attach = function() end,
      flags = { debounce_text_changes = 150 },
      capabilities = capabilities,
    }
  end,
}
