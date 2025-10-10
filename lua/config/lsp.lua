vim.lsp.config("harper_ls", {
  filetypes = { "markdown", "python" },
  settings = {
    ["harper-ls"] = {
      markdown = {
        ignore_link_title = true,
      },
      filetypes = { "markdown", "python" },
      isolateEnglish = false,
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = false,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
        multiple_sequential_pronouns = true,
        linking_verbs = false,
        avoid_curses = true,
        terminating_conjunctions = true,
      },
    },
  },
})

vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "objc", "objcpp" },
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed",
    "--clang-tidy",
  },
  on_attach = function(_) end,
})

vim.lsp.config("ruff", {
  on_attach = function(client, bufnr)
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  settings = {
    logFile = "~/.local/state/nvim/ruff.log",
    organizeImports = true,
  },
})

vim.lsp.config("pyright", {
  filetypes = { "python" },
  cmd = { "delance-langserver", "--stdio" },
  on_attach = function(_) end,
  settings = {
    capabilities = {
      textDocument = {
        publishDiagnostics = {
          tagSupport = {
            valueSet = { 2 },
          },
        },
        hover = {
          contentFormat = { "plaintext" },
          dynamicRegistration = true,
        },
      },
    },
    pyright = {
      disableOrganizeImports = true,
      disableTaggedHints = false,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "standard",
        autoImportCompletions = true,
        diagnosticSeverityOverrides = {
          deprecateTypingAliases = false,
        },
        inlayHints = {
          callArgumentNames = "partial",
          functionReturnTypes = true,
          pytestParameters = true,
          variableTypes = true,
        },
      },
    },
  },
})

vim.lsp.enable {
  "copilot",
  "pyright",
  "lua_ls",
  "clangd",
  "zls",
  "jsonls",
  "vtsls",
  "ruff",
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
