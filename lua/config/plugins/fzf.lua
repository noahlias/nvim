local m = { noremap = true }
---@type LazyPluginSpec
return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
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
    -- vim.keymap.set('n', '<c-f>', function()
    -- 	-- fzf.live_grep_resume({ multiprocess = true, debug = true })
    -- 	fzf.grep({ search = "", fzf_opts = { ['--layout'] = 'default' } })
    -- end, m)
    -- vim.keymap.set('x', '<c-f>', function()
    -- 	-- fzf.live_grep_resume({ multiprocess = true, debug = true })
    -- 	fzf.grep_visual({ fzf_opts = { ['--layout'] = 'default' } })
    -- end, m)
    fzf.setup {
      global_resume = true,
      global_resume_query = true,
      winopts = {
        -- height     = 0.6,
        -- width      = 0.7,
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
        head = {
          cmd = "head",
          args = nil,
        },
        git_diff = {
          cmd_deleted = "git diff --color HEAD --",
          cmd_modified = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
          -- pager        = "delta",      -- if you have `delta` installed
        },
        man = {
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          -- extensions     = {
          -- 	['png'] = { 'chafa' },
          -- 	['webp'] = { 'chafa' },
          -- 	['jpg'] = { 'chafa' },
          -- }
        },
      },
      files = {
        -- previewer    = "bat", -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt = "Files❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
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
