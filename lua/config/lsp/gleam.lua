return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.gleam.setup {
      on_attach = function() end,
      filetypes = { "gleam" },
      capabilities = capabilities,
    }
  end,
}
