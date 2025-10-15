---@type vim.lsp.Config
return {
  cmd = { "zls" },
  filetypes = { "zig" },
  settings = {
    zls = {
      inlay_hints_hide_redundant_param_names = true,
      inlay_hints_hide_redundant_param_names_last_token = true,
      warn_style = true,
      highlight_global_var_declarations = true,
    },
  },
}
