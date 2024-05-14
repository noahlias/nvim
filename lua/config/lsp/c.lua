return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    capabilities = vim.tbl_extend("force", capabilities, {
      offsetEncoding = "utf-16",
    })
    lspconfig.clangd.setup {
      on_attach = function() end,
      cmd = {
        "clangd",
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
      capabilities = capabilities,
    }
  end,
}
