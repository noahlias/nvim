---@type LazyPluginSpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "░",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "▔",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "▒",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          untracked = {
            hl = "GitSignsAdd",
            text = "┆",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
        },
        -- current_line_blame = false,
        word_diff = true,
        attach_to_untracked = true,
        preview_config = {
          border = "rounded",
        },
      }
      vim.keymap.set(
        "n",
        "<leader>g-",
        ":Gitsigns prev_hunk<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>g=",
        ":Gitsigns next_hunk<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gb",
        ":Gitsigns blame_line<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gr",
        ":Gitsigns reset_hunk<CR>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "H",
        ":Gitsigns preview_hunk_inline<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    keys = { "<leader>gl" },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_use_neovim_remote = true
      vim.keymap.set(
        "n",
        "<leader>gl",
        ":LazyGit<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
    },
  },
}
