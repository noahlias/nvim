local m = { noremap = true, nowait = true }
local M = {}

M.config = {
  {
    --- TODO: need to deprecate this plugin
    "nvim-telescope/telescope.nvim",
    -- tag = '0.1.1',
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "stevearc/dressing.nvim",
      "dimaportenko/telescope-simulators.nvim",
    },
    config = function()
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<c-_>", builtin.current_buffer_fuzzy_find, m)
      vim.keymap.set("n", "z=", builtin.spell_suggest, m)

      vim.keymap.set("n", "<leader>d", function()
        builtin.diagnostics {
          severity_sort = true,
        }
      end, {
        noremap = true,
        nowait = true,
        desc = "Workspace diagnostics",
      })

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
            width = 0.95,
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
              width = 0.9,
              height = 0.95,
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
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          -- media_files = {
          -- 	filetypes = { "pdf", "mp4", "png", "webp", "jpg", "jpeg" },
          -- 	find_cmd = "rg"
          -- },
          -- command_palette = command_palette,
        },
      }
      require("dressing").setup {
        select = {
          get_config = function(opts)
            if opts.kind == "codeaction" then
              return {
                backend = "telescope",
                telescope = require("telescope.themes").get_cursor(),
              }
            end
          end,
        },
      }

      ts.load_extension "neoclip"
      ts.load_extension "dap"
      ts.load_extension "fzf"
      ts.load_extension "simulators"
      ts.load_extension "noice"

      require("simulators").setup {
        android_emulator = false,
        apple_simulator = true,
      }
      ts.load_extension "flutter"
    end,
  },
  {
    "FeiyouG/commander.nvim",
    keys = {
      { "<c-q>", "<CMD>Telescope commander<CR>", mode = "n" },
    },
    config = function()
      local commander = require "commander"
      ---@diagnostic disable: missing-fields
      commander.setup {
        components = {
          "DESC",
          "KEYS",
          "CMD",
        },
        sort_by = {
          "DESC",
          "KEYS",
          "CAT",
          "CMD",
        },
        integration = {
          telescope = {
            enable = true,
            theme = require("telescope.themes").commander,
          },
          lazy = {
            enable = true,
          },
        },
      }
      ---@diagnostic disable: missing-parameter
      commander.add {
        {
          desc = "Run Simulator",
          cmd = "<CMD>Telescope simulators run<CR>",
          keys = { "n", "<leader>sr" },
        },
        {
          desc = "Git diff",
          cmd = "<CMD>Telescope git_status<CR>",
          keys = { "n", "<leader>gs" },
        },
      }
    end,
  },
}

return M
