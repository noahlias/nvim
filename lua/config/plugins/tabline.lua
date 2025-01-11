---@type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  enabled = true,
  version = "*",
  event = { "BufNewFile", "BufReadPre" },
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      hover = {
        enabled = true,
        delay = 0,
        reveal = { "close" },
      },
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
      ---NOTE: This is a workaround for the issue that bufferline doesn't show the bufferline when there is only one buffer
      -- always_show_bufferline = false,
      enforce_regular_tabs = true,
      show_duplicate_prefix = false,
      always_show_bufferline = true,
      sort_by = "tabs",
      -- separator_style = "thick",
      offsets = {
        {
          filetype = "copilot-chat",
          text = "Copilot-Chat",
          text_align = "center",
          highlight = "CopilotChatHeader",
        },
        {
          filetype = "aerial",
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
        {
          filetype = "gitsigns-blame",
          text = "Git Blame",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "leetcode.nvim",
          text = "LeetCode",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "undotree",
          text = "Undo Tree",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "octo",
          text = "Octo",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
