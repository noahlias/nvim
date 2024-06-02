return {
  setup = function(lspconfig, lsp)
    lspconfig.lua_ls.setup {
      on_attach = function(_, _) end,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = {
              "vim",
              "require",
            },
          },
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }
  end,
}
