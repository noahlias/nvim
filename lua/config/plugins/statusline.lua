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

local function dap()
  ---@diagnostic disable-next-line: redefined-local
  local dap = package.loaded["dap"]
  if dap then
    return dap.status()
  end
  return ""
end

local function osv()
  ---@diagnostic disable-next-line: redefined-local
  local osv = package.loaded["osv"]
  if osv and osv.is_running() then
    return "Running as debugger"
  end
  return ""
end

local function dap_or_lsp()
  if osv() ~= "" then
    return osv()
  elseif dap() ~= "" then
    return dap()
  else
    return lsp()
  end
end

---@type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  -- You can optionally lazy-load heirline on UiEnter
  -- to make sure all required plugins and colorschemes are loaded before setup
  init = function()
    vim.o.laststatus = 0
  end,
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "ofseed/lualine-copilot" },
  },
  opts = {
    options = {
      icons_enabled = true,
      -- theme = "gruvbox-material",
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {
          "alpha",
          "OverseerList",
          "DiffviewFiles",
          "gitsigns.blame",
          "leetcode.nvim",
          "undotree",
        },
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
      lualine_a = {
        {
          "mode",
          icon = "",
          separator = { left = "" },
          right_padding = 2,
        },
      },
      lualine_b = {
        { "branch", icon = "" },
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
          source = function()
            return vim.b.gitsigns_status_dict
          end,
        },
      },
      lualine_c = { dap_or_lsp },
      lualine_x = {
        recording,
        {
          name = "overseer-placeholder",
          function()
            return ""
          end,
        },
        "copilot",
        -- "filesize",
        "filetype",
      },
      lualine_y = { "diagnostics", { "progress", icon = "" } },
      lualine_z = {
        {
          "location",
          icon = "",
          separator = { right = "" },
          left_padding = 2,
        },
      },
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
      "toggleterm",
      "symbols-outline",
      "nvim-dap-ui",
      "trouble",
      "mundo",
      "lazy",
      ---copilot-chat
      {
        sections = {
          lualine_z = {
            {
              "filename",
              fmt = function()
                return "GitHub Copilot"
              end,
              icon = " ",
              color = { fg = "none", bg = "#806d9c" },
            },
          },
          lualine_a = {
            { "mode" },
          },
        },
        filetypes = { "copilot-chat" },
      },
    },
  },
}
