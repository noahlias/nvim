---@type LazyPluginSpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      attach_to_untracked = true,
      preview_config = {
        border = "rounded",
      },
      signs = {
        add = {
          text = "▎",
        },
        change = {
          text = "░",
        },
        delete = {
          text = "_",
        },
        topdelete = {
          text = "▔",
        },
        changedelete = {
          text = "▒",
        },
        untracked = {
          text = "┆",
        },
      },
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "DiffText" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "DiffDelete" })

        vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "GitSignsAddLn" })
        vim.api.nvim_set_hl(
          0,
          "GitSignsDeleteInline",
          { link = "GitSignsDeleteLn" }
        )
        vim.api.nvim_set_hl(
          0,
          "GitSignsChangeInline",
          { link = "GitSignsChangeLn" }
        )
        -- Navigation
        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal { "]h", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { buffer = bufnr, desc = "Next hunk" })

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal { "[h", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { buffer = bufnr, desc = "Previous hunk" })

        -- Actions
        vim.keymap.set(
          "n",
          "<leader>gs",
          gitsigns.stage_hunk,
          { buffer = bufnr, desc = "Stage hunk" }
        )
        vim.keymap.set("v", "<leader>gs", function()
          gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set(
          "n",
          "<leader>gr",
          gitsigns.reset_hunk,
          { buffer = bufnr, desc = "Reset hunk" }
        )
        vim.keymap.set("v", "<leader>gr", function()
          gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set(
          "n",
          "<leader>gu",
          gitsigns.undo_stage_hunk,
          { buffer = bufnr, desc = "Undo stage hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gS",
          gitsigns.stage_buffer,
          { buffer = bufnr, desc = "Stage buffer" }
        )
        vim.keymap.set(
          "n",
          "<leader>gR",
          gitsigns.reset_buffer,
          { buffer = bufnr, desc = "Reset buffer" }
        )
        vim.keymap.set(
          "n",
          "<leader>gp",
          gitsigns.preview_hunk,
          { buffer = bufnr, desc = "Preview hunk" }
        )
        vim.keymap.set("n", "<leader>gb", function()
          gitsigns.blame_line { full = true }
        end, { buffer = bufnr, desc = "Blame line" })
        vim.keymap.set("n", "<leader>gB", function()
          gitsigns.blame()
        end, { buffer = bufnr, desc = "Blame ALl" })

        -- Text object
        vim.keymap.set(
          { "o", "x" },
          "ih",
          ":<C-U>Gitsigns select_hunk<CR>",
          { desc = "a git hunk" }
        )
        vim.keymap.set(
          { "o", "x" },
          "ah",
          ":<C-U>Gitsigns select_hunk<CR>",
          { desc = "a git hunk" }
        )
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_use_neovim_remote = true
      vim.keymap.set(
        "n",
        "<leader>gl",
        ":LazyGit<CR>",
        { noremap = true, silent = true, desc = "LazyGit" }
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
