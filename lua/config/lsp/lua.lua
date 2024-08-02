return {
  setup = function(lspconfig, lsp)
    lspconfig.lua_ls.setup {
      on_attach = function(_, _) end,
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
        },
      },
    }
  end,
}
