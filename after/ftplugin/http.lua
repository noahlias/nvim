vim.api.nvim_set_keymap(
  "n",
  "<leader>hu",
  ":lua require('kulala').jump_prev()<CR>",
  { noremap = true, silent = true, desc = "Kulala Jump to previous file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>he",
  ":lua require('kulala').jump_next()<CR>",
  { noremap = true, silent = true, desc = "Kulala Jump to next file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hr",
  ":lua require('kulala').run()<CR>",
  { noremap = true, silent = true, desc = "Kulala Run current file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ht",
  ":lua require('kulala').toggle_view()<CR>",
  { noremap = true, silent = true, desc = "Kulala Toggle view" }
)
