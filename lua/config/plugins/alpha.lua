---@type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
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
    theta.header.val = default_dashboard
    theta.header.opts = {
      hl = "Function",
      position = "center",
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
      dashboard.button("d", "  Database", "<Cmd>DBUIToggle<CR>"),
      dashboard.button("Space q s", "  Restore Session"),
      dashboard.button("q", "󰅚  Quit", "<Cmd>qa<CR>"),
    }

    alpha.setup(theta.config)
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
}
