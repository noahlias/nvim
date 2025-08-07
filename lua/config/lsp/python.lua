return {
  setup = function(lspconfig, lsp)
    local capabilities = require "config.capabilities"
    lspconfig.pyright.setup {
      capabilities = {
        textDocument = {
          publishDiagnostics = {
            tagSupport = {
              valueSet = { 2 },
            },
          },
          hover = {
            contentFormat = { "plaintext" },
            dynamicRegistration = true,
          },
        },
      },
      cmd = { "delance-langserver", "--stdio" },
      settings = {
        pyright = {
          disableOrganizeImports = true,
          disableTaggedHints = false,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "standard",
            autoImportCompletions = true,
            diagnosticSeverityOverrides = {
              deprecateTypingAliases = false,
            },
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
