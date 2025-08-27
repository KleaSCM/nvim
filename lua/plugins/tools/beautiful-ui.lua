--[[
 * Beautiful UI enhancements with cute animations and magical effects.
 * 
 * Floating windows, animations, notifications, and visual enhancements.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/beautiful-ui.lua
 * Description: Beautiful UI with animations and effects
--]]

return {
	-- Beautiful floating windows and animations
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			-- あたし、UIを美しくしたの…フローティングウィンドウが魔法のように見えるように（╹◡╹）
			require("noice").setup({
				-- Beautiful cmdline
				cmdline = {
					enabled = true,
					view = "cmdline_popup",
					opts = {
						position = {
							row = "50%",
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
					-- Beautiful icons
					icons = {
						["/"] = { icon = "🔍", hl_group = "DiagnosticWarn" },
						["?"] = { icon = "💭", hl_group = "DiagnosticHint" },
						[":"] = { icon = "💜", hl_group = "DiagnosticInfo" },
					},
				},
				-- Beautiful messages
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},
				-- Beautiful popup menu
				popupmenu = {
					enabled = true,
					backend = "nui",
					kind_icons = {
						Class = "🏛️",
						Color = "🎨",
						Constant = "🔧",
						Constructor = "⚙️",
						Copilot = "🤖",
						Enum = "📋",
						EnumMember = "📝",
						Event = "📅",
						Field = "🏷️",
						File = "📁",
						Folder = "📂",
						Function = "🔮",
						Interface = "🔌",
						Keyword = "🔑",
						Method = "✨",
						Module = "📦",
						Namespace = "🌍",
						Number = "🔢",
						Operator = "⚡",
						Package = "📦",
						Property = "🏠",
						Reference = "🔗",
						Snippet = "✂️",
						String = "💬",
						Struct = "🏗️",
						Text = "📝",
						TypeParameter = "🔧",
						Unit = "📏",
						Value = "💎",
						Variable = "🔮",
					},
				},
				

				-- Beautiful notify
				notify = {
					enabled = true,
					view = "notify",
				},
				-- Beautiful lsp progress
				lsp_progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30,
					ignore = {},
				},
				-- Beautiful markdown
				markdown = {
					hover = {
						["|(\\S-)|"] = vim.cmd.help,
						["%[.-]%((%S-)%)"] = require("noice.util").open,
					},
					highlights = {
						["|%S-|"] = "@text.reference",
						["@%S+"] = "@parameter",
						["^%s*(Parameters:)"] = "@text.title",
						["^%s*(Return:)"] = "@text.title",
						["^%s*(See also:)"] = "@text.title",
						["{%S-}"] = "@parameter",
					},
				},
				-- Beautiful health
				health = {
					checker = true,
				},
				-- Beautiful smart_move
				smart_move = {
					enabled = true,
					excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
				},
				-- Beautiful presets
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				-- Beautiful throttle
				throttle = 1000 / 30,
				-- Beautiful views
				views = {
					cmdline_popup = {
						position = {
							row = "50%",
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
				},
			})
		end,
	},

	-- Beautiful notifications
	{
		"rcarriga/nvim-notify",
		config = function()
			-- あたし、通知を美しくしたの…メッセージが美しく見えるように（╹◡╹）
			require("notify").setup({
				-- Beautiful notification settings
				background_colour = "#000000",
				fps = 30,
				icons = {
					DEBUG = "🐛",
					ERROR = "💥",
					INFO = "💜",
					TRACE = "🔍",
					WARN = "⚠️",
				},
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade_in_slide_out",
				timeout = 5000,
				top_down = true,
				-- Beautiful animations
				animate = {
					enter = "slide_in",
					exit = "slide_out",
				},
			})
			
			-- Beautiful notification keybindings
			vim.keymap.set("n", "<leader>un", function()
				require("notify").dismiss({ silent = true, pending = true })
			end, { desc = "💜 Dismiss Notifications" })
			
			vim.keymap.set("n", "<leader>uh", function()
				require("notify").history()
			end, { desc = "💜 Notification History" })
		end,
	},

	-- Beautiful animations and effects
	{
		"echasnovski/mini.animate",
		version = false,
		config = function()
			-- あたし、アニメーションを美しくしたの…動きが魔法のように見えるように（╹◡╹）
			require("mini.animate").setup({
				-- Beautiful cursor animations
				cursor = {
					enable = true,
					timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
				},
				-- Beautiful scroll animations
				scroll = {
					enable = true,
					timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
				},
				-- Beautiful resize animations
				resize = {
					enable = true,
					timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
				},
				-- Beautiful open animations
				open = {
					enable = true,
					timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
				},
				-- Beautiful close animations
				close = {
					enable = true,
					timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
				},
			})
		end,
	},

	-- Beautiful floating windows
	{
		"folke/zen-mode.nvim",
		config = function()
			-- あたし、zen modeを美しくしたの…集中モードが美しく見えるように（╹◡╹）
			require("zen-mode").setup({
				window = {
					backdrop = 0.95,
					height = 0.9,
					width = 0.8,
					options = {
						signcolumn = "no",
						number = false,
						relativenumber = false,
						cursorline = false,
						cursorcolumn = false,
						foldcolumn = "0",
						list = false,
					},
				},
				plugins = {
					options = {
						enabled = true,
						rulers = { 80, 100, 120 },
						showcmd = false,
					},
					twilight = { enabled = true },
					gitsigns = { enabled = false },
					tmux = { enabled = false },
					kitty = { enabled = false },
					alacritty = { enabled = false },
				},
				-- Beautiful zen mode
				on_open = function(win)
					vim.notify("🧘 Zen mode activated! 💜", vim.log.levels.INFO)
				end,
				on_close = function()
					vim.notify("✨ Zen mode deactivated! 💜", vim.log.levels.INFO)
				end,
			})
			
			-- Beautiful zen mode keybinding
			vim.keymap.set("n", "<leader>zz", "<cmd>ZenMode<CR>", { desc = "🧘 Toggle Zen Mode" })
		end,
	},

	-- Beautiful twilight (dim inactive code)
	{
		"folke/twilight.nvim",
		config = function()
			-- あたし、twilightを美しくしたの…非アクティブなコードが美しく見えるように（╹◡╹）
			require("twilight").setup({
				dimming = {
					alpha = 0.25,
					inactive = true,
				},
				context = 10,
				treesitter = true,
				expand = {
					"function",
					"method",
					"table",
					"if_statement",
					"for_statement",
					"while_statement",
				},
				exclude = {},
			})
			
			-- Beautiful twilight keybinding
			vim.keymap.set("n", "<leader>tw", "<cmd>Twilight<CR>", { desc = "🌙 Toggle Twilight" })
		end,
	},

	-- Beautiful colorizer
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			-- あたし、colorizerを美しくしたの…色が美しく見えるように（╹◡╹）
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { css_fn = true },
					html = { names = false },
				},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = false,
					AARRGGBB = false,
					rgb_fn = false,
					hsl_fn = false,
					css = false,
					css_fn = false,
					mode = "background",
					tailwind = false,
					sass = { enable = false },
					virtualtext = "■",
					always_update = false,
				},
				buftypes = {},
			})
		end,
	},

	-- Beautiful highlight
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- あたし、todo commentsを美しくしたの…TODOが美しく見えるように（╹◡╹）
			require("todo-comments").setup({
				signs = true,
				sign_priority = 8,
				keywords = {
					FIX = {
						icon = "💥 ",
						color = "error",
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					},
					TODO = { icon = "💜 ", color = "info" },
					HACK = { icon = "💫 ", color = "warning" },
					WARN = { icon = "⚠️ ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = "⚡ ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = "💭 ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "🧪 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
				gui_style = {
					fg = "NONE",
					bg = "BOLD",
				},
				merge_keywords = true,
				highlight = {
					before = "",
					keyword = "wide",
					after = "fg",
					pattern = [[.*<(KEYWORDS)\s*:]],
					comments_only = true,
					max_line_len = 400,
					exclude = {},
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					pattern = [[\b(KEYWORDS):]],
				},
			})
		end,
	},

	-- Beautiful indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			-- あたし、indent guidesを美しくしたの…インデントが美しく見えるように（╹◡╹）
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
					highlight = "Function",
					priority = 500,
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
						"notify",
						"toggleterm",
						"lazyterm",
					},
					buftypes = {
						"terminal",
						"nofile",
					},
				},
			})
		end,
	},



} 