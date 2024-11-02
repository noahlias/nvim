vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.ttyfast = true
vim.o.autochdir = true
vim.o.exrc = true
vim.o.secure = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.list = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 5
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ""
vim.o.foldmethod = "indent"
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldcolumn = "1" -- '0' is not bad
-- vim.o.foldlevel = 99
-- vim.o.foldenable = true
-- vim.o.foldlevelstart = 99
vim.o.formatoptions = vim.o.formatoptions:gsub("tc", "")
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
if vim.fn.getenv "TERM_PROGRAM" ~= "WezTerm" then
  vim.o.title = true
end
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.inccommand = "split"
-- vim.o.completeopt = "longest,noinsert,menuone,noselect,preview"
-- vim.o.completeopt = "menu,menuone,noinsert,noselect,preview"
vim.o.completeopt = "menu,menuone,noinsert"
-- vim.o.lazyredraw = true
vim.o.visualbell = true
vim.o.colorcolumn = "81"
vim.o.smoothscroll = true
vim.o.updatetime = 100
vim.o.virtualedit = "block"
vim.g.maplocalleader = "  "
vim.o.jumpoptions = "stack"
vim.o.mousemoveevent = true
vim.o.mouse = "a"
--- popupmenu settings
vim.o.pumblend = 12
vim.o.pumheight = 12
vim.opt.guicursor = {
  "n-v-c-sm:block-Cursor/lCursor",
  "i-ci-ve:ver25-Cursor/lCursor",
  "r-cr-o:hor20-Cursor/lCursor",
}

vim.g.lsp_zero_extend_lspconfig = 0
-- vim.opt.conceallevel = 2
vim.cmd [[
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set clipboard+=unnamedplus
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]]

vim.g.terminal_color_0 = "#000000"
vim.g.terminal_color_1 = "#FF5555"
vim.g.terminal_color_2 = "#50FA7B"
vim.g.terminal_color_3 = "#F1FA8C"
vim.g.terminal_color_4 = "#BD93F9"
vim.g.terminal_color_5 = "#FF79C6"
vim.g.terminal_color_6 = "#8BE9FD"
vim.g.terminal_color_7 = "#BFBFBF"
vim.g.terminal_color_8 = "#4D4D4D"
vim.g.terminal_color_9 = "#FF6E67"
vim.g.terminal_color_10 = "#5AF78E"
vim.g.terminal_color_11 = "#F4F99D"
vim.g.terminal_color_12 = "#CAA9FA"
vim.g.terminal_color_13 = "#FF92D0"
vim.g.terminal_color_14 = "#9AEDFE"
vim.cmd [[
tnoremap <C-N> <C-\><C-N>
]]
vim.filetype.add {
  extension = {
    ["http"] = "http",
  },
}
vim.cmd [[hi NonText ctermfg=gray guifg=grey10]]

vim.g.snips_author = "noahlias"
-- vim.g.python3_host_prog =
--   "/opt/Homebrew/Caskroom/miniforge/base/envs/py3.10/bin/python"
vim.g.mkdp_browser = "chromium"
vim.g.mkdp_browserfunc = "open "

vim.g.flutter_default_device = "macos"
vim.g.flutter_run_args = ""

vim.g.codelldb_path =
  "/Users/alias/.local/share/nvim/mason/packages/codelldb/codelldb"

-- Copy text to clipboard using codeblock format ```{ft}{content}```
vim.api.nvim_create_user_command("CopyCodeBlock", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
  local content = table.concat(lines, "\n")
  local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)
  vim.fn.setreg("+", result)
  vim.notify "Text copied to clipboard"
end, { range = true })

---- autocmds
local group = vim.api.nvim_create_augroup("scrollbar_set_git_colors", {})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd [[
hi! ScrollbarGitAdd guifg=#8CC85F
hi! ScrollbarGitAddHandle guifg=#A0CF5D
hi! ScrollbarGitChange guifg=#E6B450
hi! ScrollbarGitChangeHandle guifg=#F0C454
hi! ScrollbarGitDelete guifg=#F87070
hi! ScrollbarGitDeleteHandle guifg=#FF7B7B ]]
  end,
  group = group,
})

local diagnostic_group =
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float {
      scope = "cursor",
      focusable = false,
      zindex = 10,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "InsertEnter",
        "WinLeave",
        "ModeChanged",
      },
    }
  end,
  group = diagnostic_group,
})

vim.cmd [[autocmd TermOpen term://* startinsert]]
vim.cmd [[autocmd TermOpen term://* setlocal nonumber norelativenumber]]

vim.filetype.add {
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
}
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
