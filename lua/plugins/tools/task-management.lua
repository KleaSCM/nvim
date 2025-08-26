--[[
 * Task management plugins configuration.
 * 
 * Provides TODO tracking, project management, and task organization.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/task-management.lua
 * Description: Task management and project tracking plugins
--]]

return {
	-- TODO comments and task management
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- あたし、TODO管理を美しくしたの…タスクが簡単に追跡できるように（╹◡╹）
			require("todo-comments").setup({
				signs = true,
				sign_priority = 8,
				keywords = {
					FIX = {
						icon = "! ",
						color = "error",
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					},
					TODO = { icon = "T ", color = "info" },
					HACK = { icon = "H ", color = "warning" },
					WARN = { icon = "W ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = "P ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = "N ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "T ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
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
			
			-- Keybindings for TODO management
			vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "🔍 Find TODOs" })
			vim.keymap.set("n", "<leader>tl", "<cmd>TodoLocList<CR>", { desc = "📋 TODO List" })
			vim.keymap.set("n", "<leader>tq", "<cmd>TodoQuickFix<CR>", { desc = "⚡ Quick Fix" })
		end,
	},

	-- Project management and workspace
	{
		"ahmedkhalf/project.nvim",
		config = function()
			-- あたし、プロジェクト管理を美しくしたの…ワークスペースが簡単に管理できるように（╹◡╹）
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = {
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
					"go.mod",
					"Cargo.toml",
					"pyproject.toml",
					"requirements.txt",
					"setup.py",
					"CMakeLists.txt",
				},
				ignore_lsp = {},
				exclude_dirs = {
					"~/.cargo",
					"~/.config",
					"~/.local",
					"~/.cache",
					"~/.npm",
					"~/.go",
				},
				show_hidden = false,
				silent_chdir = false,
				scope_chdir = "global",
				respect_buf_cwd = false,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
			
			-- Keybindings for project management
			vim.keymap.set("n", "<leader>pp", "<cmd>ProjectRoot<CR>", { desc = "🏠 Go to Project Root" })
			vim.keymap.set("n", "<leader>pl", "<cmd>ProjectList<CR>", { desc = "📁 Project List" })
		end,
	},

	-- Advanced project navigation
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.timeout = true
			vim.timeoutlen = 300
		end,
		config = function()
			-- あたし、キーバインドを美しくしたの…すべてのコマンドが簡単に見つかるように（╹◡╹）
			local wk = require("which-key")
			wk.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
				},
				icons = {
					breadcrumb = "💜",
					separator = "💕",
					group = "✨",
				},
				window = {
					border = "rounded",
					position = "bottom",
					margin = { 1, 0, 1, 0 },
					padding = { 2, 2, 2, 2 },
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
			})
			
			-- Register keybindings
			wk.register({
				["<leader>"] = {
					t = { name = "💜 Tasks & TODOs" },
					p = { name = "🏠 Projects" },
					f = { name = "📁 Files" },
				},
			})
		end,
	},
} 