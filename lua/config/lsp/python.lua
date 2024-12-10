return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.pyright.setup {
      capabilities = capabilities,
      cmd = { "delance-langserver", "--stdio" },
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            typeCheckingMode = "basic",
            inlayHints = {
              callArgumentNames = "off",
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
