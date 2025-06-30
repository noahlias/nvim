local function toggle_diffview(cmd)
  if next(require("diffview.lib").views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd "DiffviewClose"
  end
end

---@type LazyPluginSpec[]
return {
  {
    "folke/which-key.nvim",
    event = { "BufNewFile", "BufReadPre" },
    enabled = true,
    opts = {
      spec = {
        {
          mode = { "n" },
          { "<leader>t", group = "tabs/terminal/trouble" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gd", group = "git diffview" },
          { "<leader>w", group = "windows" },
          { "<leader>s", group = "search" },
          { "<leader>n", group = "Lsp" },
          { "<leader>'", group = "debugger" },
          { "<leader>l", group = "lsp format" },
          { "<leader>q", group = "session" },
          { "<leader>r", group = "build" },
          { "<leader>T", group = "tests" },
          { "<leader>m", group = "misc" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
        },
      },
      preset = "helix",
      triggers = {
        { "<auto>", mode = "nixsotc" },
      },
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "andweeb/presence.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("presence").setup {
        -- General options
        auto_update = true,
        neovim_image_text = "Your mom",
        main_image = "neovim",
        client_id = "793271441293967371",
        log_level = nil,
        debounce_timeout = 10,
        enable_line_number = false,
        blacklist = {},
        buttons = true,
        file_assets = {},
        show_time = true,
        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        line_number_text = "Line %s out of %s",
      }
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    enabled = false,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    version = "*",
    enabled = false,
    dependencies = { "luarocks.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    event = "VeryLazy",
    lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1),
    enabled = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
      image_support = false,
      lang = "python3",
      arg = "leetcode.nvim",
      hooks = {
        ["question_enter"] = {
          function()
            vim.g.copilot_enabled = false
          end,
        },
      },
      injector = {
        ["cpp"] = {
          before = {
            "#include <iostream>",
            "#include <vector>",
            "#include <algorithm>",
            "using namespace std;",
          },
          after = "int main() {}",
        },
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      --FIX: problem with snippet not works
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "3rd/image.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Noahlias",
        },
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      ui = {
        enable = false,
      },
      picker = {
        name = "fzf-lua",
      },
      completion = {
        nvim_cmp = true,
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      on_create = function(t)
        local bufnr = t.bufnr
        vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
      end,
      float_opts = {
        border = "rounded",
      },
      winbar = {
        enabled = true,
      },
      shade_terminals = false,
      shade_filetypes = { "none", "fzf" },
    },
    keys = function()
      local float_opts = {
        border = "rounded",
      }

      local lazydocker = require("toggleterm.terminal").Terminal:new {
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
      }
      local gh_dash = require("toggleterm.terminal").Terminal:new {
        -- https://github.com/dlvhdr/gh-dash/issues/316
        env = { LANG = "en_US.UTF-8" },
        cmd = "gh dash",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
      }
      local serpl = require("toggleterm.terminal").Terminal:new {
        cmd = "serpl",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        on_open = function(_)
          vim.cmd "startinsert!"
        end,
        close_on_exit = true,
      }
      local bili = require("toggleterm.terminal").Terminal:new {
        cmd = "bili",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        close_on_exit = true,
      }

      local lowfi = require("toggleterm.terminal").Terminal:new {
        cmd = "genact",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        close_on_exit = true,
      }
      --- lazygit
      local lazygit = require("toggleterm.terminal").Terminal:new {
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        close_on_exit = true,
      }
      return {
        { "<C-\\>" },
        {
          "<leader>ta",
          "<Cmd>ToggleTermToggleAll<CR>",
          mode = "n",
          desc = "All Terminal",
        },
        {
          "<leader>gl",
          function()
            lazygit:toggle()
          end,
          desc = "Lazy Git",
        },
        {
          "<leader>tl",
          function()
            lazydocker:toggle()
          end,
          desc = "Lazy Docker",
        },
        {
          "<leader>tg",
          function()
            gh_dash:toggle()
          end,
          desc = "GitHub Dash",
        },
        {
          "<leader>tp",
          function()
            serpl:toggle()
          end,
          desc = "Search And Replace",
        },
        {
          "<leader>tb",
          function()
            bili:toggle()
          end,
          desc = "Bili Danmaku",
        },
        {
          "<leader>ti",
          function()
            lowfi:toggle()
          end,
          desc = "Bili Danmaku",
        },
      }
    end,
  },
  {
    "willothy/flatten.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      nest_if_no_args = true,
      window = {
        open = "alternate",
      },
    },
  },
  {
    "3rd/image.nvim",
    enabled = true,
    ft = { "markdown", "text", "norg" },
    init = function()
      package.path = package.path
        .. ";"
        .. vim.fn.expand "$HOME"
        .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path
        .. ";"
        .. vim.fn.expand "$HOME"
        .. "/.luarocks/share/lua/5.1/?.lua;"
    end,
    opts = {
      backend = "kitty",
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki", "nvim" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = false,
          filetypes = { "typst" },
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      -- window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = true,
    },
  },
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
    cmd = { "StartupTime" },
  },
  {
    "utilyre/sentiment.nvim",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      {
        included_buftypes = {
          [""] = true,
        },
        excluded_filetypes = { "norg" },
        delay = 50,
        limit = 100,
        pairs = {
          { "(", ")" },
          { "{", "}" },
          { "[", "]" },
        },
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    event = "VeryLazy",
    build = function()
      require("typst-preview").update()
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "<leader>gdo",
        function()
          toggle_diffview "DiffviewOpen"
        end,
        desc = "GitDiff Open",
      },
      {
        "<leader>gdh",
        function()
          toggle_diffview "DiffviewFileHistory"
        end,
        desc = "GitDiff Open History",
      },
      {
        "<leader>gdf",
        "<Cmd>DiffviewFileHistory %<CR>",
        desc = "GitDiff Current History",
      },
    },
    opts = function()
      local actions = require "diffview.actions"

      return {
        enhanced_diff_hl = true,
        show_help_hints = false,
        file_panel = {
          win_config = {
            width = math.floor(vim.go.columns * 0.2) > 25 and math.floor(
              vim.go.columns * 0.2
            ) or 25,
          },
        },
        hooks = {
          diff_buf_win_enter = function(_, winid)
            vim.wo[winid].wrap = false
          end,
        },
        keymaps = {
          view = {
            { "n", "q", actions.close, { desc = "Close diffview" } },
            { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
          },
          file_panel = {
            { "n", "q", actions.close, { desc = "Close diffview" } },
            { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
          },
          file_history_panel = {
            { "n", "q", actions.close, { desc = "Close diffview" } },
            { "n", "<Esc>", actions.close, { desc = "Close diffview" } },
          },
        },
      }
    end,
  },
  {
    "ethanholz/freeze.nvim",
    event = "VeryLazy",
    opts = {
      theme = "catppuccin-mocha",
      config = "full",
      ["font.family"] = "JetBrainsMono Nerd Font",
    },
    cmd = "Freeze",
  },
  {
    "HakonHarnes/img-clip.nvim",
    cmd = {
      "PasteImage",
    },
    ft = { "markdown", "typst", "tex" },
    event = "VeryLazy",
    opts = {},
  },
  {
    "mrcjkb/haskell-tools.nvim",
    event = { "BufNewFile *.hs", "BufReadPost *.hs" },
    version = "^3", -- Recommended
    lazy = false,
  },
  {
    "Julian/lean.nvim",
    enabled = true,
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      stderr = {
        enable = false,
      },
    },
  },
  {
    "lervag/vimtex",
    enabled = true,
    ft = "tex",
    config = function()
      -- VimTeX configuration goes here
      vim.g.tex_flavor = "latex"

      vim.g.vimtex_mappings_prefix = "<localleader>"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" }
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
      }
      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "content", "todo", "include" },
        split_width = 25,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
      }
    end,
  },
  -- {
  --   "benlubas/molten-nvim",
  --   build = ":UpdateRemotePlugins",
  --   -- event = "VeryLazy",
  --   ft = { "python", "ipynb" },
  --   enabled = false,
  --   dependencies = {
  --     "3rd/image.nvim",
  --   },
  --   init = function()
  --     vim.g.molten_image_provider = "image.nvim"
  --     vim.g.molten_output_win_max_height = 20
  --   end,
  --   keys = {
  --     {
  --       "<leader>mi",
  --       "<cmd>MoltenInit<CR>",
  --       desc = "This command initializes a runtime for the current buffer.",
  --     },
  --     {
  --       "<leader>mo",
  --       "<cmd>MoltenEvaluateOperator<CR>",
  --       desc = "Evaluate the text given by some operator.",
  --     },
  --     {
  --       "<leader>ml",
  --       "<cmd>MoltenEvaluateLine<CR>",
  --       desc = "Evaluate the current line.",
  --     },
  --     {
  --       "<leader>mr",
  --       "<cmd>MoltenRestart!<CR>",
  --       desc = "Shuts down and restarts the current kernel.",
  --     },
  --     {
  --       "<leader>mx",
  --       "<cmd>MoltenInterrupt<CR>",
  --       desc = "Interrupts the currently running cell and does nothing if not cell is running.",
  --     },
  --   },
  -- },
  --NOTE: add ascii diagram support
  {
    "jbyuki/venn.nvim",
    -- enabled = false,
    event = "VeryLazy",
    config = function()
      -- venn.nvim: enable or disable keymappings
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        local opts = { noremap = true, silent = true }
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", opts)
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", opts)
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", opts)
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", opts)
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(
            0,
            "v",
            "v",
            ":VBox<CR>",
            { noremap = true }
          )
        else
          vim.cmd [[setlocal ve=]]
          vim.api.nvim_buf_del_keymap(0, "n", "J")
          vim.api.nvim_buf_del_keymap(0, "n", "K")
          vim.api.nvim_buf_del_keymap(0, "n", "L")
          vim.api.nvim_buf_del_keymap(0, "n", "H")
          vim.api.nvim_buf_del_keymap(0, "v", "v")
          vim.b.venn_enabled = nil
        end
      end
      -- toggle keymappings for venn using <leader>v
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mv",
        ":lua Toggle_venn()<CR>",
        { noremap = true, desc = "Toggle venn", silent = true }
      )
    end,
  },
  ---NOTE: not useful
  {
    "xiyaowong/transparent.nvim",
    cmd = "TransparentToggle",
    enabled = false,
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      },
    },
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    opts = {},
  },
  {
    "mistweaverco/kulala.nvim",
    event = "VeryLazy",
    opts = {
      {
        debug = true,
        -- additional cURL options
        -- see: https://curl.se/docs/manpage.html
        additional_curl_options = {
          "--insecure",
          "--compressed",
          "--user-agent",
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
        },
        -- enable winbar
        winbar = true,
      },
    },
  },
  {
    "leath-dub/snipe.nvim",
    event = "VeryLazy",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        max_height = -1, -- -1 means dynamic height
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        position = "topleft",
        -- Override options passed to `nvim_open_win`
        -- Be careful with this as snipe will not validate
        -- anything you override here. See `:h nvim_open_win`
        -- for config options
        open_win_override = {
          -- title = "My Window Title",
          border = "rounded", -- use "rounded" for rounded border
        },

        hints = {
          dictionary = "sadflwcmpgho",
        },
        -- Preselect the currently open buffer
        preselect_current = false,

        -- Set a function to preselect the currently open buffer
        -- E.g, `preselect = require("snipe").preselect_by_classifier("#")` to
        -- preselect alternate buffer (see :h ls and look at the "Indicators")
        preselect = nil, -- function (bs: Buffer[] [see lua/snipe/buffer.lua]) -> int (index)

        -- Changes how the items are aligned: e.g. "<tag> foo    " vs "<tag>    foo"
        -- Can be "left", "right" or "file-first"
        -- NOTE: "file-first" buts the file name first and then the directory name
        text_align = "left",
      },
    },
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      floating_window_scaling_factor = 0.85,
      open_for_directories = true,
      open_multiple_tabs = true,
      keymaps = { cycle_open_buffers = "<leader><tab>" },
    },
    keys = {
      {
        "<leader>tn",
        "<cmd>Yazi<cr>",
        desc = "Open the file manager",
      },
      {
        "<leader>tw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager working directory",
      },
      {
        "<c-m>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
  },
  -- { "nvchad/volt", lazy = true },
  -- {
  --   "nvchad/minty",
  --   lazy = true,
  --   keys = {
  --     {
  --       "<leader>mc",
  --       function()
  --         require("minty.huefy").open()
  --       end,
  --       desc = "Open color picker",
  --     },
  --   },
  -- },
  {
    "3rd/diagram.nvim",
    event = "VeryLazy",
    ft = "markdown",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {
      renderer_options = {
        plantuml = {
          charset = "utf-8",
        },
        mermaid = {
          theme = "forest",
        },
        d2 = {
          theme_id = 1,
        },
        gnuplot = {
          theme = "light",
        },
      },
    },
  },
  {
    "fei6409/log-highlight.nvim",
    event = "VeryLazy",
    ft = "log",
    config = function()
      require("log-highlight").setup {}
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    -- event = "VeryLazy",
    branch = "regexp",
    ft = "python",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("venv-selector").setup {
        -- Your options go here
        -- name = "venv",
        -- auto_refresh = false
        stay_on_this_version = true,
        dap_enabled = true,
        settings = {
          search = {
            anaconda_base = {
              command = "fd /bin/python$ /opt/Homebrew/Caskroom/miniforge/base/ --full-path --color never -E /proc -E /pkgs/ -I -a -L",
              type = "anaconda",
            },
          },
        },
      }
    end,
  },
  {
    "rmagatti/auto-session",
    -- event = "VeryLazy",
    lazy = false,
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>sr", "<cmd>SessionSearch<CR>", desc = "Session search" },
      { "<leader>sv", "<cmd>SessionSave<CR>", desc = "Save session" },
      {
        "<leader>sa",
        "<cmd>SessionToggleAutoSave<CR>",
        desc = "Toggle autosave",
      },
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      -- ⚠️ This will only work if Telescope.nvim is installed
      -- The following are already the default values, no need to provide them if these are already the settings you want.
      bypass_save_filetypes = {
        "alpha",
        "dashboard",
        "copilot-chat",
        "buftype",
        "nofile",
        "diff",
        "quickfix",
      },
      allowed_dirs = {
        "~/Downloads/m/misc/projects/thinker_project/*",
      },
      auto_restore = true,
      purge_after_minutes = 10080,
      session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = true,
        previewer = false,
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { "i", "<C-D>" },
          alternate_session = { "i", "<C-S>" },
          copy_session = { "i", "<C-Y>" },
        },
        -- Can also set some Telescope picker options
        -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
        theme_conf = {
          border = true,
          -- layout_config = {
          --   width = 0.8, -- Can set width and height as percent of window
          --   height = 0.5,
          -- },
        },
      },
    },
  },
  -- lua with lazy.nvim
  { "wakatime/vim-wakatime", event = "VeryLazy" },
  -- { "eraserhd/parinfer-rust", build = "cargo build --release" },
  {
    "scalameta/nvim-metals",
    event = {
      "BufReadPost *.scala",
      "BufNewFile *.scala",
      "BufReadPost *.sbt",
      "BufNewFile *.sbt",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group =
        vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    "EvWilson/spelunk.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- For window drawing utilities
      "nvim-treesitter/nvim-treesitter", -- Optional: for showing grammar context
    },
    opts = {
      -- Configuration options for spelunk.nvim
      enable_persist = true, -- Enable persistent spelunking across sessions
      -- Additional options can be added here
    },
  },
  {
    "axkirillov/unified.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
    },
  },
  {
    "nvimdev/visualizer.nvim",
    event = "VeryLazy",
  },
}
