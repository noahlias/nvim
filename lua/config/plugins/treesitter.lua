local ensure_installed = {
  "bash",
  "c",
  "cpp",
  "dap_repl",
  "dart",
  "dockerfile",
  "gitignore",
  "go",
  "haskell",
  "html",
  "java",
  "javascript",
  "json",
  "jsonc",
  "just",
  "latex",
  "lua",
  "markdown",
  "markdown_inline",
  "norg",
  "ocaml",
  "odin",
  "org",
  "prisma",
  "python",
  "query",
  "r",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
  "glsl",
  "gleam",
  "julia",
}

local function highlight_disabled(bufnr)
  if vim.bo[bufnr].filetype == "latex" then
    return true
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  local stat = vim.uv.fs_stat(name)
  return stat ~= nil and stat.size > 256 * 1024
end

local function parser_installed(lang)
  return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", true) > 0
end

local function ensure_parser_installed(lang, available)
  if vim.tbl_contains(available, lang) then
    require("nvim-treesitter").install(lang)
  end
end

local function maybe_install_missing_parsers()
  local treesitter = require "nvim-treesitter"
  local installed = {}
  for _, lang in ipairs(treesitter.get_installed()) do
    installed[lang] = true
  end

  local available = treesitter.get_available()
  local missing = {}
  for _, lang in ipairs(ensure_installed) do
    if not installed[lang] and vim.tbl_contains(available, lang) then
      table.insert(missing, lang)
    end
  end

  if #missing > 0 then
    treesitter.install(missing, { summary = true })
  end
end

local function start_treesitter(bufnr)
  if highlight_disabled(bufnr) then
    return
  end

  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if not lang or lang == "" then
    return
  end

  if not parser_installed(lang) then
    local available = vim.g.ts_available or require("nvim-treesitter").get_available()
    vim.g.ts_available = available
    ensure_parser_installed(lang, available)
    return
  end

  vim.treesitter.start(bufnr, lang)
end

local function visual_select(range)
  local srow, scol, erow, ecol = unpack(range)
  local other_end = false

  local vcol, vrow = vim.fn.col "v", vim.fn.line "v"
  local ccol, crow = vim.fn.col ".", vim.fn.line "."
  if vrow > crow or (vrow == crow and vcol > ccol) then
    other_end = true
  end

  if ecol == 0 then
    erow = erow - 1
    ecol = #vim.fn.getline(erow + 1) + 1
  end

  vim.fn.setpos("'<", { 0, srow + 1, scol + 1, 0 })
  vim.fn.setpos("'>", { 0, erow + 1, ecol, 0 })
  if other_end then
    vim.cmd.normal { "gvo", bang = true }
  else
    vim.cmd.normal { "gv", bang = true }
  end
end

local function select_current_node()
  local node = vim.treesitter.get_node { ignore_injections = false }
  if not node then
    return
  end

  vim.cmd.normal { "v", bang = true }
  visual_select { node:range() }
end

local function set_incremental_selection_keymaps()
  local select = require "vim.treesitter._select"
  vim.keymap.set("n", "<c-n>", select_current_node, { silent = true })
  vim.keymap.set("x", "<c-n>", function()
    select.select_parent(vim.v.count1)
  end, { silent = true })
  vim.keymap.set("x", "<c-h>", function()
    select.select_child(vim.v.count1)
  end, { silent = true })
  vim.keymap.set("x", "<c-l>", function()
    select.select_parent(vim.v.count1)
  end, { silent = true })
end

---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "LiadOz/nvim-dap-repl-highlights",
    },
    config = function()
      local treesitter = require "nvim-treesitter"
      treesitter.setup {
        install_dir = vim.fs.joinpath(vim.fn.stdpath "data", "site"),
      }

      local parser_config = require "nvim-treesitter.parsers"
      parser_config.c3 = {
        install_info = {
          url = "https://github.com/c3lang/tree-sitter-c3",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
      }

      require("nvim-dap-repl-highlights").setup()
      set_incremental_selection_keymaps()
      maybe_install_missing_parsers()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          start_treesitter(args.buf)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      local tscontext = require "treesitter-context"
      tscontext.setup {
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
      end, { silent = true })
    end,
  },
}
