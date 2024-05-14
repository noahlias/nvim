return {
  setup = function(lspconfig, lsp)
    require("neodev").setup {}
    lspconfig.lua_ls.setup {
      on_attach = function() end,
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
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }
  end,
}
