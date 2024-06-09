---@type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  enabled = true,
  version = "*",
  event = "BufEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      mode = "tabs",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, _, _)
        local icon = level:match "error" and " " or " "
        return " " .. icon .. count
      end,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        -- style = 'icon' | 'underline' | 'none',
        style = "icon",
      },
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = false,
      enforce_regular_tabs = true,
      show_duplicate_prefix = false,
      tab_size = 16,
      padding = 0,
      sort_by = "tabs" or "insert_after_current",
      offsets = {
        {
          filetype = "copilot-chat",
          text = "Copilot-Chat",
          text_align = "center",
          highlight = "CopilotChatHeader",
        },
        {
          filetype = "Outline",
          text = "Outline",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "dbui",
          text = "Database Manager",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "DiffviewFiles",
          text = "Source Control",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "OverseerList",
          text = "Tasks",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
