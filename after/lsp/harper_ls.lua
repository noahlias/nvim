---@type vim.lsp.Config
return {
  filetypes = { "markdown", "cpp", "rust", "go", "lua" },
  settings = {
    ["harper-ls"] = {
      markdown = {
        ignore_link_title = true,
      },
      isolateEnglish = false,
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
}
