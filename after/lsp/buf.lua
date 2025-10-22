---@type vim.lsp.Config
return {
  cmd = { "buf", "lsp", "serve" },
  root_markers = { ".git" },
  filetypes = { "proto" },
}
