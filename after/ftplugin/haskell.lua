-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require "haskell-tools"
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

--- @param _opts table
--- @param desc string
local extend_desc = function(_opts, desc)
  return vim.tbl_extend("force", _opts, { desc = desc })
end

-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set(
  "n",
  "<leader>hl",
  vim.lsp.codelens.run,
  extend_desc(opts, "Haskell LSP code lenses")
)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set(
  "n",
  "<leader>hs",
  ht.hoogle.hoogle_signature,
  extend_desc(opts, "Hoogle signature search")
)
-- Evaluate all code snippets
vim.keymap.set(
  "n",
  "<leader>ha",
  ht.lsp.buf_eval_all,
  extend_desc(opts, "Evaluate all code snippets")
)
-- Toggle a GHCi repl for the current package
vim.keymap.set(
  "n",
  "<leader>hr",
  ht.repl.toggle,
  extend_desc(opts, "Toggle a GHCi repl for the current package")
)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>hf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, extend_desc(opts, "Toggle a GHCi repl for the current buffer"))
vim.keymap.set(
  "n",
  "<leader>hq",
  ht.repl.quit,
  extend_desc(opts, "Quit GHCi repl")
)
