return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.pyright.setup {
      on_attach = function() end,
      capabilities = capabilities,
      cmd = { "delance-langserver", "--stdio" },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
            inlayHints = {
              callArgumentNames = "partial",
              functionReturnTypes = true,
              pytestParameters = true,
              variableTypes = true,
            },
          },
        },
      },
    }
  end,
}
