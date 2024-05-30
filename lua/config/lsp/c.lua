return {
  setup = function(lspconfig, _)
    lspconfig.clangd.setup {
      on_attach = function() end,
      cmd = {
        "clangd",
				"--offset-encoding=utf-16",
        "--background-index",
        "--pch-storage=memory",
        "--all-scopes-completion",
        "--pretty",
        "--header-insertion=never",
        "-j=4",
        "--inlay-hints",
        "--header-insertion-decorators",
        "--function-arg-placeholders",
        "--completion-style=detailed",
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
    }
  end,
}
