local M = {}

local langs_mt = {}
langs_mt.__index = langs_mt

function langs_mt:list(field)
  local deduplist = {}
  local result = {}
  -- deduplication
  for _, info in pairs(self) do
    if type(info[field]) == "string" then
      deduplist[info[field]] = true
    end
  end
  for name, _ in pairs(deduplist) do
    table.insert(result, name)
  end
  return result
end

M.langs = setmetatable({
  bash = {
    ft = "sh",
    lsp_server = "bashls",
    dap = "bashdb",
    formatting = "shfmt",
  },
  c = {
    ts = "c",
    ft = "c",
    lsp_server = "clangd",
    dap = "codelldb",
    formatting = "clang-format",
  },
  cpp = {
    ts = "cpp",
    ft = "cpp",
    lsp_server = "clangd",
    dap = "codelldb",
    formatting = "clang-format",
  },
  help = {
    ts = "vimdoc",
    ft = "help",
  },
  lua = {
    ts = "lua",
    ft = "lua",
    lsp_server = "lua_ls",
    formatting = "stylua",
  },
  -- rust = {
  --   ts = "rust",
  --   ft = "rust",
  --   formatting = "rustfmt",
  -- },
  make = {
    ts = "make",
    ft = "make",
  },
  python = {
    ts = "python",
    ft = "python",
    dap = "debugpy",
    formatting = "black",
  },
  vim = {
    ts = "vim",
    ft = "vim",
    lsp_server = "vimls",
  },
  latex = {
    ft = "tex",
    lsp_server = "texlab",
    formatting = "latexindent",
  },
}, langs_mt)

-- stylua: ignore start
M.borders = {
	rounded               = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
	single                = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
	double                = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
	double_header         = { '═', '│', '─', '│', '╒', '╕', '┘', '└' },
	double_bottom         = { '─', '│', '═', '│', '┌', '┐', '╛', '╘' },
	double_horizontal     = { '═', '│', '═', '│', '╒', '╕', '╛', '╘' },
	double_left           = { '─', '│', '─', '│', '╓', '┐', '┘', '╙' },
	double_right          = { '─', '│', '─', '│', '┌', '╖', '╜', '└' },
	double_vertical       = { '─', '│', '─', '│', '╓', '╖', '╜', '╙' },
	vintage               = { '-', '|', '-', '|', '+', '+', '+', '+' },
	rounded_clc           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
	single_clc            = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
	double_clc            = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
	double_header_clc     = { '╒', '═', '╕', '│', '┘', '─', '└', '│' },
	double_bottom_clc     = { '┌', '─', '┐', '│', '╛', '═', '╘', '│' },
	double_horizontal_clc = { '╒', '═', '╕', '│', '╛', '═', '╘', '│' },
	double_left_clc       = { '╓', '─', '┐', '│', '┘', '─', '╙', '│' },
	double_right_clc      = { '┌', '─', '╖', '│', '╜', '─', '└', '│' },
	double_vertical_clc   = { '╓', '─', '╖', '│', '╜', '─', '╙', '│' },
	vintage_clc           = { '+', '-', '+', '|', '+', '-', '+', '|' },
	empty                 = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
}
-- stylua: ignore end

local icons_mt = {}

function icons_mt:__index(key)
  return self.debug[key]
    or self.diagnostics[key]
    or self.kinds[key]
    or self.ui[key]
    or icons_mt[key]
end

---Flatten the layered icons table into a single type-icon table.
---@return table<string, string>
function icons_mt:flatten()
  local result = {}
  for _, icons in pairs(self) do
    for type, icon in pairs(icons) do
      result[type] = icon
    end
  end
  return result
end

-- stylua: ignore start
M.icons = setmetatable({
	debug = {
		StackFrame        = ' ',
		StackFrameCurrent = ' ',
	},
	diagnostics = {
		DiagnosticSignError = ' ',
		DiagnosticSignHint  = '󰌶 ',
		DiagnosticSignInfo  = '󰋽 ',
		DiagnosticSignOk    = ' ',
		DiagnosticSignWarn  = '󰀪 ',
	},
	kinds = {
		Array             = ' ',
		Boolean           = ' ',
		BreakStatement    = '󰙧 ',
		Calculator        = ' ',
		Call              = '󰃷 ',
		CaseStatement     = '󱃙 ',
		Class             = ' ',
		Color             = ' ',
		Constant          = ' ',
		Constructor       = ' ',
		ContinueStatement = '→ ',
		Copilot           = '  ',
		Declaration       = '󰙠 ',
		Delete            = '󰩺 ',
		Desktop           = 'ﲾ ',
		DoStatement       = '󰑖 ',
		Enum              = ' ',
		EnumMember        = ' ',
		Event             = ' ',
		Field             = ' ',
		File              = '󰈔 ',
		Folder            = '󰉋 ',
		ForStatement      = '󰑖 ',
		Format            = '󰗈 ',
		Function          = '󰊕 ',
		GitBranch         = ' ',
		Identifier        = '󰀫 ',
		IfStatement       = '󰇉 ',
		Interface         = ' ',
		Keyword           = '󰌋 ',
		List              = ' ',
		Log               = '󰦪 ',
		Lsp               = ' ',
		Macro             = '󰁌 ',
		MarkdownH1        = '󰉫 ',
		MarkdownH2        = '󰉬 ',
		MarkdownH3        = '󰉭 ',
		MarkdownH4        = '󰉮 ',
		MarkdownH5        = '󰉯 ',
		MarkdownH6        = '󰉰 ',
		Method            = ' ',
		Module            = '󰏗 ',
		Namespace         = ' ',
		Null              = '󰢤 ',
		Number            = ' ',
		Object            = ' ',
		Operator          = ' ',
		Package           = '󰆦 ',
		Property          = ' ',
		Reference         = '󰦾 ',
		Regex             = ' ',
		Repeat            = '󰑖 ',
		Scope             = ' ',
		Snippet           = '󰩫 ',
		Specifier         = '󰦪 ',
		Statement         = ' ',
		String            = '󰉾 ',
		Struct            = ' ',
		SwitchStatement   = '󰺟 ',
		Terminal          = ' ',
		Text              = ' ',
		Type              = ' ',
		TypeParameter     = ' ',
		Unit              = ' ',
		Value             = ' ',
		Variable          = ' ',
		WhileStatement    = '󰑖 ',
	},
	ui = {
		AngleDown     = ' ',
		AngleLeft     = ' ',
		AngleRight    = ' ',
		AngleUp       = ' ',
		ArrowDown     = '↓ ',
		ArrowLeft     = '← ',
		ArrowRight    = '→ ',
		ArrowUp       = '↑ ',
		Cross         = ' ',
		Diamond       = '◆ ',
		Dot           = '• ',
		DotLarge      = ' ',
		Ellipsis      = '… ',
		Indicator     = ' ',
		Pin           = '󰐃 ',
		Separator     = ' ',
		TriangleDown  = '▼ ',
		TriangleLeft  = '◀ ',
		TriangleRight = '▶ ',
		TriangleUp    = '▲ ',
	},
}, icons_mt)
-- stylua: ignore end

