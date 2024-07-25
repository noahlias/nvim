local m = { noremap = true, nowait = true }
local M = {}

M.config = {
  {
    --- TODO: need to deprecate this plugin
    "nvim-telescope/telescope.nvim",
    -- tag = '0.1.1',
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "dimaportenko/telescope-simulators.nvim",
    },
    config = function()
      local ts = require "telescope"
      local actions = require "telescope.actions"
      M.ts = ts
      ts.setup {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--fixed-strings",
            "--smart-case",
            "--trim",
          },
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.85,
            height = 0.85,
            prompt_position = "top",
            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },

            vertical = {
              width = 0.8,
              height = 0.85,
              preview_height = 0.5,
            },

            flex = {
              horizontal = {
                preview_width = 0.9,
              },
            },
          },
          mappings = {
            i = {
              ["<RightMouse>"] = actions.close,
              ["<LeftMouse>"] = actions.select_default,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
              ["<C-h>"] = "which_key",
              ["<C-u>"] = "move_selection_previous",
              ["<C-e>"] = "move_selection_next",
              ["<C-l>"] = "preview_scrolling_up",
              ["<C-y>"] = "preview_scrolling_down",
              ["<esc>"] = "close",
            },
          },
          color_devicons = true,
          prompt_prefix = "🔍 ",
          selection_caret = " ",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          scroll_strategy = "cycle",
          path_display = { "truncate" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
        },
      }
      ts.load_extension "neoclip"
      ts.load_extension "simulators"
      ts.load_extension "noice"

      require("simulators").setup {
        android_emulator = false,
        apple_simulator = true,
      }
      ts.load_extension "flutter"
      ts.load_extension "lazygit"
    end,
  },
}

return M
