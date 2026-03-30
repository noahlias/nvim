---@type vim.lsp.Config
return {
  filetypes = { "python" },
  cmd = { "delance-langserver", "--stdio" },
  settings = {
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
        autoFormatStrings = true,
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
