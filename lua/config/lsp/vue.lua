return {
  setup = function(lspconfig, lsp)
    lspconfig.volar.setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
    }
  end,
}
