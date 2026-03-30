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
          vim.fs.joinpath(vim.fn.stdpath "config", "lua"),
          vim.fs.joinpath(vim.fn.stdpath "config", "after"),
          vim.fs.joinpath(vim.fn.stdpath "data", "lazy", "nvim-lspconfig", "lua"),
        },
        checkThirdParty = false,
      },
      diagnostics = {
        disable = { "missing-fields" },
      },
    },
  },
}
