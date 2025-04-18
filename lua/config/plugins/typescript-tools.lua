---@type LazyPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  enabled = false,
  event = {
    "BufRead *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx,*.vue",
    "BufNewFile *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx,*.vue",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      vim.keymap.set(
        "n",
        "gD",
        "<Cmd>TSToolsGoToSourceDefinition<CR>",
        { buffer = bufnr, desc = "Source Definition" }
      )

      vim.keymap.set(
        "n",
        "<localleader>i",
        "<Cmd>TSToolsAddMissingImports<CR>",
        { buffer = bufnr, desc = "Add missing imports" }
      )
      vim.keymap.set(
        "n",
        "<localleader>o",
        "<Cmd>TSToolsOrganizeImports<CR>",
        { buffer = bufnr, desc = "Organize imports" }
      )
      vim.keymap.set(
        "n",
        "<localleader>r",
        "<Cmd>TSToolsRemoveUnused<CR>",
        { buffer = bufnr, desc = "Remove unused variables" }
      )
      vim.keymap.set(
        "n",
        "<localleader>F",
        "<Cmd>TSToolsFixAll<CR>",
        { buffer = bufnr, desc = "Fix all" }
      )

      vim.keymap.set(
        "n",
        "<localleader>fr",
        "<Cmd>TSToolsFileReferences<CR>",
        { buffer = bufnr, desc = "File references" }
      )
      vim.keymap.set(
        "n",
        "<localleader>fn",
        "<Cmd>TSToolsRenameFile<CR>",
        { buffer = bufnr, desc = "File rename" }
      )
    end,
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      ---NOTE: https://github.com/pmizio/typescript-tools.nvim/issues/260
      separate_diagnostic_server = false,
      tsserver_plugins = {
        "@vue/typescript-plugin",
      },
      expose_as_code_action = "all",
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
    },
    code_lens = "all",
  },
}
