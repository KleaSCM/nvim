--[[
 * Session management and project memory system.
 * 
 * Remembers your workspace, tabs, splits, and files.
 * Never lose your work again!
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/session-management.lua
 * Description: Session management and project memory
--]]

return {
	-- Session management - Remember everything!
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			-- あたし、セッション管理を美しくしたの…何も失わないように（╹◡╹）
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
			options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
		},
		keys = {
			-- Save and restore sessions
			{ "<leader>qs", function() require("persistence").load() end, desc = "💾 Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "🔄 Restore Last Session" },
			{ "<leader>qd", function() require("persistence").stop() end, desc = "⏹️ Don't Save Session" },
		},
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
					"README.md",
					"LICENSE",
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
			vim.keymap.set("n", "<leader>pc", "<cmd>ProjectClose<CR>", { desc = "🚪 Close Project" })
		end,
	},

	-- Beautiful project dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			-- あたし、ダッシュボードを美しくしたの…プロジェクトが簡単に見えるように（╹◡╹）
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = "💾 Sessions", group = "DiagnosticHint", action = "SessionLoad", key = "s" },
						{ desc = "🏠 Projects", group = "DiagnosticHint", action = "ProjectList", key = "p" },
						{ desc = "📁 Files", group = "DiagnosticHint", action = "Telescope find_files", key = "f" },
						{ desc = "🔍 Search", group = "DiagnosticHint", action = "Telescope live_grep", key = "g" },
						{ desc = "🌿 Git", group = "DiagnosticHint", action = "Telescope git_status", key = "i" },
						{ desc = "⚙️ Config", group = "DiagnosticHint", action = "edit ~/.config/nvim/init.lua", key = "c" },
					},
					packages = { enable = true },
					footer = {
						"",
						"💕 Your magical Neovim is ready! 💕",
						"",
					},
				},
			})
		end,
	},

	-- Session and project integration
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/persistence.nvim",
		},
		config = function()
			-- あたし、セッション検索を美しくしたの…古いセッションが簡単に見つかるように（╹◡╹）
			require("telescope").load_extension("persistence")
			
			-- Keybindings for session management
			vim.keymap.set("n", "<leader>fs", "<cmd>Telescope persistence list<CR>", { desc = "🔍 Find Sessions" })
			vim.keymap.set("n", "<leader>fp", "<cmd>Telescope project<CR>", { desc = "🔍 Find Projects" })
		end,
	},

	-- Auto-save sessions
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- あたし、自動セーブを美しくしたの…セッションが自動的に保存されるように（╹◡╹）
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					-- Auto-save session when leaving
					local ok, _ = pcall(require("persistence").save)
					if ok then
						vim.notify("💾 Session saved automatically!", vim.log.levels.INFO)
					end
				end,
			})
			
			-- Auto-save session periodically
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					-- Save session every 5 minutes of inactivity
					local ok, _ = pcall(require("persistence").save)
					if ok then
						-- Silent save - don't notify every time
					end
				end,
			})
		end,
	},
} 