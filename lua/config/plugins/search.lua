---@type LazyPluginSpec[]
return {
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlslens").setup {
        build_position_cb = function(plist, _, _, _)
          require("scrollbar.handlers.search").handler.show(plist.start_pos)
        end,
      }
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        "n",
        "=",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "-",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "<Leader><CR>", "<Cmd>noh<CR>", kopts)
    end,
  },
  -- {
  --   "pechorin/any-jump.vim",
  --   event = "BufRead",
  --   enabled = false,
  --   config = function()
  --     vim.keymap.set("n", "j", ":AnyJump<CR>", { noremap = true })
  --     vim.keymap.set("x", "j", ":AnyJumpVisual<CR>", { noremap = true })
  --     vim.g.any_jump_disable_default_keybindings = true
  --     vim.g.any_jump_window_width_ratio = 0.9
  --     vim.g.any_jump_window_height_ratio = 0.9
  --   end,
  -- },
  {
    "chrisgrieser/nvim-rip-substitute",
    event = "BufRead",
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "rip substitute",
      },
    },
    config = function()
      -- default settings
      require("rip-substitute").setup {
        popupWin = {
          border = "rounded",
          matchCountHlGroup = "Keyword",
          noMatchHlGroup = "ErrorMsg",
          hideSearchReplaceLabels = false,
          position = "top",
        },
        incrementalPreview = {
          matchHlGroup = "IncSearch",
          rangeBackdrop = {
            enabled = true,
            blend = 50, -- between 0 and 100
          },
        },
        editingBehavior = {
          -- Experimental. When typing `()` in the `search` line, automatically
          -- adds `$n` to the `replace` line.
          autoCaptureGroups = false,
        },
        notificationOnSuccess = true,
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>F",
        mode = "n",
        function()
          require("spectre").toggle()
        end,
        desc = "Project find and replace",
      },
    },
  },
}
