return {
  setup = function(lspconfig, lsp)
    lspconfig.sourcekit.setup {
      on_attach = function() end,
      cmd = { "sourcekit-lsp" },
      filetypes = { "swift" },
    }
  end,
}
