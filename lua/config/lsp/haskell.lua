return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.hls.setup {
      on_attach = function() end,
      cmd = { "/Users/alias/.ghcup/hls/1.10.0.0/bin/haskell-language-server-wrapper", "--lsp" },
      capabilities = capabilities,
    }
  end,
}
