---@type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  dependencies = {
    "juansalvatore/git-dashboard-nvim",
  },
  event = "VimEnter",
  init = function()
    --- NOTE: This disable the tabline in dashboard load screen.
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "disable tabline for alpha",
      callback = function()
        vim.opt.showtabline = 0
      end,
    })
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      desc = "enable tabline after alpha",
      callback = function()
        vim.opt.showtabline = 2
      end,
    })
  end,
  config = function()
    local alpha = require "alpha"
    local default_dashboard = {
      [[                                                     ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ]],
      --   -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠤⠙⣅⢩⣤⣴⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣶⡾⢋⣉⣽⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣏⡿⣫⠥⠌⢸⣿⠇⠠⠀⢀⡀⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⣿⣷⣤⣥⣒⣶⣿⡏⠀⠀⠀⣿⠇⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠸⣿⣿⣿⡿⠛⠉⠀⠀⠀⠀⣿⡄⠀⠀⠀⠀]],
      --   -- [[⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠘⠉⠉⠀⠀⠀⠀⠀⠀⢰⣿⣷⣤⣤⡀⠀]],
      --   -- [[⠀⠀⠀⢠⣿⣯⡀⠀⠀⠀⠀⠀⢶⣶⣶⡆⣤⣴⣦⠀⣾⣿⣿⣿⣿⣅⠆]],
      --   -- [[⠀⠀⠀⣿⣿⣿⠿⠀⠀⠀⠀⠀⠈⢽⣿⣿⣿⣿⠃⡠⣿⣿⣿⣛⣻⠛⡀]],
      --   -- [[⠀⠀⢸⣿⣿⣿⡟⣧⠀⠀⠀⠀⠀⠈⢿⣿⣿⠋⠀⣰⣿⣿⣟⡉⠉⠉⢀]],
      --   -- [[⠀⠀⠀⣿⣿⣷⡶⠃⠧⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠁⠀⠙⠟⠉⠁⢠⣿]],
      --   -- [[⠀⠀⠀⢻⣷⡶⠄⠀⠀⠐⠒⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣠]],
      --   -- [[⠀⠀⠀⠈⠳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠟]],
    }
    local dashboard = require "alpha.themes.dashboard"
    local theta = require "alpha.themes.theta"
    --- @diagnostic disable-next-line:missing-fields
    local git_dashboard = require("git-dashboard-nvim").setup {
      centered = false,
      top_padding = 0,
      use_git_username_as_author = true,
      bottom_padding = 0,
      show_current_branch = false,
      hide_cursor = true,
      title = "owner_with_repo_name",
      days = { "s", "m", "t", "w", "t", "f", "s" },
      colors = {
        --catpuccin theme
        days_and_months_labels = "#8FBCBB",
        empty_square_highlight = "#3B4252",
        filled_square_highlights = {
          "#88C0D0",
          "#88C0D0",
          "#88C0D0",
          "#88C0D0",
          "#88C0D0",
          "#88C0D0",
          "#88C0D0",
        },
        branch_highlight = "#88C0D0",
        dashboard_title = "#88C0D0",
      },
    }

    --fallback to default if not git directory and git dashboard is not empty
    local header = function()
      if
        vim.fn.isdirectory ".git" == 1
        and table.concat(git_dashboard, "") ~= ""
      then
        return git_dashboard
      else
        return default_dashboard
      end
    end
    theta.header.val = header
    theta.buttons.val = {
      {
        type = "text",
        val = "Quick links",
        opts = { hl = "SpecialComment", position = "center" },
      },
      { type = "padding", val = 1 },
      dashboard.button("e", "󰈔  New file", "<Cmd>ene<CR>"),
      dashboard.button("Ctrl p", "󰈞  Find file"),
      dashboard.button("Ctrl h", "󰈏  Old files"),
      dashboard.button("Ctrl f", "󰊄  Live grep"),
      dashboard.button("l", "󰇯  Leetcode", "<Cmd>Leet<CR>"),
      dashboard.button(
        "c",
        "  Configuration",
        "<Cmd>edit ~/.config/nvim/init.lua<CR>"
      ),
      dashboard.button("d", "  Database", "<Cmd>DBUIToggle<CR>"),
      dashboard.button("q", "󰅚  Quit", "<Cmd>qa<CR>"),
    }

    alpha.setup(theta.config)
  end,
}
