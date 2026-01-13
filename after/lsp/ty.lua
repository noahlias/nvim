---@type vim.lsp.Config
return {
  root_pattern = { "typroject.toml", "pyproject.toml" },
  settings = {
    ty = {
      disableLanguageServices = true,
    },
  },
}
