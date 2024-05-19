return {
  setup = function(lspconfig, _)
    lspconfig.gleam.setup {
      on_attach = function() end,
      filetypes = { "gleam" },
    }
  end,
}
