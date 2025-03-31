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

-- Store cached Python versions for each virtual environment
local python_version_cache = {}

local function actiavte_venv()
  local venv_selector = package.loaded["venv-selector"]
  if not venv_selector then
    return "No venv-selector"
  end

  local venv = venv_selector.venv()
  local python_path = venv_selector.python()

  if not venv then
    return "Select Venv"
  end

  local venv_parts = vim.fn.split(venv, "/")
  local venv_name = venv_parts[#venv_parts]

  -- Check if we already have cached version
  if python_version_cache[venv] then
    return string.format("%s (%s)", python_version_cache[venv], venv_name)
  end

  -- Display without version while we fetch it asynchronously
  local display = string.format("(%s)", venv_name)

  -- Only proceed if we have the python path
  if python_path then
    -- Use a simpler synchronous approach that won't block the UI for long
    vim.system({
      python_path,
      "-c",
      'import sys; print("{}.{}.{}".format(*sys.version_info[:3]))',
    }, {
      timeout = 500, -- 500ms timeout to prevent UI blocking
    }, function(obj)
      if obj.code == 0 and obj.stdout then
        local version = obj.stdout:gsub("[\r\n]", "")
        if version:match "^%d+%.%d+%.%d+$" then
          python_version_cache[venv] = version
          vim.schedule(function()
            vim.cmd "redrawstatus"
          end)
        end
      end
    end)
  end

  return display
end

local venv_color = function()
  local venv = package.loaded["venv-selector"]
    and package.loaded["venv-selector"].venv()
  if not venv then
    return { fg = "#888888", gui = "italic" } -- Gray for no venv
  end

  -- Get version from cache if available
  local version = python_version_cache[venv]
  if not version then
    return { fg = "#50FA7B", gui = "bold" } -- Default color if version not yet loaded
  end

  -- Color scheme based on Python major.minor version
  local colors = {
    ["2.7"] = { fg = "#FFD700", gui = "bold" }, -- Gold for Python 2.7
    ["3.6"] = { fg = "#1E90FF", gui = "bold" }, -- DodgerBlue for 3.6
    ["3.7"] = { fg = "#6A5ACD", gui = "bold" }, -- SlateBlue for 3.7
    ["3.8"] = { fg = "#FF6347", gui = "bold" }, -- Tomato for 3.8
    ["3.9"] = { fg = "#9370DB", gui = "bold" }, -- MediumPurple for 3.9
    ["3.10"] = { fg = "#20B2AA", gui = "bold" }, -- LightSeaGreen for 3.10
    ["3.11"] = { fg = "#FF8C00", gui = "bold" }, -- DarkOrange for 3.11
    ["3.12"] = { fg = "#DA70D6", gui = "bold" }, -- Orchid for 3.12
  }

  -- Extract major.minor version (e.g., "3.10" from "3.10.4")
  local major_minor = version:match "^(%d+%.%d+)"

  -- Return the color for this version, or default green if not in our map
  return colors[major_minor] or { fg = "#50FA7B", gui = "bold" }
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
          "aerial",
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
          fmt = function(mode)
            return mode:sub(1, 3):upper()
          end,
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
        {
          name = "venv",
          function()
            return actiavte_venv()
          end,
          icon = "",
          color = function()
            return venv_color()
          end,
          separator = { left = "│", right = "" },
          padding = { left = 1, right = 1 },
          cond = function()
            return vim.bo.filetype == "python"
          end,
        },
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
