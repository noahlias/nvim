---@type vim.lsp.Config
return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  settings = {
    logFile = "~/.local/state/nvim/ruff.log",
    organizeImports = true,
  },
  root_markers = {
    "pyproject.toml",
    "setup.cfg",
    "setup.py",
    ".ruff.toml",
    "ruff.toml",
    "requirements.txt",
    ".git",
  },
}
