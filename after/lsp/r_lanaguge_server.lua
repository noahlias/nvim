---@type vim.lsp.Config
local capabilities = require "config.capabilities"
return {
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
}
