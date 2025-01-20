---@type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require "alpha"
    local theta = require "alpha.themes.theta"
    local dashboard = require "alpha.themes.dashboard"

    -- helper function for utf8 chars
    -- local function getCharLen(s, pos)
    --   local byte = string.byte(s, pos)
    --   if not byte then
    --     return nil
    --   end
    --   return (byte < 0x80 and 1)
    --     or (byte < 0xE0 and 2)
    --     or (byte < 0xF0 and 3)
    --     or (byte < 0xF8 and 4)
    --     or 1
    -- end
    --
    -- local function applyColors(logo, colors, logoColors)
    --   theta.header.val = logo
    --
    --   for key, color in pairs(colors) do
    --     local name = "Alpha" .. key
    --     vim.api.nvim_set_hl(0, name, color)
    --     colors[key] = name
    --   end
    --
    --   theta.header.opts.hl = {}
    --   for i, line in ipairs(logoColors) do
    --     local highlights = {}
    --     local pos = 0
    --
    --     for j = 1, #line do
    --       local opos = pos
    --       pos = pos + getCharLen(logo[i], opos + 1)
    --
    --       local color_name = colors[line:sub(j, j)]
    --       if color_name then
    --         table.insert(highlights, { color_name, opos, pos })
    --       end
    --     end
    --
    --     ---@diagnostic disable-next-line: param-type-mismatch
    --     table.insert(theta.header.opts.hl, highlights)
    --   end
    --   return theta.header
    -- end
    -- theta.header = applyColors({
    --   [[  ███       ███  ]],
    --   [[  ████      ████ ]],
    --   [[  ████     █████ ]],
    --   [[ █ ████    █████ ]],
    --   [[ ██ ████   █████ ]],
    --   [[ ███ ████  █████ ]],
    --   [[ ████ ████ ████ ]],
    --   [[ █████  ████████ ]],
    --   [[ █████   ███████ ]],
    --   [[ █████    ██████ ]],
    --   [[ █████     █████ ]],
    --   [[ ████      ████ ]],
    --   [[  ███       ███  ]],
    -- }, {
    --   ["b"] = { fg = "#3399ff", ctermfg = 33 },
    --   ["a"] = { fg = "#53C670", ctermfg = 35 },
    --   ["g"] = { fg = "#39ac56", ctermfg = 29 },
    --   ["h"] = { fg = "#33994d", ctermfg = 23 },
    --   ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
    --   ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
    --   ["k"] = { fg = "#30A572", ctermfg = 36 },
    -- }, {
    --   [[  kkkka       gggg  ]],
    --   [[  kkkkaa      ggggg ]],
    --   [[ b kkkaaa     ggggg ]],
    --   [[ bb kkaaaa    ggggg ]],
    --   [[ bbb kaaaaa   ggggg ]],
    --   [[ bbbb aaaaaa  ggggg ]],
    --   [[ bbbbb aaaaaa igggg ]],
    --   [[ bbbbb  aaaaaahiggg ]],
    --   [[ bbbbb   aaaaajhigg ]],
    --   [[ bbbbb    aaaaajhig ]],
    --   [[ bbbbb     aaaaajhi ]],
    --   [[ bbbbb      aaaaajh ]],
    --   [[  bbbb       aaaaa  ]],
    -- })
    local default_dashboard = {
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
      -- [[⠀⠀⠀⠀⠀⢸⠓⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⢸⠀⠀⠑⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠙⢤⡷⣤⣦⣀⠤⠖⠚⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⣠⡿⠢⢄⡀⠀⡇⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠸⠷⣶⠂⠀⠀⠀⣀⣀⠀⠀]],
      -- [[⢸⣃⠀⠀⠉⠳⣷⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⢉⡭]],
      -- [[⠀⠘⣆⠀⠀⠀⠁⠀⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀]],
      -- [[⠀⠀⠘⣦⠆⠀⠀⢀⡎⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⡀⣠⠔⠋⠀⠀⠀]],
      -- [[⠀⠀⠀⡏⠀⠀⣆⠘⣄⠸⢧⠀⠀⠀⠀⢀⣠⠖⢻⠀⠀⠀⣿⢥⣄⣀⣀⣀⠀]],
      -- [[⠀⠀⢸⠁⠀⠀⡏⢣⣌⠙⠚⠀⠀⠠⣖⡛⠀⣠⠏⠀⠀⠀⠇⠀⠀⠀⠀⢙⣣]],
      -- [[⠀⠀⢸⡀⠀⠀⠳⡞⠈⢻⠶⠤⣄⣀⣈⣉⣉⣡⡔⠀⠀⢀⠀⠀⣀⡤⠖⠚⠀]],
      -- [[⠀⠀⡼⣇⠀⠀⠀⠙⠦⣞⡀⠀⢀⡏⠀⢸⣣⠞⠀⠀⠀⡼⠚⠋⠁⠀⠀⠀⠀]],
      -- [[⠀⢰⡇⠙⠀⠀⠀⠀⠀⠀⠉⠙⠚⠒⠚⠉⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⢧⡀⠀⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣞⠁⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠙⣶⣶⣿⠢⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⠉⠀⠀⠀⠙⢿⣳⠞⠳⡄⠀⠀⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠹⣄⣀⡤⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    }
    theta.header.val = default_dashboard
    theta.header.opts = { hl = "Keyword", position = "center" }
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
