---@type vim.lsp.Config
return {
  filetypes = { "ruby" },
  init_options = {
    formatter = "standard",
    linters = { "standard" },
  },
  addonSettings = {
    ["Ruby LSP Rails"] = {
      enablePendingMigrationsPrompt = false,
    },
  },
}
