---@type LazyPluginSpec[]
return {
  {
    "hedyhli/outline.nvim",
    enabled = false,
    keys = {
      { "<leader>so", "<Cmd>Outline<CR>", desc = "Outline" },
    },
    opts = {
      preview_window = {
        border = "rounded",
        live = true,
      },
      symbols = {
        icon_source = "lspkind",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local icons = vim.deepcopy(require("utils.static").icons.kinds)
      icons.lua = { Package = icons.Control }
      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "asciidoc", "markdown", "man" },
        show_guides = true,
        layout = {
          default_direction = "prefer_right",
          resize_to_content = false,
          min_width = 40,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = false,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
      }
      return opts
    end,
    keys = {
      { "<leader>so", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },
}
