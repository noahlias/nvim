vim.lsp.enable {
  "copilot",
  -- "ty",
  "lua_ls",
  "clangd",
  "zls",
  "jsonls",
  "vtsls",
  "ruff",
  "pyright",
  "yamlls",
  "harper_ls",
  "html",
  "gleam",
  "vue_ls",
  -- "sourcekit-lsp",
  "ols",
  "bashls",
  "ocamllsp",
  "svelte",
  "kulala_ls",
  "tinymist",
  "glsl_analyzer",
  "ruby_lsp",
  "tailwindcss",
  "ols",
  "texlab",
  "elixirls",
  "r_language_server",
  "gopls",
}
vim.lsp.inline_completion.enable()
vim.keymap.set("i", "<C-C>", function()
  if not vim.lsp.inline_completion.get() then
    return "<C-C>"
  end
end, {
  expr = true,
  replace_keycodes = true,
  desc = "Get the current inline completion",
})
