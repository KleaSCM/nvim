--[[
 * UI plugins configuration.
 * 
 * This file contains all UI-related plugins including colorscheme,
 * icons, status line, and buffer line.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: ui/init.lua
 * Description: UI plugins configuration
--]]

return {
	-- Colorscheme - CATPPUCCIN MOCHA DARK! 💜💖💙
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		enabled = true,
		config = function()
			-- あたし、Catppuccinテーマを確実に適用したの…デフォルトの色が嫌だったから（╹◡╹）
			require("catppuccin").setup({
				flavour = "mocha", -- mocha, macchiato, frappe, latte
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = { "bold" },
					keywords = { "bold" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = { "bold" },
					operators = {},
				},
				color_overrides = {
					mocha = {
						-- VIOLENT ERROR COLORS! 🔥💀⚡ (but more balanced!)
						red = "#ff6b6b",      -- VIOLENT RED (softer)
						maroon = "#ff8e8e",   -- SCREAMING RED (softer)
						peach = "#ffa07a",     -- AGGRESSIVE ORANGE (softer)
						yellow = "#ffd93d",    -- NEON ORANGE (softer)
						green = "#6bcf7f",     -- BRIGHT GREEN (softer)
						teal = "#4ecdc4",      -- ELECTRIC TEAL (softer)
						sky = "#74b9ff",       -- AGGRESSIVE BLUE (softer)
						sapphire = "#0984e3",  -- SCREAMING BLUE (softer)
						blue = "#6c5ce7",      -- NEON BLUE (softer)
						lavender = "#a29bfe",  -- NEON MAGENTA (softer)
						flamingo = "#fd79a8",  -- SCREAMING MAGENTA (softer)
						pink = "#e84393",      -- AGGRESSIVE PINK (softer)
						mauve = "#9c88ff",     -- ELECTRIC PURPLE (softer)
						rosewater = "#fdcb6e", -- NEON PEACH (softer)
					},
				},
				custom_highlights = function(colors)
					return {
						-- VIOLENT ERROR HIGHLIGHTS! 🔥💀⚡
						DiagnosticError = {
							fg = colors.red,
							bg = "#000000",
							sp = colors.red,
							bold = true,
							underline = true,
							italic = true,
						},
						
						DiagnosticWarn = {
							fg = colors.peach,
							bg = "#000000",
							sp = colors.peach,
							bold = true,
							underline = true,
							italic = true,
						},
						
						DiagnosticInfo = {
							fg = colors.green,
							bg = "#000000",
							sp = colors.green,
							bold = true,
						},
						
						DiagnosticHint = {
							fg = colors.sky,
							bg = "#000000",
							sp = colors.sky,
							bold = true,
						},
						
						-- VIOLENT BUFFER LINE HIGHLIGHTS!
						BufferLineError = {
							fg = colors.red,
							bg = "#000000",
							sp = colors.red,
							bold = true,
							underline = true,
						},
						
						BufferLineWarning = {
							fg = colors.peach,
							bg = "#000000",
							sp = colors.peach,
							bold = true,
							underline = true,
						},
						
						-- VIOLENT SELECTION HIGHLIGHTS!
						Visual = {
							bg = colors.lavender,
							fg = "#000000",
							bold = true,
						},
						
						Search = {
							bg = colors.red,
							fg = "#000000",
							bold = true,
							underline = true,
						},
						
						-- VIOLENT GUTTER HIGHLIGHTS!
						DiagnosticSignError = {
							fg = colors.red,
							bg = "#000000",
							bold = true,
						},
						
						DiagnosticSignWarn = {
							fg = colors.peach,
							bg = "#000000",
							bold = true,
						},
						
						DiagnosticSignInfo = {
							fg = colors.green,
							bg = "#000000",
							bold = true,
						},
						
						DiagnosticSignHint = {
							fg = colors.sky,
							bg = "#000000",
							bold = true,
						},
					}
				end,
				integrations = {
					treesitter = true,
					treesitter_context = true,
					lsp_trouble = true,
					gitgutter = true,
					gitsigns = true,
					telescope = true,
					nvimtree = true,
					which_key = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					-- あたし、Neo-treeの統合を追加したの…テーマが正しく適用されるように（╹◡╹）
					neo_tree = true,
				},
			})
			-- あたし、テーマを強制的に適用したの…青い色が消えるように（╹◡╹）
			vim.cmd("colorscheme catppuccin")
			vim.cmd("highlight clear")
			vim.cmd("syntax reset")
			
			-- Force theme to take effect
			vim.api.nvim_exec_autocmds("ColorScheme", {})
			
			-- Set background to dark to ensure proper theme loading
			vim.opt.background = "dark"
			
			-- Force redraw
			vim.cmd("redraw!")
			
			-- あたし、診断を常に表示するようにしたの…エラーが見えるように（╹◡╹）
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})
			
			-- Ensure theme is applied on startup
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					vim.cmd("colorscheme catppuccin")
					vim.opt.background = "dark"
					
					-- あたし、診断を常に表示するようにしたの…エラーが見えるように（╹◡╹）
					vim.diagnostic.config({
						virtual_text = true,
						signs = true,
						underline = true,
						update_in_insert = true,
						severity_sort = true,
					})
				end,
				once = true,
			})
		end,
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
				strict = false,
			})
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin", -- CATPPUCCIN THEME! 💜💖💙
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					icons_enabled = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { 
						"branch", 
						"diff", 
						{
							"diff",
							symbols = {
								added = "✨ ",
								modified = "💫 ",
								removed = "💔 ",
							},
						},
						"diagnostics" 
					},
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "nvim-tree", "telescope", "toggleterm" },
				-- Clean, simple diagnostics! 💥⚡
				diagnostics = {
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					diagnostics_color = {
						error = "DiagnosticError",
						warn = "DiagnosticWarn",
						info = "DiagnosticInfo",
						hint = "DiagnosticHint",
					},
					symbols = {
						error = "💥",
						warn = "⚠️",
						info = "💡",
						hint = "💭",
					},
					colored = true,
					update_in_insert = false,
					always_visible = false,
				},
			})
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					separator_style = "slant",
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					color_icons = true,
					diagnostics = "nvim_lsp",
					-- Exclude terminal filetypes from tabs
					exclude_ft = { "terminal", "toggleterm" },
					-- Hide specific buffer names
					exclude_name = { "RightTerminal", "BottomTerminal", "Terminal" },
					-- Custom filter function to hide terminal buffers
					custom_filter = function(buf, buf_nums)
						local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")
						local file_name = vim.api.nvim_buf_get_name(buf)
						local file_type = vim.api.nvim_buf_get_option(buf, "filetype")
						
						-- Hide terminal buffers
						if buf_type == "terminal" then
							return false
						end
						
						-- Hide terminal filetypes
						if file_type == "terminal" or file_type == "toggleterm" then
							return false
						end
						
						-- Hide our custom terminal buffers
						if file_name:match("RightTerminal") or file_name:match("BottomTerminal") or file_name:match("Terminal") then
							return false
						end
						
						-- Hide any buffer with "terminal" in the name
						if file_name:match("terminal") then
							return false
						end
						
						-- Hide term:// buffers
						if file_name:match("^term://") then
							return false
						end
						
						return true
					end,
					diagnostics_indicator = function(_, _, diag)
						local ret = ""
						
						-- Clean, simple diagnostic indicators! 💥⚡
						if diag.error and diag.error > 0 then
							ret = ret .. "💥 " .. diag.error
						end
						
						if diag.warning and diag.warning > 0 then
							ret = ret .. " ⚠️ " .. diag.warning
						end
						
						if diag.info and diag.info > 0 then
							ret = ret .. " 💡 " .. diag.info
						end
						
						if diag.hint and diag.hint > 0 then
							ret = ret .. " 💭 " .. diag.hint
						end
						
						return vim.trim(ret)
					end,
					offsets = {
						{
							filetype = "NvimTree",
							text = "📁 File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					custom_areas = {
						right = function()
							local result = {}
							local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
							local warning = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
							local info = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
							local hint = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
							
							-- Clean, simple diagnostic display! 💥⚡
							if #error > 0 then
								table.insert(result, { 
									text = "💥 " .. #error, 
									guifg = "#ff0000",
									guibg = "#000000",
									gui = "bold"
								})
							end
							
							if #warning > 0 then
								table.insert(result, { 
									text = "⚠️ " .. #warning, 
									guifg = "#ff8800",
									guibg = "#000000",
									gui = "bold"
								})
							end
							
							if #info > 0 then
								table.insert(result, { 
									text = "💡 " .. #info, 
									guifg = "#00ff00",
									guibg = "#000000"
								})
							end
							
							if #hint > 0 then
								table.insert(result, { 
									text = "💭 " .. #hint, 
									guifg = "#0088ff",
									guibg = "#000000"
								})
							end
							
							return result
						end,
					},
				},
				highlights = {
					buffer_selected = {
						bold = true,
						italic = true,
					},
					buffer_visible = {
						bold = true,
					},
					-- VIOLENT ERROR HIGHLIGHTS! 🔥💀⚡
					buffer_selected_error = {
						fg = "#ff0000",
						bg = "#000000",
						sp = "#ff0000",
						bold = true,
						underline = true,
						italic = true,
					},
					buffer_selected_warning = {
						fg = "#ff8800",
						bg = "#000000",
						sp = "#ff8800",
						bold = true,
						underline = true,
						italic = true,
					},
					buffer_error = {
						fg = "#ff0000",
						bg = "#000000",
						sp = "#ff0000",
						bold = true,
						underline = true,
					},
					buffer_warning = {
						fg = "#ff8800",
						bg = "#000000",
						sp = "#ff8800",
						bold = true,
						underline = true,
					},
				},
			})
		end,
	},

	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = {
					enabled = true,
					char = "└",
					show_start = true,
					show_end = true,
				},
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"lazy",
						"mason",
					},
				},
			})
		end,
	},

	-- VIOLENT DIAGNOSTIC SIGNS! 🔥💀⚡
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				-- VIOLENT ERROR DISPLAY!
				icons = true,
				signs = {
					error = "💥💥💥",
					warning = "⚠️⚠️⚠️",
					hint = "💡",
					information = "💭",
					other = "❓",
				},
				-- Make errors absolutely TERRIFYING!
				highlight = {
					error = "DiagnosticError",
					warning = "DiagnosticWarn",
					hint = "DiagnosticHint",
					information = "DiagnosticInfo",
				},
				-- VIOLENT COLORS!
				colors = {
					error = "#ff0000",
					warning = "#ff8800",
					hint = "#00ff00",
					information = "#0088ff",
				},
			})
		end,
	},

	-- VIOLENT GUTTERSIGNS! 🔥💀⚡
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "✨" },
					change = { text = "💫" },
					delete = { text = "💔" },
					topdelete = { text = "💔" },
					changedelete = { text = "💔" },
					untracked = { text = "💭" },
				},
				-- VIOLENT GIT STATUS!
				signcolumn = true,
				numhl = true,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},

	-- File explorer with beautiful theme
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				-- あたし、Neo-treeをCatppuccinテーマで美しくしたの…青い色が嫌だったから（╹◡╹）
				window = {
					position = "left",
					width = 30,
					mappings = {
						["<space>"] = "none",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					use_libuv_file_watcher = true,
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
				},
				default_component_configs = {
					git_status = {
						symbols = {
							added = "✨",
							modified = "💫",
							deleted = "💔",
							renamed = "💕",
							untracked = "💭",
							ignored = "💤",
							unstaged = "⚡",
							staged = "💎",
							conflict = "💥",
						},
					},
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil,
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
				},
				-- Use Catppuccin theme colors
				enable_git_status = true,
				git_status_async = true,
				use_popups_for_input = false,
				popup_border_style = "rounded",
				enable_diagnostics = true,
				sort_function = nil,
				default_path = nil,
				-- Beautiful colors that match your theme
				colors = {
					git = {
						unstaged = "#ff6b6b",
						staged = "#6bcf7f",
						unmerged = "#ffa07a",
						renamed = "#a29bfe",
						untracked = "#fdcb6e",
						ignored = "#636e72",
					},
				},
			})
		end,
	},

	-- Right-click context menu for copy/paste/create/delete
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				-- あたし、Neo-treeをCatppuccinテーマで美しくしたの…青い色が嫌だったから（╹◡╹）
				window = {
					position = "left",
					width = 30,
					mappings = {
						["<space>"] = "none",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					use_libuv_file_watcher = true,
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
				},
				default_component_configs = {
					git_status = {
						symbols = {
							added = "✨",
							modified = "💫",
							deleted = "💔",
							renamed = "💕",
							untracked = "💭",
							ignored = "💤",
							unstaged = "⚡",
							staged = "💎",
							conflict = "💥",
						},
					},
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil,
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
				},
				-- Use Catppuccin theme colors
				enable_git_status = true,
				git_status_async = true,
				use_popups_for_input = false,
				popup_border_style = "rounded",
				enable_diagnostics = true,
				sort_function = nil,
				default_path = nil,
				-- Beautiful colors that match your theme
				colors = {
					git = {
						unstaged = "#ff6b6b",
						staged = "#6bcf7f",
						unmerged = "#ffa07a",
						renamed = "#a29bfe",
						untracked = "#fdcb6e",
						ignored = "#636e72",
					},
				},
			})
		end,
	},

	-- Right-click context menu for copy/paste/create/delete
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				-- あたし、Neo-treeをCatppuccinテーマで美しくしたの…青い色が嫌だったから（╹◡╹）
				window = {
					position = "left",
					width = "30",
					mappings = {
						["<space>"] = "none",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					use_libuv_file_watcher = true,
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
				},
				default_component_configs = {
					git_status = {
						symbols = {
							added = "✨",
							modified = "💫",
							deleted = "💔",
							renamed = "💕",
							untracked = "💭",
							ignored = "💤",
							unstaged = "⚡",
							staged = "💎",
							conflict = "💥",
						},
					},
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil,
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
				},
				-- Use Catppuccin theme colors
				enable_git_status = true,
				git_status_async = true,
				use_popups_for_input = false,
				popup_border_style = "rounded",
				enable_diagnostics = true,
				sort_function = nil,
				default_path = nil,
				-- Beautiful colors that match your theme
				colors = {
					git = {
						unstaged = "#ff6b6b",
						staged = "6bcf7f",
						unstaged = "#ffa07a",
						renamed = "#a29bfe",
						untracked = "#fdcb6e",
						ignored = "#636e72",
					},
				},
			})
		end,
	},


} 