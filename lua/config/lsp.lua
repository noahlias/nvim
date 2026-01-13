local diagnostic_group =
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float {
      scope = "cursor",
      focusable = false,
      format = function(diagnostic)
        return ("%s: %s [%s]"):format(
          diagnostic.source,
          diagnostic.message,
          diagnostic.code
        )
      end,
      zindex = 10,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "InsertEnter",
        "WinLeave",
        "ModeChanged",
      },
    }
  end,
  group = diagnostic_group,
})

local diagnostic_signs = require("utils.static").icons.diagnostics
vim.diagnostic.config {
  severity_sort = true,
  -- underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.DiagnosticSignError,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.DiagnosticSignWarn,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.DiagnosticSignHint,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.DiagnosticSignInfo,
    },
  },
  virtual_text = {
    spacing = 4,
    prefix = "●",
    severity = vim.diagnostic.severity.ERROR,
  },
  update_in_insert = false,
  float = {
    severity_sort = true,
    source = "if_many",
  },
  virtual_lines = false,
}

---@type vim.lsp.util.open_floating_preview.Opts
local preview_opts = {
  border = "rounded",
  title_pos = "center",
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = vim.tbl_deep_extend("keep", opts, preview_opts)
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local documentation_window_open_index = 0
local function show_documentation()
  documentation_window_open_index = documentation_window_open_index + 1
  local current_index = documentation_window_open_index
  ---@diagnostic disable-next-line: lowercase-global
  documentation_window_open = true
  vim.defer_fn(function()
    if current_index == documentation_window_open_index then
      ---@diagnostic disable-next-line: lowercase-global
      documentation_window_open = false
    end
  end, 500)
  vim.lsp.buf.hover()
end

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    -- silent = true,
    focusable = false,
    border = "rounded",
    zindex = 60,
  })

--- Configure keybindings when the LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf, noremap = true, nowait = true }

    vim.keymap.set("n", "<leader>lh", show_documentation, {
      buffer = event.buf,
      noremap = true,
      nowait = true,
      desc = "Hover documentation",
    })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set(
      "n",
      "gD",
      ":tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>",
      opts
    )
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("i", "<c-f>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
      buffer = event.buf,
      noremap = true,
      nowait = true,
      desc = "Rename",
    })
    vim.keymap.set(
      "n",
      "<leader>td",
      "<cmd>Trouble diagnostics toggle<cr>",
      opts
    )

    vim.keymap.set(
      "n",
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "Symbols (Trouble)",
      }
    )

    vim.keymap.set(
      "n",
      "<leader>tS",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      {
        buffer = event.buf,
        noremap = true,
        nowait = true,
        desc = "LSP references/definitions/... (Trouble)",
      }
    )
    -- keymap for toggle inlay hints
    vim.keymap.set("n", "<leader>li", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf },
        { bufnr = event.buf }
      )
    end, {
      buffer = event.buf,
      noremap = true,
      nowait = true,
      desc = "Toggle inlay hints",
    })
    --NOTE: neovim 0.10 add [ d and ] d for diagnostic navigation
  end,
})

vim.lsp.enable {
  "copilot",
  "ty",
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
  "julials",
  "buf",
  "jsonnet_ls",
  "kotlin_language_server",
  "neocmake",
}
-- vim.lsp.inlay_hint.enable()
if vim.lsp.inline_completion then
  vim.lsp.inline_completion.enable()
end
if vim.lsp.document_highlight then
  vim.lsp.document_highlight.enable()
end
vim.keymap.set("i", "<C-C>", function()
  if not vim.lsp.inline_completion.get() then
    return "<C-C>"
  end
end, {
  expr = true,
  replace_keycodes = true,
  desc = "Get the current inline completion",
})
