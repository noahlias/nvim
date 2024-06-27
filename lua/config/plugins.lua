---@diagnostic disable-next-line: param-type-mismatch
vim.env.LAZY = vim.fs.joinpath(vim.fn.stdpath "data", "lazy")
local lazypath = vim.fs.joinpath(vim.env.LAZY, "lazy.nvim")

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- -- Loading shada is SLOW, so we're going to load it manually,
-- -- after UI-enter so it doesn't block startup.
-- local shada = vim.o.shada
-- vim.o.shada = ""
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
--     vim.o.shada = shada
--     pcall(vim.cmd.rshada, { bang = true })
--   end,
-- })
--
local lazy_cmd = require("lazy.view.config").commands
local lazy_keys = {
  { cmd = "install", key = "i" },
  { cmd = "update", key = "u" },
  { cmd = "sync", key = "s" },
  { cmd = "clean", key = "cl" },
  { cmd = "check", key = "ch" },
  { cmd = "log", key = "l" },
  { cmd = "restore", key = "rs" },
  { cmd = "profile", key = "p" },
  { cmd = "profile", key = "p" },
}
for _, v in ipairs(lazy_keys) do
  lazy_cmd[v.cmd].key = "<SPC>" .. v.key
  lazy_cmd[v.cmd].key_plugin = "<leader>" .. v.key
end
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { noremap = true })

---@type LazyConfig
require("lazy").setup {
  spec = {
    require("config.plugins.lspconfig").config,
    require "config.plugins.colorscheme",
    require "config.plugins.alpha",
    require "config.plugins.dressing",
    require "config.plugins.plenary",

    require "config.plugins.treesitter",
    require("config.plugins.telescope").config,
    require "config.plugins.fzf",
    require "config.plugins.notify",
    require "config.plugins.statusline",
    require "config.plugins.editor",
    require "config.plugins.scrollbar",
    require "config.plugins.tabline",
    require("config.plugins.autocomplete").config,
    require "config.plugins.debugger",
    require "config.plugins.cmake_tools",
    require "config.plugins.flutter",
    require "config.plugins.go",
    require "config.plugins.surround",
    require "config.plugins.project",
    require "config.plugins.multi-cursor",
    require "config.plugins.markdown",
    require "config.plugins.git",
    require "config.plugins.indent",
    require "config.plugins.search",
    require "config.plugins.yank",
    require "config.plugins.window-management",
    require "config.plugins.undo",
    require "config.plugins.ft",
    require "config.plugins.fun",
    require "config.plugins.crates",
    require "config.plugins.winbar",
    require "config.plugins.misc",
    require "config.plugins.tree",
    require "config.plugins.outline",
    -- NOTE: AI plugins(copilot and gp and codieum)
    require "config.plugins.ai",
    -- extra plugins
    require "config.plugins.rustacean",
    require "config.plugins.typescript-tools",
    ---mini.nvim
    require "config.plugins.mini",
    require "config.plugins.clangd_extensions",
    { "dstein64/vim-startuptime" },
    require "config.plugins.noice",
    require "config.plugins.conform",
    require "config.plugins.overseer",
    require "config.plugins.jdtls",
    require "config.plugins.sql",
    require "config.plugins.comment",
    require "config.plugins.octo",
    require "config.plugins.tailwind",
    -- NOTE: This plugin use for my personal use
    {
      "gleam-lang/gleam.vim",
      ft = { "gleam" },
      event = "BufReadPre *.gleam",
    },
    {
      "fladson/vim-kitty",
      event = { "BufReadPre kitty.conf" },
    },
    ---NOTE: Add neotest for test
    require "config.plugins.neotest",
  },
  diff = {
    cmd = "diffview.nvim",
  },
  ---NOTE: This checker for lazy update status
  -- checker = {
  --   enabled = true,
  -- },
  rocks = {
    enabled = false,
  },
  performance = {
    cache = {
      enabled = true,
      disable_events = { "UIEnter" },
    },
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        -- "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

-- local swap_ternary = require "plugin.swap_ternary"
-- vim.keymap.set("n", "<leader>st", swap_ternary.swap_ternary, { noremap = true })

require "plugin.compile_run"

-- NOTE: Some funny
local rain = require "utils.funcs.rain"

vim.api.nvim_create_user_command("Rain", rain.toggle_rain, {})

-- require "plugin.custom_commands"
