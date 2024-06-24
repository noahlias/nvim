---@type LazyPluginSpec
return {
  "goolord/alpha-nvim",
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

    local dashboard = require "alpha.themes.dashboard"
    local theta = require "alpha.themes.theta"

    theta.header.val = {
      [[                                                     ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ]],
      -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠤⠙⣅⢩⣤⣴⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣶⡾⢋⣉⣽⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣏⡿⣫⠥⠌⢸⣿⠇⠠⠀⢀⡀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⣿⣷⣤⣥⣒⣶⣿⡏⠀⠀⠀⣿⠇⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠸⣿⣿⣿⡿⠛⠉⠀⠀⠀⠀⣿⡄⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠘⠉⠉⠀⠀⠀⠀⠀⠀⢰⣿⣷⣤⣤⡀⠀]],
      -- [[⠀⠀⠀⢠⣿⣯⡀⠀⠀⠀⠀⠀⢶⣶⣶⡆⣤⣴⣦⠀⣾⣿⣿⣿⣿⣅⠆]],
      -- [[⠀⠀⠀⣿⣿⣿⠿⠀⠀⠀⠀⠀⠈⢽⣿⣿⣿⣿⠃⡠⣿⣿⣿⣛⣻⠛⡀]],
      -- [[⠀⠀⢸⣿⣿⣿⡟⣧⠀⠀⠀⠀⠀⠈⢿⣿⣿⠋⠀⣰⣿⣿⣟⡉⠉⠉⢀]],
      -- [[⠀⠀⠀⣿⣿⣷⡶⠃⠧⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠁⠀⠙⠟⠉⠁⢠⣿]],
      -- [[⠀⠀⠀⢻⣷⡶⠄⠀⠀⠐⠒⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣠]],
      -- [[⠀⠀⠀⠈⠳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠟]],
    }

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
      dashboard.button(
        "f",
        "  File Browser",
        "<Cmd>Telescope file_browser<CR>"
      ),
      dashboard.button("d", "  Database", "<Cmd>DBUIToggle<CR>"),
      dashboard.button("q", "󰅚  Quit", "<Cmd>qa<CR>"),
    }

    alpha.setup(theta.config)
  end,
}
