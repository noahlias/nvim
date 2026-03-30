return {
  -- typos-lsp must be on your PATH, or otherwise change this to an absolute path to typos-lsp
  -- defaults to typos-lsp if unspecified
  cmd = { "typos-lsp" },
  -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
  cmd_env = { RUST_LOG = "error" },
  filetypes = { "markdown", "python", "lua", "rust", "cpp" },
  init_options = {
    -- Custom config. Used together with a config file found in the workspace or its parents,
    -- taking precedence for settings declared in both.
    -- Equivalent to the typos `--config` cli argument.
    diagnosticSeverity = "Info",
  },
}
