return {
  setup = function(lspconfig, lsp)
    lspconfig.volar.setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      init_options = {
        typescript = {
          tsdk = "/opt/Homebrew/lib/node_modules/typescript-language-server/lib",
        },
      },
    }
  end,
}
