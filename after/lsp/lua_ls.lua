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
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      diagnostics = {
        disable = { "missing-fields" },
      },
    },
  },
}
