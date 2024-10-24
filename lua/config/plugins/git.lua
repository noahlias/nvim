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
    opts = {
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
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
    },
  },
  {
    "rbong/vim-flog",
    lazy = true,
    init = function()
      vim.g.flog_enable_extended_chars = 1
    end,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      symbols = {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          vim.notify("DiffviewOpen " .. commit.hash .. "^!")
          vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
          vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 2000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },
}
