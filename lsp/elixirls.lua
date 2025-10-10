---@type vim.lsp.Config

local mason_package_path = vim.fn.stdpath "data" .. "/mason/packages/"
return {
  cmd = {
    vim.fs.joinpath(mason_package_path, "elixir-ls", "language_server.sh"),
  },
  server_capabilities = {
    documentFormattingProvider = false,
  },
}
