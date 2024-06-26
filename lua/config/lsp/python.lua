return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.pyright.setup {
      on_attach = function() end,
      capabilities = capabilities,
      cmd = { "delance-langserver", "--stdio" },
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            ignore = { "*" },
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
