local utils = require "utils.static"

---@type LazyPluginSpec[]
return {
  {
    "shellRaining/hlchunk.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          style = {
            { fg = "#806d9c" },
            { fg = "#c21f30" },
          },
        },
        --FIXME: Some bug in the new version
        indent = {
          chars = { "│ " },
          enable = true,
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        exclude_filetypes = {
          ["copilot-chat"] = true,
          ["neotest-outputpanel"] = true,
          ["neotest-summary"] = true,
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      indent = {
        char = "▏", -- Thiner, not suitable when enable scope
        tab_char = "▏",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          "markdown",
          "copilot-chat",
        },
      },
    },
    config = function(_, opts)
      local ibl = require "ibl"
      local hooks = require "ibl.hooks"

      ibl.setup(opts)
      hooks.register(
        hooks.type.SCOPE_HIGHLIGHT,
        hooks.builtin.scope_highlight_from_extmark
      )

      -- Hide first level indent, using `foldsep` to show it
      hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
        local win = vim.fn.bufwinid(bufnr)
        local lnum = row + 1
        local foldinfo = utils.fold_info(win, lnum)

        if
          virt_text[1]
          and virt_text[1][1] == opts.indent.char
          and foldinfo
          and foldinfo.start == lnum
        then
          virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
        end

        return virt_text
      end)
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      char = "▏",
    },
  },
}
