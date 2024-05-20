return {
  setup = function(lspconfig, _)
    lspconfig.r_language_server.setup {
      on_attach = function() end,
      flags = { debounce_text_changes = 150 },
    }
  end,
}
