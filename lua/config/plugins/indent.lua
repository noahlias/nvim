local utils = require "utils"
---@type LazyPluginSpec[]
return {
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
        -- Rely on treesitter, bad performance
        enabled = false,
        -- highlight = highlight,
      },
    },
    config = function(_, opts)
      local ibl = require "ibl"
      local hooks = require "ibl.hooks"

      ibl.setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      -- Hide first level indent, using `foldsep` to show it
      hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
        local win = vim.fn.bufwinid(bufnr)
        local foldinfo = utils.static.fold_info(win, row)

        if virt_text[1] and virt_text[1][1] == opts.indent.char and foldinfo and foldinfo.level ~= 0 then
          virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
        end

        return virt_text
      end)
    end,
  },
  {
    "Mr-LLLLL/cool-chunk.nvim",
    event = { "CursorHold", "CursorHoldI" },
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local cool_chunk_mods = require "cool-chunk.mods"
      local support_filetypes = {
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
      }
      require("cool-chunk").setup {
        {
          chunk = {
            notify = true,
            support_filetypes = support_filetypes,
            hl_group = {
              chunk = "CursorLineNr",
              error = "CoolError",
            },
            chars = {
              horizontal_line = "─",
              vertical_line = "│",
              left_top = "╭",
              left_bottom = "╰",
              left_arrow = "<",
              bottom_arrow = "v",
              right_arrow = ">",
            },
            textobject = "ah",
            animate_duration = 200,
            fire_event = { "CursorHold", "CursorHoldI" },
          },
          context = {
            notify = true,
            chars = {
              "│",
            },
            hl_group = {
              context = "LineNr",
            },
            support_filetypes = support_filetypes,
            textobject = "ih",
            jump_support_filetypes = { "lua", "python" },
            jump_start = "[{",
            jump_end = "]}",
            fire_event = { "CursorHold", "CursorHoldI" },
          },
        },
      }
      --NOTE: disable line_num
      cool_chunk_mods.line_num:disable()
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE", fg = "#806d9c" })
    end,
  },
}
