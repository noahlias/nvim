---@type LazyPluginSpec[]
return {
  {
    "folke/which-key.nvim",
    event = "BufReadPost",
    enabled = true,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      window = {
        margin = { 1, 0, 0.03, 0.75 },
        border = "single",
      },
      layout = {
        height = { min = 4, max = 75 },
        align = "right",
      },
      show_keys = false,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup {
        -- General options
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "Your mom", -- Text displayed when hovered over the Neovim image
        main_image = "neovim", -- Main image display (either "neovim" or "file")
        client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
        log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project
        blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time = true, -- Show the timer

        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      }
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    version = "*",
    dependencies = { "luarocks.nvim", { "laher/neorg-exec" } },
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
      image_support = true,
      lang = "python3",
      description = {
        widht = "100%",
      },
      injector = {
        ["python3"] = {
          before = true,
        },
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
        enable = true,
      },
      picker = {
        name = "fzf-lua",
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
      local yazi = require("toggleterm.terminal").Terminal:new {
        cmd = "yazi",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        on_open = function(term)
          vim.cmd "startinsert!"
        end,
        close_on_exit = true,
      }
      local serpl = require("toggleterm.terminal").Terminal:new {
        cmd = "serpl",
        hidden = true,
        direction = "float",
        float_opts = float_opts,
        on_open = function(term)
          vim.cmd "startinsert!"
        end,
        close_on_exit = true,
      }

      return {
        { "<C-\\>" },
        {
          "<leader>a",
          "<Cmd>ToggleTermToggleAll<CR>",
          mode = "n",
          desc = "All Terminal",
        },
        {
          "<leader>pd",
          function()
            lazydocker:toggle()
          end,
          desc = "Lazy Docker",
        },
        {
          "<leader>pg",
          function()
            gh_dash:toggle()
          end,
          desc = "GitHub Dash",
        },
        {
          "<leader>n",
          function()
            yazi:toggle()
          end,
          desc = "File Navigator",
        },
        {
          "<leader>sp",
          function()
            serpl:toggle()
          end,
          desc = "Search And Replace",
        },
      }
    end,
  },
  {
    "willothy/flatten.nvim",
    opts = {
      nest_if_no_args = true,
      window = {
        open = "alternate",
      },
    },
    priority = 1001,
  },
  {
    "3rd/image.nvim",
    enabled = true,
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
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = true,
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    init = function()
      vim.g.startuptime_tries = 10
    end,
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
    version = "0.1.*",
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
      { "<leader>gdo", "<Cmd>DiffviewOpen<CR>", desc = "Open" },
      { "<leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close" },
      { "<leader>gdh", "<Cmd>DiffviewFileHistory<CR>", desc = "Open History" },
      {
        "<leader>gdf",
        "<Cmd>DiffviewFileHistory %<CR>",
        desc = "Current History",
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
    },
    init = function()
      vim.keymap.set(
        "v",
        "<leader>fr",
        ":Freeze<cr>",
        { silent = true, desc = "Freeze selection" }
      )
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    ft = { "markdwon", "tex", "typ" },
    cmd = {
      "PasteImage",
    },
    event = "VeryLazy",
    opts = {},
  },
  -- {
  --   "aznhe21/actions-preview.nvim",
  --   lazy = true,
  --   init = function()
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       desc = "Setup code action preview",
  --       callback = function(args)
  --         local bufnr = args.buf
  --
  --         vim.keymap.set({ "n", "v" }, "<leader>la", function()
  --           require("actions-preview").code_actions()
  --         end, { buffer = bufnr, desc = "LSP: Code action" })
  --       end,
  --     })
  --   end,
  --   config = function()
  --     require("actions-preview").setup {}
  --   end,
  -- },
  {
    "mrcjkb/haskell-tools.nvim",
    event = "BufRead *.hs",
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
      vim.g.vimtex_compiler_latexrun_engines = { _ = "xelatex" }
      vim.g.vimtex_compiler_progname = "nvr"
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
  --   version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  --   build = ":UpdateRemotePlugins",
  --   -- event = "VeryLazy",
  --   ft = { "python", "ipynb" },
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
  --       "<leader>mv",
  --       "<cmd>MoltenEvaluateVisual<CR>",
  --       desc = "Evaluate the selected text.",
  --     },
  --     {
  --       "<leader>mc",
  --       "<cmd>MoltenEvaluateOperator<CR>",
  --       desc = "Reevaluate the currently selected cell.",
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
        "<leader>ve",
        ":lua Toggle_venn()<CR>",
        { noremap = true, desc = "Toggle venn" }
      )
    end,
  },
  -- NOTE: wonderful toggle plugin
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      },
    },
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    opts = {
      win_opts = {
        ---NOTE: fix the position conflict with which-key
        row = 10,
        border = "rounded",
      },
    },
  },
}
