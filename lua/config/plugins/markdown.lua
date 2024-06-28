---@type LazyPluginSpec[]
return {
  {
    "instant-markdown/vim-instant-markdown",
    ft = { "markdown" },
    build = "yarn install",
    config = function()
      vim.g.instant_markdown_autostart = 0
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    -- dir = "~/.config/nvim/dev/markview.nvim",
    ft = { "markdown" },
    -- name = "markview",
    -- dev = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      ---@diagnostic disable-next-line: redundant-parameter
      require("markview").setup {
        header = {
          {
            style = "padded_icon",
            line_hl = "markview_h1",

            sign = "󰌕 ",
            sign_hl = "rainbow1",

            icon = "󰼏 ",
            icon_width = 1,
            icon_hl = "markview_h1_icon",
          },
          {
            style = "padded_icon",
            line_hl = "markview_h2",

            sign = "",
            sign_hl = "",

            icon = "󰎨 ",
            icon_width = 1,
            icon_hl = "markview_h2_icon",
          },
          {
            style = "padded_icon",
            line_hl = "markview_h3",

            icon = "󰼑 ",
            icon_width = 1,
            icon_hl = "markview_h3_icon",
          },
          {
            style = "padded_icon",
            line_hl = "markview_h4",

            icon = "󰎲 ",
            icon_width = 1,
            icon_hl = "markview_h4_icon",
          },
          {
            style = "padded_icon",
            line_hl = "markview_h5",

            icon = "󰼓 ",
            icon_width = 1,
            icon_hl = "markview_h5_icon",
          },
          {
            style = "padded_icon",
            line_hl = "markview_h6",

            icon = "󰎴 ",
            icon_width = 1,
            icon_hl = "markview_h6_icon",
          },
          -- {
          -- 	mode = "icon",
          -- 	icon_config = {
          -- 		icon = "󰼏 ",
          -- 		icon_hl = "Normal"
          -- 	},
          -- }
        },

        code_block = {
          style = "language",
          mode = "decorated",
          block_hl = "code_block",

          top_border = {
            language = true,
            language_hl = "Bold",

            priority = 8,
            char = nil,
            char_hl = "code_block_border",

            sign = true,
          },

          padding = " ",
        },

        inline_code = {
          before = " ",
          after = " ",

          hl = "inline_code_block",
        },

        block_quote = {
          default = {
            border = "▋",
            border_hl = {
              "Glow_0",
              "Glow_1",
              "Glow_2",
              "Glow_3",
              "Glow_4",
              "Glow_5",
              "Glow_6",
              "Glow_7",
            },
          },

          callouts = {
            {
              match_string = "[!NOTE]",
              callout_preview = "  Note",
              callout_preview_hl = "rainbow5",

              border = "▋ ",
              border_hl = "rainbow5",
            },
            {
              match_string = "[!IMPORTANT]",
              callout_preview = "󰀨  Important",
              callout_preview_hl = "rainbow2",

              border = "▋ ",
              border_hl = "rainbow2",
            },
            {
              match_string = "[!WARNING]",
              callout_preview = "  Warning",
              callout_preview_hl = "rainbow1",

              border = "▋ ",
              border_hl = "rainbow1",
            },
            {
              match_string = "[!TIP]",
              callout_preview = " Tip",
              callout_preview_hl = "rainbow4",

              border = "▋ ",
              border_hl = "rainbow4",
            },
            {
              match_string = "[!CUSTOM]",
              callout_preview = "󰠳 Custom",
              callout_preview_hl = "rainbow3",

              border = "▋ ",
              border_hl = "rainbow3",
            },
          },
        },

        horizontal_rule = {
          style = "simple",
          border_char = "─",
          border_hl = "Comment",

          -- segments = {};
        },

        hyperlink = {
          icon = " ",
          hl = "Label",
        },

        image = {
          icon = " ",
          hl = "Label",
        },

        table = {
          remove_chars = { "`" },
          table_chars = {
            "╭",
            "─",
            "╮",
            "┬",
            "├",
            "│",
            "┤",
            "┼",
            "╰",
            "─",
            "╯",
            "┴",
          },
          table_hls = {
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
            "rainbow1",
          },

          use_virt_lines = false,
        },

        list_item = {
          marker_plus = {
            add_padding = true,
            check_indent_level = true,

            marker = "•",
            marker_hl = "rainbow2",
          },
          marker_minus = {
            add_padding = true,
            check_indent_level = true,

            marker = "•",
            marker_hl = "rainbow4",
          },
          marker_star = {
            add_padding = true,
            check_indent_level = true,

            marker = "•",
            marker_hl = "rainbow2",
          },
        },

        checkbox = {
          checked = {
            marker = " ✔ ",
            marker_hl = "@markup.list.checked",
          },
          uncheked = {
            marker = " ✘ ",
            marker_hl = "@markup.list.unchecked",
          },
        },
      }
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Mandatory
      "nvim-tree/nvim-web-devicons", -- Optional but recommended
    },
    config = function()
      require("render-markdown").setup {}
    end,
  },
}