--- autocomplete icons
--- -- NOTE: inhrerits from lspkind.nvim and add TypeParameter and Codeium
M.complete_icons = {
  TypeParameter = " ",
  Codeium = " ",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
}

-- FFI
local ffi = require "ffi"

---@class foldinfo_T
---@field start integer
---@field level integer
---@field llevel integer
---@field lines integer
ffi.cdef [[
typedef struct {
    int start;  // line number where deepest fold starts
    int level;  // fold level, when zero other fields are N/A
    int llevel; // lowest level that starts in v:lnum
    int lines;  // number of lines from v:lnum to end of closed fold
} foldinfo_T;
]]

ffi.cdef [[
typedef struct {} Error;
typedef struct {} win_T;
foldinfo_T fold_info(win_T* win, int lnum);
win_T *find_window_by_handle(int Window, Error *err);
]]
local error = ffi.new "Error"

---@param winid number
---@param lnum number
---@return foldinfo_T | nil
function M.fold_info(winid, lnum)
  local win_T_ptr = ffi.C.find_window_by_handle(winid, error)
  if win_T_ptr == nil then
    return
  end
  return ffi.C.fold_info(win_T_ptr, lnum)
end

M.dap_pick_exec = function()
  local fzf = require "fzf-lua"
  return coroutine.create(function(dap_co)
    local dap_abort = function()
      coroutine.resume(dap_co, require("dap").ABORT)
    end
    local dap_run = function(exec)
      if type(exec) == "string" and vim.loop.fs_stat(exec) then
        coroutine.resume(dap_co, exec)
      else
        if exec ~= "" then
          M.warn(string.format("'%s' is not executable, aborting.", exec))
        end
        dap_abort()
      end
    end
    fzf.files {
      cwd = vim.loop.cwd(),
      git_icons = false,
      cmd = "fd --color=never --no-ignore --type x --hidden --follow --exclude .git",
      header = (":: %s to execute prompt"):format(
        fzf.utils.ansi_codes["yellow"] "<Ctrl-e>"
      ),
      winopts = {
        width = 0.65,
        height = 0.45,
        preview = { hidden = "hidden" },
        title = { { " DAP: Select Executable to Debug ", "Cursor" } },
        title_pos = "center",
      },
      actions = {
        ["esc"] = dap_abort,
        ["ctrl-c"] = dap_abort,
        ["ctrl-g"] = false,
        ["ctrl-e"] = function(_, opts)
          dap_run(opts.last_query)
        end,
        ["default"] = function(sel)
          if not sel[1] then
            dap_abort()
          else
            dap_run(fzf.path.entry_to_file(sel[1]).path)
          end
        end,
      },
    }
  end)
end

--@param fzflua_opts table
--@param getproc_opts table
M.dap_pick_process = function(fzflua_opts, getproc_opts)
  local fzf = require "fzf-lua"
  return coroutine.create(function(dap_co)
    local dap_abort = function()
      coroutine.resume(dap_co, require("dap").ABORT)
    end
    local procs = require("dap.utils").get_processes(getproc_opts)
    fzf.fzf_exec(
      function(fzf_cb)
        for _, p in pairs(procs) do
          fzf_cb(string.format("[%d] %s", p.pid, p.name))
        end
      end,
      vim.tbl_deep_extend("keep", fzflua_opts or {}, {
        winopts = {
          preview = { hidden = "hidden" },
          title = { { " DAP: Select Process to Debug ", "Cursor" } },
          title_pos = "center",
        },
        actions = {
          ["esc"] = dap_abort,
          ["ctrl-c"] = dap_abort,
          ["default"] = function(sel)
            if not sel[1] then
              dap_abort()
            else
              local pid = tonumber(sel[1]:match "^%[(%d+)%]")
              coroutine.resume(dap_co, pid)
            end
          end,
        },
      })
    )
  end)
end

return M
