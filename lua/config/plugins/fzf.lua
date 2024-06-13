---@type LazyPluginSpec
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  event = "VeryLazy",
  keys = {
    {
      "<c-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Files",
    },

    {
      "<c-w>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<c-h>",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Old files",
    },
    {
      "<leader>rs",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume",
    },
    {
      "<c-f>",
      function()
        require("fzf-lua").live_grep_native()
      end,
      desc = "Live grep",
    },
    {
      "<leader>fi",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "Git status",
    },
    {
      "<c-t>",
      function()
        require("fzf-lua").tabs()
      end,
      desc = "Tab List",
    },
  },
  opts = {
    hls = {
      normal = "NormalFloat",
      border = "FloatBorder",
      title = "FloatTitle",
      preview_normal = "NormalFloat",
      preview_border = "FloatBorder",
      preview_title = "FloatTitle",
    },
    fzf_colors = {
      ["fg"] = { "fg", "CursorLine" },
      ["bg"] = { "bg", "NormalFloat" },
      ["hl"] = { "fg", "Statement" },
      ["fg+"] = { "fg", "NormalFloat" },
      ["bg+"] = { "bg", "CursorLine" },
      ["hl+"] = { "fg", "Statement" },
      ["info"] = { "fg", "PreProc" },
      ["prompt"] = { "fg", "Conditional" },
      ["pointer"] = { "fg", "Exception" },
      ["marker"] = { "fg", "Keyword" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "NormalFloat" },
    },
  },
  config = function()
    local fzf = require "fzf-lua"
    fzf.setup {
      global_resume = true,
      global_resume_query = true,
      winopts = {
        height = 0.85,
        width = 0.95,
        preview = {
          layout = "horizontal",
          scrollbar = "float",
        },
        -- fullscreen = true,
        vertical = "down:45%", -- up|down:size
        horizontal = "right:60%", -- right|left:size
        hidden = "nohidden",
      },
      keymap = {
        builtin = {
          ["<c-f>"] = "toggle-fullscreen",
          ["<c-r>"] = "toggle-preview-wrap",
          ["<c-p>"] = "toggle-preview",
          ["<c-y>"] = "preview-page-down",
          ["<c-l>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["esc"] = "abort",
          ["ctrl-h"] = "unix-line-discard",
          ["ctrl-k"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-n"] = "beginning-of-line",
          ["ctrl-a"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
          ["ctrl-e"] = "down",
          ["ctrl-u"] = "up",
        },
      },
      previewers = {
        bat = {
          cmd = "bat",
          theme = "gruvbox-dark",
          args = "--color=always --style=numbers,changes",
        },
        head = {
          cmd = "head",
          args = nil,
        },
        git_diff = {
          cmd_deleted = "git diff --color HEAD --",
          cmd_modified = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
          pager = "difftool",
        },
        man = {
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          --NOTE: THe `chafa` not work So I change to `viu`(rust)
          extensions = {
            ["png"] = { "viu" },
            ["webp"] = { "viu" },
            ["jpg"] = { "viu" },
            ["jpeg"] = { "viu" },
          },
        },
      },
      files = {
        formatter = { "path.filename_first" },
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        -- previewer = "bat",
        prompt = "Files❯ ",
        cwd_prompt = false,
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        --NOTE: the .git folder shoul be the working directory
        cwd = require("fzf-lua").path.git_root(nil, true),
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules",
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
      },
    }
  end,
}
