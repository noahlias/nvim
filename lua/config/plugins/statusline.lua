-- local current_signature = function()
-- 	if not pcall(require, 'lsp_signature') then return end
-- 	local sig = require("lsp_signature").status_line(50)
-- 	return sig.label .. "🐼" .. sig.hint
-- end

local lazy_status = require "lazy.status"

local function lsp()
  local clients = vim.lsp.get_clients()
  local buf = vim.api.nvim_get_current_buf()
  clients = vim
    .iter(clients)
    :filter(function(client)
      return client.attached_buffers[buf]
    end)
    :filter(function(client)
      return client.name ~= "GitHub Copilot"
    end)
    :map(function(client)
      return " " .. client.name
    end)
    :totable()
  local info = table.concat(clients, " ")
  if info == "" then
    return "No attached LSP server"
  else
    return info
  end
end

local function recording()
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    return "recording @" .. reg
  end
  reg = vim.fn.reg_recorded()
  if reg ~= "" then
    return "recorded @" .. reg
  end

  return ""
end

---@type LazyPluginSpec
return {
  -- "theniceboy/eleline.vim",
  -- branch = "no-scrollbar",
  "nvim-lualine/lualine.nvim",
  -- You can optionally lazy-load heirline on UiEnter
  -- to make sure all required plugins and colorschemes are loaded before setup
  init = function()
    vim.o.laststatus = 0
  end,
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "ofseed/lualine-copilot" },
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = "gruvbox-material",
      -- theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "alpha" },
      },
      always_divide_middle = true,
      globalstatus = false,
      -- refresh = {
      -- 	statusline = 1000,
      -- 	tabline = 1000,
      -- 	winbar = 1000,
      -- }
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { lsp },
      lualine_x = {
        recording,
        {
          lazy_status.updates,
          cond = lazy_status.has_updates,
          color = { fg = "#ff9e64" },
        },
        "copilot",
        "fileformat",
      },
      lualine_y = { "location", "filesize", "filetype" },
      lualine_z = { "filename" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      "man",
      "quickfix",
      "nvim-tree",
      "neo-tree",
      "toggleterm",
      "symbols-outline",
      "aerial",
      "nvim-dap-ui",
      "mundo",
      "lazy",
    },
  },
}
