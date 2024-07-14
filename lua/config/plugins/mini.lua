---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.align",
    version = false,
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.trailspace",
    enabled = true,
    event = { "BufNewFile", "BufReadPre" },
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
    event = { "BufNewFile", "BufReadPre" },
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
    event = { "BufNewFile", "BufReadPre" },
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
  {
    "echasnovski/mini.bracketed",
    version = false,
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("mini.bracketed").setup {
        buffer = { suffix = "b", options = {} },
        comment = { suffix = "c", options = {} },
        conflict = { suffix = "x", options = {} },
        diagnostic = { suffix = "d", options = {} },
        file = { suffix = "f", options = {} },
        indent = { suffix = "i", options = {} },
        jump = { suffix = "j", options = {} },
        location = { suffix = "l", options = {} },
        oldfile = { suffix = "o", options = {} },
        quickfix = { suffix = "q", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo = { suffix = "", options = {} },
        window = { suffix = "w", options = {} },
        yank = { suffix = "y", options = {} },
      }
    end,
  },
  {
    "echasnovski/mini.jump2d",
    version = false,
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("mini.jump2d").setup {
        mappings = {
          start_jumping = "<Esc>",
        },
      }
    end,
  },
  {
    "echasnovski/mini.jump",
    version = false,
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.icons").setup()
    end,
    -- specs = {
    --   { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    -- },
    -- opts = {},
    -- init = function()
    --   package.preload["nvim-web-devicons"] = function()
    --     require("mini.icons").mock_nvim_web_devicons()
    --     return package.loaded["nvim-web-devicons"]
    --   end
    -- end,
  },
}
