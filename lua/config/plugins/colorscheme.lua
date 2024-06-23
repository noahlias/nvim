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

          ---nvim-bqf overrides
          BqfPreviewFloat = { bg = color.base, fg = color.text },
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
        colorful_winsep = {
          enabled = false,
          color = "red",
        },
        gitsigns = false,
        noice = true,
        notify = true,
        overseer = true,
        neotest = true,
        treesitter_context = true,
        octo = true,
        symbols_outline = true,
        illuminate = true,
        ufo = false,
        alpha = false,
        which_key = false,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
      },
    },
  },
}
