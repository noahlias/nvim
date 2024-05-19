-- local utils = require "utils"
---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    ft = {
      "lua",
      "sh",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "c",
      "cpp",
      "rust",
      "python",
      "java",
      "go",
      "html",
      "css",
      "scss",
      "dockerfile",
      "zig",
      "haskell",
    },
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
      require("hlchunk").setup {
        chunk = {
          notify = false,
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#806d9c" },
          },
        },
        indent = {
          chars = { "│", "¦", "┆", "┊" },
          use_treesitter = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
        },
      }
    end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "VeryLazy",
  --   enabled = false,
  --   opts = {
  --     indent = {
  --       char = "▏", -- Thiner, not suitable when enable scope
  --       tab_char = "▏",
  --     },
  --     scope = {
  --       -- Rely on treesitter, bad performance
  --       enabled = false,
  --       -- highlight = highlight,
  --     },
  --   },
  --   config = function(_, opts)
  --     local ibl = require "ibl"
  --     local hooks = require "ibl.hooks"
  --
  --     ibl.setup(opts)
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --
  --     -- Hide first level indent, using `foldsep` to show it
  --     hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
  --       local win = vim.fn.bufwinid(bufnr)
  --       local foldinfo = utils.static.fold_info(win, row)
  --
  --       if virt_text[1] and virt_text[1][1] == opts.indent.char and foldinfo and foldinfo.level ~= 0 then
  --         virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
  --       end
  --
  --       return virt_text
  --     end)
  --   end,
  -- },
}
