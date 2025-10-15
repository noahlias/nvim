---@type vim.lsp.Config
return {
  filetypes = { "c", "cpp", "objc", "objcpp" },
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
    "--clang-tidy",
  },
  on_attach = function(_) end,
}
