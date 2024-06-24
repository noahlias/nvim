---@type LazyPluginSpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.cmdheight = 0

    -- Make sure to load noice when notify is called
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(...)
      require("noice").notify(...)
    end
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          min_height = 20,
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "cmdline_output",
        -- view = "mini",
      },
    },
    presets = {
      long_message_to_split = true,
      command_palette = true,
      bottom_search = true,
      lsp_doc_border = true,
    },
    cmdline = {
      view = "cmdline_popup",
      format = {
        search_down = {
          view = "cmdline",
        },
        search_up = {
          view = "cmdline",
        },
        substitute = {
          pattern = {
            "^:%s*%%s?n?o?m?/",
            "^:'<,'>%s*s?n?m?/",
            "^:%d+,%d+%s*s?n?m?/",
          },
          icon = " /",
          view = "cmdline",
          lang = "regex",
        },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = {
        enabled = false,
      },
      message = {
        enabled = false,
      },
      hover = {
        silent = true,
      },
      signature = {
        enabled = false,
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
        },
      },
      hover = {
        size = {
          max_width = 80,
        },
        border = {
          style = "rounded",
          padding = { 0, 0 },
        },
        position = {
          row = 2,
        },
      },
    },
  },
}
