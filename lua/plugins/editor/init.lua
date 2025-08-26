--[[
 * Editor plugins configuration.
 * 
 * This file contains all editor-related plugins including file explorer,
 * terminal integration, and editing enhancements.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: editor/init.lua
 * Description: Editor plugins configuration
--]]

return {
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
					side = "left",
					adaptive_size = true,
				},
				renderer = {
					group_empty = true,
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
						glyphs = {
							default = "📄",
							symlink = "🔗",
							folder = {
								default = "📁",
								open = "📂",
								empty = "📁",
								empty_open = "📂",
								symlink = "🔗",
								symlink_open = "🔗",
							},
							git = {
								unstaged = "💫",
								staged = "✨",
								unmerged = "💥",
								renamed = "🔄",
								untracked = "💭",
								deleted = "💔",
								ignored = "👻",
							},
						},
					},
				},
				filters = {
					dotfiles = false,
					custom = {},
					exclude = {},
				},
				git = {
					ignore = false,
					show_on_dirs = true,
				},
				actions = {
					use_system_clipboard = true,
					change_dir = {
						enable = true,
						global = false,
						restrict_above_cwd = false,
					},
					expand_all = {
						max_folder_discovery = 300,
						exclude = {},
					},
					file_popup = {
						open_win_config = {
							col = 1,
							row = 1,
							relative = "cursor",
							border = "shadow",
							style = "minimal",
						},
					},
					open_file = {
						quit_on_open = false,
						resize_window = true,
						window_picker = {
							enable = true,
							chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
							exclude = {
								filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
								buftype = { "nofile", "terminal", "help" },
							},
						},
					},
				},
				live_filter = {
					prefix = "🔍 ",
					always_show_folders = true,
				},
				log = {
					enable = false,
					truncate = false,
					types = {
						all = false,
						config = false,
						copy_paste = false,
						dev = false,
						diagnostics = false,
						git = false,
						profile = false,
						watcher = false,
					},
				},
				notify = {
					threshold = vim.log.levels.INFO,
				},
				ui = {
					confirm = {
						remove = true,
						trash = true,
					},
				},
			})
		end,
	},

	-- Terminal management
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "horizontal",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
						"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			-- あたし、FZF拡張の条件を改善したの…makeコマンドがない場合でも動作するように（╹◡╹）
			return vim.fn.executable("make") == 1 and vim.fn.has("unix") == 1
		end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = "💕 ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
							["<C-l>"] = require("telescope.actions").send_to_qflist,
						},
						n = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
							["<C-l>"] = require("telescope.actions").send_to_qflist,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
					grep_string = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						theme = "dropdown",
						previewer = false,
						mappings = {
							i = {
								["<C-d>"] = require("telescope.actions").delete_buffer,
							},
							n = {
								["<C-d>"] = require("telescope.actions").delete_buffer,
							},
						},
					},
					planets = {
						show_pluto = true,
						show_moon = true,
					},
					git_files = {
						hidden = true,
						show_untracked = true,
					},
					git_commits = {
						git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "-G", "." },
						git_command_args = { "git", "log", "--pretty=oneline", "--abbrev-commit" },
						max_results = 100,
						conflicts = {},
					},
					git_bcommits = {
						git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit" },
						git_command_args = { "git", "log", "--pretty=oneline", "--abbrev-commit" },
						max_results = 100,
						conflicts = {},
					},
					git_branches = {
						git_command = { "git", "branch", "--all" },
						git_command_args = { "git", "branch", "--all" },
						max_results = 100,
						conflicts = {},
					},
					git_status = {
						git_command = { "git", "status", "--porcelain" },
						git_command_args = { "git", "status", "--porcelain" },
						max_results = 100,
						conflicts = {},
					},
				},
				extensions = {
					-- FZF extension configuration (only if available)
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- Load extensions with better error handling
			-- あたし、FZF拡張の読み込みを改善したの…エラーが発生しないように（╹◡╹）
			local fzf_ok, _ = pcall(require("telescope").load_extension, "fzf")
			if fzf_ok then
				-- Configure FZF extension if available
				require("telescope").load_extension("fzf")
				vim.notify("✨ FZF extension loaded successfully!", vim.log.levels.INFO)
			else
				vim.notify("💫 Using default Telescope fuzzy finder (FZF not available)", vim.log.levels.INFO)
			end
			
			-- Load UI select extension
			local ui_select_ok, _ = pcall(require("telescope").load_extension, "ui-select")
			if ui_select_ok then
				vim.notify("✨ UI Select extension loaded successfully!", vim.log.levels.INFO)
			else
				vim.notify("⚠️ UI Select extension failed to load", vim.log.levels.WARN)
			end
		end,
	},

	-- Tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"json",
					"yaml",
					"markdown",
					"bash",
					"python",
					"go",
					"rust",
					"cpp",
					"c",
				},
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
				context_commentstring = { enable = true },
			})
		end,
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Which key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
		},
	},
} 