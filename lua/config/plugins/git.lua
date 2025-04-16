---@type LazyPluginSpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gB",
        function()
          require("gitsigns").blame()
        end,
        desc = "Blame",
      },
    },
    opts = {
      attach_to_untracked = true,
      word_diff = true,
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
        vim.keymap.set(
          "n",
          "<leader>gb",
          gitsigns.toggle_current_line_blame,
          { buffer = bufnr, desc = "Line Blame" }
        )

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
    enabled = false,
    cmd = "LazyGit",
    keys = {
      {
        "<leader>gl",
        ":LazyGit<CR>",
        desc = "LazyGit",
      },
    },
    config = function()
      ---NOTE: maybe this will be decrepated by toggleterm
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_use_neovim_remote = true
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>gf",
        "<CMD>GitConflictRefresh<CR>",
        desc = "GitConflict Refresh",
      },
      {
        "<leader>gq",
        "<CMD>GitConflictListQf<CR>",
        desc = "GitConflict Quickfix",
      },
    },
    opts = {
      disable_diagnostics = true,
      default_mappings = {
        ours = "co",
        theirs = "ct",
        none = "c0",
        both = "cb",
        next = "]x",
        prev = "[x",
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = {
      "Neogit",
    },
    keys = {
      { "<leader>gg", "<Cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    opts = {
      disable_hint = true,
      graph_style = "kitty",
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      sections = {
        stashes = {
          folded = false,
        },
        recent = {
          folded = false,
        },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
    },
  },
  {
    "harrisoncramer/gitlab.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    keys = {
      {
        "<leader>gm",
        function()
          require("gitlab").choose_merge_request()
        end,
        desc = "Open Merge Request",
      },
      {
        "<leader>gv",
        function()
          require("gitlab").review()
        end,
        desc = "Open Merge Request Review",
      },
      {
        "<leader>gM",
        function()
          require("gitlab").create_mr()
        end,
        desc = "Create Merge Request",
      },
      {
        "<leader>gi",
        function()
          require("gitlab").open_in_browser()
        end,
        desc = "Open in Browser",
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
}
