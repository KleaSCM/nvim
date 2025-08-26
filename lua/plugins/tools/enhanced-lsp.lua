--[[
 * Enhanced LSP system with magical code intelligence.
 * 
 * Beautiful floating windows, inlay hints, advanced code actions.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/enhanced-lsp.lua
 * Description: Enhanced LSP with magical features
--]]

return {
	-- Beautiful LSP floating windows and UI
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- あたし、LSPを美しくしたの…コードインテリジェンスが魔法のように見えるように（╹◡╹）
			require("lspsaga").setup({
				-- Beautiful floating windows
				ui = {
					border = "rounded",
					title = true,
					expand = "▶",
					collapse = "▼",
					code_action = "💡",
					actionfix = "💫",
					lines = { "└", "├", "│", "─" },
				},
				-- Enhanced code actions
				code_action = {
					num_shortcut = true,
					show_server_name = true,
					extend_gitsigns = true,
					keys = {
						quit = "q",
						exec = "<CR>",
					},
				},
				-- Beautiful lightbulb
				lightbulb = {
					enable = true,
					sign = true,
					sign_priority = 40,
					virtual_text = true,
				},
				-- Enhanced symbol information
				symbol_in_winbar = {
					enable = true,
					separator = " 󰁔 ",
					hide_keyword = true,
					show_file = true,
					folder_level = 2,
					respect_root = false,
					color_mode = true,
				},
				-- Beautiful outline
				outline = {
					win_position = "right",
					win_with = "",
					win_width = 30,
					show_detail = true,
					auto_preview = true,
					auto_refresh = true,
					auto_close = true,
					keys = {
						jump = "o",
						expand_collapse = "u",
						quit = "q",
					},
				},
				-- Enhanced call hierarchy
				callhierarchy = {
					show_detail = false,
					keys = {
						edit = "e",
						vsplit = "s",
						split = "i",
						tclose = "q",
						quit = "q",
					},
				},
				-- Beautiful finder
				finder = {
					max_height = 0.5,
					left_width = 0.3,
					default = "ref+imp",
					methods = {
						finder = "sp_outer",
						tyd = "sp_inner",
						def = "sp_def",
						decl = "sp_decl",
						imp = "sp_imp",
						ref = "sp_ref",
					},
					icons = {
						def = "󰡕",
						ref = "󰡕",
						link = "󰡕",
					},
					show_reference = true,
					show_definition = true,
					show_implementation = true,
					show_declaration = true,
					show_type_definition = true,
				},
				-- Enhanced rename
				rename = {
					in_select = true,
					auto_save = false,
					project_max_width = 0.5,
					project_max_height = 0.5,
					keys = {
						quit = "<C-c>",
						exec = "<CR>",
						select = "x",
					},
				},
				-- Beautiful diagnostic
				diagnostic = {
					show_code_action = true,
					show_source = true,
					jump_num_shortcut = true,
					max_show_width = 0.6,
					max_show_height = 0.6,
					text_hl_follow = true,
					border_follow = true,
					wrap_long_lines = true,
					show_sign = true,
					sign_priority = 5,
					icons = {
						error = "💥",
						warn = "⚠️",
						hint = "💡",
						info = "💭",
					},
				},
				-- Enhanced hover
				hover = {
					max_width = 0.6,
					max_height = 0.6,
					open_link = "gx",
					open_browser = "!open",
				},
				-- Beautiful scrollbar
				scrollbar = {
					scrollbar_float = true,
					scrollbar_thickness = 6,
					scrollbar_type = "vertical",
					scrollbar_hl_group = "Pmenu",
					scrollbar_float_hl_group = "PmenuThumb",
				},
				-- Enhanced implement
				implement = {
					enable = true,
					icon = "󰡕",
				},
				-- Beautiful beacon
				beacon = {
					enable = true,
					frequency = 7,
				},
			})
			
			-- Beautiful keybindings for LSP Saga
			vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { desc = "🔍 LSP Finder" })
			vim.keymap.set("n", "gR", "<cmd>Lspsaga rename<CR>", { desc = "🔄 Rename" })
			vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { desc = "👀 Peek Definition" })
			vim.keymap.set("n", "gI", "<cmd>Lspsaga implement<CR>", { desc = "💡 Implement" })
			vim.keymap.set("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "👀 Peek Type" })
			vim.keymap.set("n", "gC", "<cmd>Lspsaga incoming_calls<CR>", { desc = "📞 Incoming Calls" })
			vim.keymap.set("n", "gO", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "📞 Outgoing Calls" })
			vim.keymap.set("n", "gS", "<cmd>Lspsaga outline<CR>", { desc = "📋 Outline" })
			vim.keymap.set("n", "gH", "<cmd>Lspsaga hover_doc<CR>", { desc = "💭 Hover Doc" })
			vim.keymap.set("n", "gA", "<cmd>Lspsaga code_action<CR>", { desc = "💡 Code Action" })
			vim.keymap.set("n", "gL", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "💥 Line Diagnostics" })
			vim.keymap.set("n", "gB", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "💥 Buffer Diagnostics" })
			vim.keymap.set("n", "gW", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "💥 Workspace Diagnostics" })
		end,
	},

	-- Beautiful LSP signature help
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			-- あたし、LSP signatureを美しくしたの…関数の引数が美しく見えるように（╹◡╹）
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
				hint_enable = true,
				hint_prefix = "💡 ",
				hint_scheme = "String",
				hi_parameter = "Search",
				max_height = 12,
				max_width = 120,
				name_prefix = "parameter",
				offse = 50,
				padding = " ",
				shadow_blend = 36,
				shadow_guibg = "Black",
				show_linelength = true,
				shrink_margin = false,
				silent = false,
				timer_interval = 200,
				toggle_key = "<C-k>",
				transparency = nil,
				trusted = nil,
				width = 120,
				wrap = true,
			})
		end,
	},

	-- Enhanced LSP progress
	{
		"j-hui/fidget.nvim",
		config = function()
			-- あたし、LSP progressを美しくしたの…進行状況が美しく見えるように（╹◡╹）
			require("fidget").setup({
				text = {
					spinner = "dots",
					done = "✨",
					commenced = "💫",
					completed = "💜",
				},
				align = {
					bottom = true,
					right = true,
				},
				timer = {
					spinner_rate = 125,
					fidget_decay = 2000,
					notification_decay = 5000,
				},
				window = {
					relative = "win",
					blend = 100,
					zindex = nil,
				},
				fmt = {
					leftpad = true,
					stack_upwards = true,
					max_width = 0,
					fidget = function(fidget_name, spinner)
						return string.format("%s %s", spinner, fidget_name)
					end,
					task = function(task_name, message, percentage)
						return string.format("%s %s %s", task_name, message, percentage)
					end,
				},
			})
		end,
	},

	-- Beautiful LSP hover
	{
		"folke/lsp-colors.nvim",
		config = function()
			-- あたし、LSP colorsを美しくしたの…診断が美しく見えるように（╹◡╹）
			require("lsp-colors").setup({
				Error = "#ff6b6b",
				Warning = "#ffa07a",
				Information = "#6bcf7f",
				Hint = "#74b9ff",
			})
		end,
	},

	-- Enhanced LSP keybindings
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- あたし、LSP keybindingsを美しくしたの…コードインテリジェンスが簡単に使えるように（╹◡╹）
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					
					-- Enhanced LSP keybindings
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					
					-- Enhanced diagnostic navigation
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
					
					-- Beautiful LSP info
					vim.keymap.set("n", "<space>i", function()
						vim.notify("💜 LSP: " .. client.name, vim.log.levels.INFO)
					end, opts)
				end,
			})
		end,
	},
} 