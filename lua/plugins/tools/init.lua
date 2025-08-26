--[[
 * Tools plugins configuration.
 * 
 * This file contains utility and tool plugins including git integration.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/init.lua
 * Description: Tools and utilities configuration
--]]

return {
	-- Git integration with enhanced features (enhanced version)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				-- あたし、Gitの設定を改善したの…コミット情報が見えるように（╹◡╹）
				signs = {
					add = { text = "✨", hl = "GitSignsAdd" },
					change = { text = "💫", hl = "GitSignsChange" },
					delete = { text = "💔", hl = "GitSignsDelete" },
					topdelete = { text = "💔", hl = "GitSignsDelete" },
					changedelete = { text = "💫", hl = "GitSignsChange" },
					untracked = { text = "💭", hl = "GitSignsAdd" },
				},
				signcolumn = true,
				numhl = true,
				linehl = true,
				word_diff = true,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "💕 <author> • <author_time:%Y-%m-%d %H:%M> • <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = function(status)
					-- Show git status with emojis
					local added = status.added and ("✨ " .. status.added) or ""
					local changed = status.changed and ("💫 " .. status.changed) or ""
					local removed = status.removed and ("💔 " .. status.removed) or ""
					return string.format("%s %s %s", added, changed, removed)
				end,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				-- Enhanced git features
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end
					
					-- Git navigation
					map("n", "]c", function()
						if vim.wo.diff then return "]c" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, { expr = true })
					
					map("n", "[c", function()
						if vim.wo.diff then return "[c" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, { expr = true })
					
					-- Git actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function() gs.blame_line{full=true} end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function() gs.diffthis("~") end)
				end,
			})
		end,
	},

	-- Plenary (required by many plugins)
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	-- Git blame with enhanced information
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				-- あたし、Git blameを有効にしたの…コミット情報が見えるように（╹◡╹）
				enabled = true,
				message_template = "💕 <author> • <date> • <summary>",
				date_format = "%Y-%m-%d %H:%M",
				highlight_group = "Comment",
				delay = 1000,
				virt_text_pos = "eol",
				show_committer_time = true,
				show_committer_time_relative = true,
			})
		end,
	},

	-- Enhanced Git diff view with advanced features
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("diffview").setup({
				-- あたし、Git diffを美しくしたの…ファイル比較が見やすくなるように（╹◡╹）
				enhanced_diff_hl = true,
				use_icons = true,
				icons = {
					folder_closed = "📁",
					folder_open = "📂",
				},
				signs = {
					fold_closed = "📁",
					fold_open = "📂",
				},
				file_panel = {
					win_config = {
						width = 35,
					},
				},
				file_history_panel = {
					win_config = {
						width = 35,
					},
				},
				-- Enhanced diff features
				diff_binaries = false,
				enhanced_diff_hl = true,
				git_cmd = { "git" },
				use_icons = true,
				watch_index = true,
				icons = {
					folder_closed = "📁",
					folder_open = "📂",
				},
				signs = {
					fold_closed = "📁",
					fold_open = "📂",
				},
			})
		end,
	},

	-- Git status and information
	{
		"rhysd/git-messenger.vim",
		config = function()
			-- あたし、Gitメッセージプラグインを追加したの…コミット情報が見えるように（╹◡╹）
			vim.g.git_messenger_always_into_popup = true
			vim.g.git_messenger_floating_win_opts = {
				border = "rounded",
				width = 80,
				height = 20,
			}
		end,
	},

	-- Git worktree management
	{
		"theprimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup({
				change_directory_command = "cd",
				update_on_change = true,
				update_on_change_command = "e .",
				clearjumps_on_change = true,
				autopush = false,
			})
		end,
	},

	-- Interactive Git staging (git add/remove interface)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				-- あたし、Git stagingを美しくしたの…ファイルの追加・削除が見やすくなるように（╹◡╹）
				signs = {
					add = { text = "✨", hl = "GitSignsAdd" },
					change = { text = "💫", hl = "GitSignsChange" },
					delete = { text = "💔", hl = "GitSignsDelete" },
					topdelete = { text = "💔", hl = "GitSignsDelete" },
					changedelete = { text = "💫", hl = "GitSignsChange" },
					untracked = { text = "💭", hl = "GitSignsAdd" },
				},
				signcolumn = true,
				numhl = true,
				linehl = true,
				word_diff = true,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "💕 <author> • <author_time:%Y-%m-%d %H:%M> • <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = function(status)
					-- Show git status with emojis
					local added = status.added and ("✨ " .. status.added) or ""
					local changed = status.changed and ("💫 " .. status.changed) or ""
					local removed = status.removed and ("💔 " .. status.removed) or ""
					return string.format("%s %s %s", added, changed, removed)
				end,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				-- Enhanced git features
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end
					
					-- Git navigation
					map("n", "]c", function()
						if vim.wo.diff then return "]c" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, { expr = true })
					
					map("n", "[c", function()
						if vim.wo.diff then return "[c" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, { expr = true })
					
					-- Git actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function() gs.blame_line{full=true} end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function() gs.diffthis("~") end)
				end,
			})
		end,
	},

	-- Git conflict resolution and advanced features
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				-- あたし、Git conflictを美しくしたの…マージコンフリクトが解決しやすくなるように（╹◡╹）
				default_mappings = {
					ours = "o",
					theirs = "t",
					none = "0",
					both = "b",
					next = "n",
					prev = "p",
				},
				disable_diagnostics = false,
				list_opener = "copen",
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})
		end,
	},

	-- Git status and branch management
	{
		"tpope/vim-fugitive",
		config = function()
			-- あたし、Git fugitiveを美しくしたの…Git操作が簡単になるように（╹◡╹）
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
			vim.keymap.set("n", "<leader>gl", ":Git pull<CR>")
			vim.keymap.set("n", "<leader>gb", ":Git branch<CR>")
			vim.keymap.set("n", "<leader>gco", ":Git checkout<CR>")
		end,
	},
} 