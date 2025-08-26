--[[
 * Advanced Git workflows with beautiful UI and cute icons.
 * 
 * Git blame in status line, interactive rebasing, beautiful diffs.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/advanced-git.lua
 * Description: Advanced Git workflows and beautiful UI
--]]

return {
	-- Advanced Git blame in status line
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		config = function()
			-- あたし、Git blameを美しくしたの…誰が書いたかが簡単に見えるように（╹◡╹）
			require("git-blame").setup({
				enabled = true,
				message_template = "💜 <author> • <date> • <summary>",
				date_format = "%Y-%m-%d %H:%M",
				highlight_group = "Comment",
				delay = 1000,
				virt_text_pos = "eol",
				relative_time = true,
			})
			
			-- Keybindings for git blame
			vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "💜 Toggle Git Blame" })
			vim.keymap.set("n", "<leader>gB", "<cmd>GitBlameOpenFileURL<CR>", { desc = "🌐 Open Git Blame URL" })
		end,
	},

	-- Interactive Git rebasing (using built-in git commands)
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- あたし、インタラクティブリベースを美しくしたの…Git履歴が簡単に管理できるように（╹◡╹）
			vim.keymap.set("n", "<leader>gr", "<cmd>Git rebase -i HEAD~5<CR>", { desc = "🌿 Interactive Rebase" })
			vim.keymap.set("n", "<leader>gR", "<cmd>Git rebase --continue<CR>", { desc = "➡️ Continue Rebase" })
			vim.keymap.set("n", "<leader>gA", "<cmd>Git rebase --abort<CR>", { desc = "⏹️ Abort Rebase" })
		end,
	},

	-- Beautiful Git diff viewer
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- あたし、Git diffを美しくしたの…変更が美しく見えるように（╹◡╹）
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				icons = {
					folder_closed = "📁",
					folder_open = "📂",
					file = "📄",
				},
				signs = {
					fold_closed = "▶",
					fold_open = "▼",
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
			})
			
			-- Keybindings for diff view
			vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "📊 Open Diff View" })
			vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "❌ Close Diff View" })
			vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "📜 File History" })
		end,
	},

	-- Git worktree management
	{
		"theprimeagen/git-worktree.nvim",
		config = function()
			-- あたし、Git worktreeを美しくしたの…ブランチが簡単に管理できるように（╹◡╹）
			require("git-worktree").setup({
				change_directory_command = "cd",
				update_on_change = true,
				update_on_change_command = "e .gitignore",
				clearjumps_on_change = true,
				autopush = false,
			})
			
			-- Keybindings for git worktree
			vim.keymap.set("n", "<leader>gw", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { desc = "🌿 Git Worktrees" })
			vim.keymap.set("n", "<leader>gW", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "➕ Create Worktree" })
		end,
	},

	-- Git conflict resolution
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			-- あたし、Git conflictを美しくしたの…コンフリクトが簡単に解決できるように（╹◡╹）
			require("git-conflict").setup({
				default_mappings = {
					ours = "<leader>go",
					theirs = "<leader>gt",
					none = "<leader>gn",
					both = "<leader>gb",
					next = "<leader>gn",
					prev = "<leader>gp",
				},
				default_commands = {
					ours = "GitConflictChooseOurs",
					theirs = "GitConflictChooseTheirs",
					none = "GitConflictChooseNone",
					both = "GitConflictChooseBoth",
					next = "GitConflictNextConflict",
					prev = "GitConflictPrevConflict",
				},
				disable_diagnostics = false,
				list_opener = "Telescope",
				default_blame_after_resolve = true,
			})
			
			-- Keybindings for git conflicts
			vim.keymap.set("n", "<leader>go", "<cmd>GitConflictChooseOurs<CR>", { desc = "💜 Choose Ours" })
			vim.keymap.set("n", "<leader>gt", "<cmd>GitConflictChooseTheirs<CR>", { desc = "💚 Choose Theirs" })
			vim.keymap.set("n", "<leader>gn", "<cmd>GitConflictChooseNone<CR>", { desc = "⚪ Choose None" })
			vim.keymap.set("n", "<leader>gb", "<cmd>GitConflictChooseBoth<CR>", { desc = "🔄 Choose Both" })
		end,
	},

	-- Git signs are already configured in tools/init.lua

	-- Git messenger for commit details
	{
		"rhysd/git-messenger.vim",
		config = function()
			-- あたし、Git messengerを美しくしたの…コミット詳細が簡単に見えるように（╹◡╹）
			vim.g.git_messenger_always_into_popup = true
			vim.g.git_messenger_floating_win_opts = {
				border = "rounded",
				width = 80,
				height = 20,
			}
			
			-- Keybinding for git messenger
			vim.keymap.set("n", "<leader>gm", "<cmd>GitMessenger<CR>", { desc = "💬 Git Message" })
		end,
	},
} 