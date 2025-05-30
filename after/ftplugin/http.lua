vim.api.nvim_set_keymap(
  "n",
  "<leader>hu",
  "<cmd>lua require('kulala').jump_prev()<CR>",
  { noremap = true, silent = true, desc = "Kulala Jump to previous file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hn",
  "<cmd>lua require('kulala').jump_next()<CR>",
  { noremap = true, silent = true, desc = "Kulala Jump to next file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hf",
  "<cmd>lua require('kulala').search()<CR>",
  { noremap = true, silent = true, desc = "Find Request" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>he",
  "<cmd>lua require('kulala').set_selected_env()<CR>",
  { noremap = true, silent = true, desc = "Select environment" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>hq",
  "<cmd>lua require('kulala').close()<CR>",
  { noremap = true, silent = true, desc = "Close Window" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ho",
  "<cmd>lua require('kulala').open()<CR>",
  { noremap = true, silent = true, desc = "Open kulala" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>hb",
  "<cmd>lua require('kulala').scratchpad()<CR>",
  { noremap = true, silent = true, desc = "Open Scratchpad" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>hr",
  "<cmd>lua require('kulala').run()<CR>",
  { noremap = true, silent = true, desc = "Kulala Run current file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ht",
  "<cmd>lua require('kulala').toggle_view()<CR>",
  { noremap = true, silent = true, desc = "Kulala Toggle view" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>hi",
  "<cmd>lua require('kulala').inspect()<CR>",
  { noremap = true, silent = true, desc = "Inspect the current request" }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>hc",
  "<cmd>lua require('kulala').from_curl()<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Paste curl from clipboard as http request",
  }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>hC",
  "<cmd>lua require('kulala').copy()<cr>",
  {
    noremap = true,
    silent = true,
    desc = "Copy the current request as a curl command",
  }
)
