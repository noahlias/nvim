---@type LazyPluginSpec[]
return {
  {
    "savq/melange-nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = true,
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = false,
      custom_highlights = function(color)
        return {
          MsgSeparator = { bg = color.mantle },

          TabLine = { bg = color.surface0, fg = color.subtext0 },
          TabLineFill = { fg = color.subtext0, bg = color.mantle },
          TabLineSel = { fg = color.base, bg = color.overlay1 },

          MatchParen = { fg = "NONE", bg = color.surface1, style = { "bold" } },

          -- telescope overrides
          TelescopeTitle = { fg = color.base, bg = color.blue },
          TelescopePreviewTitle = { fg = color.base, bg = color.green },
          TelescopePromptTitle = { fg = color.base, bg = color.red },
          TelescopeResultsTitle = { fg = color.mantle, bg = color.lavender },

          --- fzf-lua overrides
          FzfLuaTitle = { fg = color.base, bg = color.blue },
          FzfLuaPreviewTitle = { fg = color.base, bg = color.green },
          FzfLuaBorder = { fg = color.blue, bg = "NONE" },
          FzfLuaPreviewBorder = { fg = "#806d9c", bg = "NONE" },
          FzfLuaSearch = { fg = color.base, bg = color.red },

          -- window_picker overrides
          WindowPickerStatusLine = { fg = color.surface0, bg = color.red, style = { "bold" } },
          WindowPickerStatusLineNC = { fg = color.surface0, bg = color.red, style = { "bold" } },
          WindowPickerWinBar = { fg = color.surface0, bg = color.red, style = { "bold" } },
          WindowPickerWinBarNC = { fg = color.surface0, bg = color.red, style = { "bold" } },
        }
      end,
      integrations = {
        fidget = true,
        markdown = true,
        mason = true,
        native_lsp = {
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = {
          enabled = true,
        },
        dropbar = {
          enabled = true,
        },
        gitsigns = false,
        noice = true,
        notify = true,
        overseer = true,
        treesitter_context = true,
        octo = true,
        symbols_outline = true,
        illuminate = true,
        ufo = false,
        which_key = true,
        window_picker = true,
      },
    },
  },
}
