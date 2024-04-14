local m = { noremap = true, nowait = true }
local M = {}
local custom = {
	border = "rounded",
}

M.config = {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = '0.1.1',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {})
				end
			},
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			-- "nvim-telescope/telescope-ui-select.nvim",
			'stevearc/dressing.nvim',
			'dimaportenko/telescope-simulators.nvim',
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			{
				"danielfalk/smart-open.nvim",
				branch = "0.2.x",
				config = function()
					require("telescope").load_extension("smart_open")
				end,
				dependencies = {
					"kkharji/sqlite.lua",
					-- Only required if using match_algorithm fzf
					{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
					-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
					{ "nvim-telescope/telescope-fzy-native.nvim" },
				},
			},
			{
				"folke/noice.nvim",
				event = "VeryLazy",
				init = function()
					vim.o.cmdheight = 0

					-- Make sure to load noice when notify is called
					---@diagnostic disable-next-line: duplicate-set-field
					vim.notify = function(...)
						require("noice").notify(...)
					end
				end,
				dependencies = {
					"MunifTanjim/nui.nvim",
					"rcarriga/nvim-notify",
				},
				opts = {
					presets = {
						long_message_to_split = true,
						-- command_palette = true,
						inc_rename = true,
						bottom_search = true,
					},
					cmdline = {
						view = 'cmdline_popup',
						format = {
							search_down = {
								view = "cmdline",
							},
							search_up = {
								view = "cmdline",
							},
							substitute = {
								pattern = {
									"^:%s*%%s?n?o?m?/",
									"^:'<,'>%s*s?n?m?/",
									"^:%d+,%d+%s*s?n?m?/",
								},
								icon = " /",
								view = "cmdline",
								lang = "regex",
							},
						},
					},
					lsp = {
						override = {
							["vim.lsp.util.convert_input_to_markdown_lines"] = true,
							["vim.lsp.util.stylize_markdown"] = true,
							["cmp.entry.get_documentation"] = true,
						},
						progress = {
							enabled = false,
						},
						message = {
							enabled = false,
						},
						hover = {
							silent = true,
						}
					},
					views = {
						cmdline_popup = {
							position = {
								row = 5,
								col = "50%",
							},
							size = {
								width = 60,
								height = "auto",
							},
						},
						popupmenu = {
							relative = "editor",
							position = {
								row = 8,
								col = "50%",
							},
							size = {
								width = 60,
								height = 10,
							},
							border = {
								style = "rounded",
								padding = { 0, 1 },
							},
							win_options = {
								winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
							},
						},
						hover = {
							size = {
								max_width = 80,
							},
							border = {
								style = custom.border,
								padding = { 0, custom.border == "none" and 2 or 0 },
							},
							position = {
								row = custom.border == "none" and 1 or 2,
							},
						},
					},
				},
			}
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<c-p>', builtin.find_files, m)
			-- vim.keymap.set('n', '<c-f>', function()
			-- 	builtin.grep_string({ search = "" })
			-- end, m)
			vim.keymap.set('n', '<leader>rs', builtin.resume, m)
			vim.keymap.set('n', '<c-w>', builtin.buffers, m)
			vim.keymap.set('n', '<c-h>', builtin.oldfiles, m)
			vim.keymap.set('n', '<c-_>', builtin.current_buffer_fuzzy_find, m)
			vim.keymap.set('n', 'z=', builtin.spell_suggest, m)

			vim.keymap.set('n', '<leader>d', builtin.diagnostics, m)
			-- vim.keymap.set('n', 'gd', builtin.lsp_definitions, m)
			-- vim.keymap.set('n', '<c-t>', builtin.lsp_document_symbols, {})
			vim.keymap.set('n', 'gi', builtin.git_status, m)
			--vim.keymap.set("n", ":", builtin.commands, m)

			vim.keymap.set("n", "<leader><leader>", function()
				require("telescope").extensions.smart_open.smart_open()
			end, { noremap = true, silent = true })

			local trouble = require("trouble.providers.telescope")

			local ts = require('telescope')
			local actions = require('telescope.actions')
			M.ts = ts
			ts.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.95,
						height = 0.85,
						prompt_position = "top",
						horizontal = {
							preview_width = function(_, cols, _)
								if cols > 200 then
									return math.floor(cols * 0.4)
								else
									return math.floor(cols * 0.6)
								end
							end,
						},

						vertical = {
							width = 0.9,
							height = 0.95,
							preview_height = 0.5,
						},

						flex = {
							horizontal = {
								preview_width = 0.9,
							},
						},
					},
					mappings = {
						i = {
							["<RightMouse>"] = actions.close,
							["<LeftMouse>"] = actions.select_default,
							["<ScrollWheelDown>"] = actions.move_selection_next,
							["<ScrollWheelUp>"] = actions.move_selection_previous,
							["<C-h>"] = "which_key",
							["<C-u>"] = "move_selection_previous",
							["<C-e>"] = "move_selection_next",
							["<C-l>"] = "preview_scrolling_up",
							["<C-y>"] = "preview_scrolling_down",
							["<esc>"] = "close",
						}
					},
					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					selection_strategy = "reset",
					sorting_strategy = "descending",
					scroll_strategy = "cycle",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
						}
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					media_files = {
						filetypes = { "pdf", "mp4", "png", "webp", "jpg", "jpeg" },
						find_cmd = "rg"
					},
					-- command_palette = command_palette,
					smart_open = {
						show_scores = false,
						ignore_patterns = { "*.git/*", "*/tmp/*" },
						match_algorithm = "fzy",
						disable_devicons = false,
					},
				}
			})
			require('dressing').setup({
				select = {
					get_config = function(opts)
						if opts.kind == 'codeaction' then
							return {
								backend = 'telescope',
								telescope = require('telescope.themes').get_cursor()
							}
						end
					end
				}
			})

			ts.load_extension("yank_history")
			ts.load_extension('dap')
			ts.load_extension('telescope-tabs')
			ts.load_extension('fzf')
			ts.load_extension('simulators')
			ts.load_extension("commander")
			ts.load_extension("file_browser")
			ts.load_extension("media_files")
			ts.load_extension("noice")

			require("simulators").setup({
				android_emulator = false,
				apple_simulator = true,
			})
			-- ts.load_extension("ui-select")
			ts.load_extension("flutter")
			local tsdap = ts.extensions.dap;
			vim.keymap.set("n", "<leader>'v", tsdap.variables, m)
			vim.keymap.set("n", "<leader>'a", tsdap.commands, m)
			vim.keymap.set("n", "<leader>'b", tsdap.list_breakpoints, m)
			vim.keymap.set("n", "<leader>'f", tsdap.frames, m)
		end
	},
	{
		"FeiyouG/commander.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{ "<c-q>", "<CMD>Telescope commander<CR>", mode = "n" },
		},
		config = function()
			local commander = require("commander")
			commander.setup({
				components = {
					"DESC",
					"KEYS",
					"CMD"
				},
				sort_by = {
					"DESC",
					"KEYS",
					"CAT",
					"CMD"
				},
				integration = {
					telescope = {
						enable = true,
						theme = require("telescope.themes").commander
					},
					lazy = {
						enable = true
					}
				}
			})
			-- vim.keymap.set('n', '<c-q>', ":Telescope commander<CR>", m)
			commander.add({
				{
					desc = "Run Simulator",
					cmd = "<CMD>Telescope simulators run<CR>",
					keys = { "n", "<leader>sr" }
				},
				{
					desc = "Git diff",
					cmd = "<CMD>Telescope git_status<CR>",
					keys = { "n", "<leader>gs" }
				},
				{
					desc = "File browser",
					cmd = "<CMD>Telescope file_browser<CR>",
					keys = { "n", "<leader>fb" }
				},
				{
					desc = "Media Files",
					cmd = "<CMD>Telescope media_files<CR>",
					keys = { "n", "<leader>fm" }
				},
				{
					desc = "Smart Open",
					cmd = "<CMD>Telescope smart_open<CR>",
					keys = { "n", "<leader><leader>" }
				},
			})
		end
	}
}


return M
