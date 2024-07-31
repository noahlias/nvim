---@type LazyPluginSpec[]
return {
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("hlslens").setup {}
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        "n",
        "=",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        "n",
        "-",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        "n",
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        "n",
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        "n",
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        "n",
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
    end,
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    event = "BufRead",
    keys = {
      {
        "<leader>sf",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "File Search & Replace",
      },
    },
    config = function()
      -- default settings
      require("rip-substitute").setup {
        popupWin = {
          title = "Search & Replace",
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
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local is_visual = vim.fn.mode():lower():find "v"
          if is_visual then -- needed to make visual selection work
            vim.cmd [[normal! v]]
          end
          local grug = require "grug-far";
          (is_visual and grug.with_visual_selection or grug.grug_far) {
            prefills = { filesFilter = "*." .. vim.fn.expand "%:e" },
          }
        end,
        mode = { "n", "v" },
        desc = "Project Search and Replace",
      },
    },
  },
}
