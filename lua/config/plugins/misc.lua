return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		enabled = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = { margin = { 1, 0, 0.03, 0.6 }, border = "single" },
			layout = { height = { min = 4, max = 75 }, align = "right", },
		}
	},
	{
		-- NOTE: there is some note about this misc
		"mvllow/stand.nvim",
		lazy = true,
		config = function()
			require("stand").setup({
				minute_interval = 60
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- TODO: something to write
		-- TODO: this is a test
		opts = {},
	},
	{
		'andweeb/presence.nvim',
		config = function()
			require("presence").setup({
				-- General options
				auto_update         = true,                   -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
				neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
				main_image          = "neovim",               -- Main image display (either "neovim" or "file")
				client_id           = "793271441293967371",   -- Use your own Discord application client id (not recommended)
				log_level           = nil,                    -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
				debounce_timeout    = 10,                     -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
				enable_line_number  = false,                  -- Displays the current line number instead of the current project
				blacklist           = {},                     -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
				buttons             = true,                   -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
				file_assets         = {},                     -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
				show_time           = true,                   -- Show the timer

				-- Rich Presence text options
				editing_text        = "Editing %s",     -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
				file_explorer_text  = "Browsing %s",    -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
				git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
				reading_text        = "Reading %s",     -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
				workspace_text      = "Working on %s",  -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
				line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
			})
		end
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		config = function()
			require("venv-selector").setup({
				anaconda_base_path = "/opt/Homebrew/Caskroom/miniforge/base",
				annconda_ens_path = "/opt/Homebrew/Caskroom/miniforge/base/envs",
			})
		end,
		ft = "python",
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = { { "<leader>vs", "<cmd>:VenvSelect<cr>",
			-- optional if you use a autocmd (see #🤖-Automate)
			"<leader>vc", "<cmd>:VenvSelectCached<cr>"
		} },

	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					-- ["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
					["core.integrations.nvim-cmp"] = {},
					["core.concealer"] = { config = { icon_preset = "diamond" } },
					["core.keybinds"] = {
						-- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
						config = {
							default_keybinds = true,
							neorg_leader = "<Leader><Leader>",
						},
					},
					["core.export"] = {},
					["core.ui.calendar"] = {},
					["core.export.markdown"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			}
		end,
	}
	,
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- configuration goes here
			image_support = true,
			lang = "python3",
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Noahlias",
				},

				-- see below for full list of options 👇
			},
		}
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
			--shell = vim.uv.os_uname().sysname == "Windows_NT" and "pwsh" or "fish",
			shell = "zsh",
			float_opts = {
				border = "rounded",
			},
			winbar = {
				enabled = true,
			},
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
					vim.cmd("startinsert!")
				end,
				close_on_exit = true,
			}

			return {
				{ "<C-\\>" },
				{ "<leader>a", "<Cmd>ToggleTermToggleAll<CR>", mode = "n", desc = "All Terminal" },
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
	},
	{
		"3rd/image.nvim",
		-- enabled = false,
		init = function()
			package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua;"
			package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua;"
		end,
		event = function(plugin)
			return {
				{
					event = "BufRead",
					pattern = plugin.opts.hijack_file_patterns,
				},
			}
		end,
		opts = {
			backend = "kitty",
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "markdown", "vimwiki", "nvim" }, -- markdown extensions (ie. quarto) can go here
				},
				neorg = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "norg" },
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			kitty_method = "normal",
		}
	},
	{
		"dstein64/vim-startuptime",
		cmd = { "StartupTime" },
	},
	-- {
	-- 	"mikesmithgh/kitty-scrollback.nvim",
	-- 	cmd = {
	-- 		"KittyScrollbackGenerateKittens",
	-- 		"KittyScrollbackCheckHealth",
	-- 	},
	-- 	event = { "User KittyScrollbackLaunch" },
	-- 	opts = {
	-- 		{
	-- 			paste_window = {
	-- 				winopts_overrides = function(winopts)
	-- 					winopts.border = {
	-- 						"╭",
	-- 						"─",
	-- 						"╮",
	-- 						"│",
	-- 						"┤",
	-- 						"─",
	-- 						"├",
	-- 						"│",
	-- 					}
	-- 					return winopts
	-- 				end,
	-- 				footer_winopts_overrides = function(winopts)
	-- 					winopts.border = {
	-- 						"│",
	-- 						" ",
	-- 						"│",
	-- 						"│",
	-- 						"╯",
	-- 						"─",
	-- 						"╰",
	-- 						"│",
	-- 					}
	-- 					return winopts
	-- 				end,
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy", -- keep for lazy loading
		opts = {
			{
				---Dictionary to check whether a buftype should be included.
				---
				---@type table<string, boolean>
				included_buftypes = {
					[""] = true,
				},

				---Dictionary to check whether a filetype should be excluded.
				---
				---@type table<string, boolean>
				excluded_filetypes = {},

				---How much to wait before calculating the location of pairs.
				---
				---@type integer
				delay = 50,

				---How many lines to look backwards/forwards to find a pair.
				---
				---@type integer
				limit = 100,

				---List of `(left, right)` pairs.
				---
				---@type tuple<string, string>[]
				pairs = {
					{ "(", ")" },
					{ "{", "}" },
					{ "[", "]" },
				},
			}
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	}
	,
	{
		"https://github.com/apple/pkl-neovim",
		lazy = true,
		event = "BufReadPre *.pkl",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd("TSInstall! pkl")
		end,
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = "markdown",
		lazy = true,
		config = true, -- or `opts = {}`
	},
	{
		'chomosuke/typst-preview.nvim',
		ft = 'typst',
		version = '0.1.*',
		build = function() require 'typst-preview'.update() end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
		},
		keys = {
			{ "<leader>gdo", "<Cmd>DiffviewOpen<CR>",          desc = "Open" },
			{ "<leader>gdc", "<Cmd>DiffviewClose<CR>",         desc = "Close" },
			{ "<leader>gdh", "<Cmd>DiffviewFileHistory<CR>",   desc = "Open History" },
			{ "<leader>gdf", "<Cmd>DiffviewFileHistory %<CR>", desc = "Current History" },
		},
		opts = function()
			local actions = require "diffview.actions"

			return {
				enhanced_diff_hl = true,
				show_help_hints = false,
				file_panel = {
					win_config = {
						width = math.floor(vim.go.columns * 0.2) > 25 and math.floor(vim.go.columns * 0.2) or 25,
					},
				},
				hooks = {
					diff_buf_win_enter = function(_, winid)
						vim.wo[winid].wrap = false
					end,
				},
				keymaps = {
					view = {
						{ "n", "q",     actions.close, { desc = "Close diffview" } },
						{ "n", "<Esc>", actions.close, { desc = "Close diffview" } },
					},
					file_panel = {
						{ "n", "q",     actions.close, { desc = "Close diffview" } },
						{ "n", "<Esc>", actions.close, { desc = "Close diffview" } },
					},
					file_history_panel = {
						{ "n", "q",     actions.close, { desc = "Close diffview" } },
						{ "n", "<Esc>", actions.close, { desc = "Close diffview" } },
					},
				},
			}
		end,
	},
	{
		"ethanholz/freeze.nvim",
		lazy = true,
		config = true,
	}
	,
	{
		"HakonHarnes/img-clip.nvim",
		ft = { "markdwon", "tex", "typ" },
		cmd = {
			"PasteImage",
		},
		opts = {},
		lazy = true,
	},
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Setup code action preview",
				callback = function(args)
					local bufnr = args.buf

					vim.keymap.set({ "n", "v" }, "<leader>la", function()
						require("actions-preview").code_actions()
					end, { buffer = bufnr, desc = "LSP: Code action" })
				end,
			})
		end,
		config = function()
			require("actions-preview").setup {}
		end,
	},
	{
		'mrcjkb/haskell-tools.nvim',
		version = '^3', -- Recommended
		lazy = false,
	}
	, {
	'Julian/lean.nvim',
	enabled = true,
	event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
	dependencies = {
		'neovim/nvim-lspconfig',
		'nvim-lua/plenary.nvim',
	},
	opts = {
	}
},
	{
		"smjonas/inc-rename.nvim",
		opts = {},
		cmd = {
			"IncRename",
		},
	}
}
