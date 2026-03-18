---@type vim.lsp.Config
return {
  settings = {
    ---@type lspconfig.settings.lua_ls
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
