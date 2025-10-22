---@type vim.lsp.Config
return {
  init_options = {
    logLevel = "debug",
  },
  root_pattern = { "typroject.toml", "pyproject.toml" },
  settings = {
    ty = {
      disableLanguageServices = true,
      diagnosticMode = "openFilesOnly",
    },
  },
}
