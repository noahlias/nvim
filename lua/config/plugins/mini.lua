return {

  {
    "echasnovski/mini.animate",
    enabled = false,
    version = false,
    config = function()
      require("mini.animate").setup()
    end,
  },
  {
    "echasnovski/mini.align",
    version = false,
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.trailspace",
    enabled = true,
    version = false,
    config = function()
      local mini = require "mini.trailspace"
      mini.setup {}
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mt",
        "<cmd>lua MiniTrailspace.trim()<CR>",
        { noremap = true, silent = true, desc = "trim" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ms",
        "<cmd>lua MiniTrailspace.trim_last_lines()<CR>",
        { desc = "trim_last_lines", noremap = true, silent = true }
      )
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    config = function()
      require("mini.splitjoin").setup {
        mappings = {
          toggle = "gj",
          split = "",
          join = "",
        },
      }
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    config = function()
      require("mini.move").setup {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "<M-h>",
          right = "<M-l>",
          down = "<c-e>",
          up = "<c-u>",
          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<c-y>",
          line_up = "<c-l>",
        },
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      }
    end,
  },
}
