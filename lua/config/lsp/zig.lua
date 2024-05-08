return {
  setup = function(lspconfig, _)
    lspconfig.zls.setup {
      on_attach = function() end,
      cmd = { "zls" },
      filetypes = { "zig" },
    }
  end,
}
