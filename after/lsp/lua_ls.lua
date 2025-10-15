---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      hint = {
        enable = true,
        setType = true,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
        postfix = ".",
        showWord = "Disable",
        workspaceWord = false,
      },
      diagnostics = {
        disable = { "missing-fields" },
      },
    },
  },
}
