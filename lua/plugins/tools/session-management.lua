--[[
 * Session and project management module.
 * 
 * Provides session persistence, project management, and dashboard configuration.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/session-management.lua
 * Description: Session and project management with beautiful dashboard
--]]

return {
	-- Session persistence
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			-- あたし、セッション管理を美しくしたの…プロジェクトが簡単に保存されるように（╹◡╹）
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
				options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
			})
		end,
	},

	-- Project management
	{
		"ahmedkhalf/project.nvim",
		config = function()
			-- あたし、プロジェクト管理を美しくしたの…プロジェクトが簡単に見つかるように（╹◡╹）
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "build.xml", "CMakeLists.txt" },
				ignore_lsp = { "efm" },
				exclude_dirs = {},
				show_hidden = false,
				silent_chdir = true,
				scope_chdir = "global",
				datapath = vim.fn.stdpath("data"),
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
						{ desc = "💾 Sessions", group = "DiagnosticHint", action = "lua require('persistence').load()", key = "s" },
						{ desc = "🏠 Projects", group = "DiagnosticHint", action = "lua require('project_nvim').list()", key = "p" },
						{ desc = "📁 Files", group = "DiagnosticHint", action = "lua require('telescope.builtin').find_files()", key = "f" },
						{ desc = "🔍 Search", group = "DiagnosticHint", action = "lua require('telescope.builtin').live_grep()", key = "g" },
						{ desc = "🌿 Git", group = "DiagnosticHint", action = "lua if vim.fn.isdirectory(vim.fn.getcwd() .. '/.git') == 1 then require('telescope.builtin').git_status() else vim.notify('Not in a git repository', vim.log.levels.INFO) end", key = "i" },
						{ desc = "⚙️ Config", group = "DiagnosticHint", action = "lua vim.cmd('edit ~/.config/nvim/init.lua')", key = "c" },
					},
					packages = { enable = true },
					footer = {
						"",
						"💕 💕",
						"<leader>dd - Return to dashboard from anywhere! 💜",
						"",
						"",
						"⠀⠀⠀⠀⠄⠠⠤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⢀⣢⣈⣉⠁⡆⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⡏⢠⣾⢷⢶⣄⣕⠢⢄⠀⠀⣀⣠⠤⠔⠒⠒⠒⠒⠒⠒⠢⠤⠄⣀⠤⢊⣤⣶⣿⡿⣿⢹⢀⡇⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⢻⠈⣿⢫⡞⠛⡟⣷⣦⡝⠋⠉⣤⣤⣶⣶⣶⣿⣿⣿⡗⢲⣴⠀⠈⠑⣿⡟⡏⠀⢱⣮⡏⢨⠃⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠸⡅⣹⣿⠀⠀⢩⡽⠋⣠⣤⣿⣿⣏⣛⡻⠿⣿⢟⣹⣴⢿⣹⣿⡟⢦⣀⠙⢷⣤⣼⣾⢁⡾⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⢻⡀⢳⣟⣶⠯⢀⡾⢍⠻⣿⣿⣽⣿⣽⡻⣧⣟⢾⣹⡯⢷⡿⠁⠀⢻⣦⡈⢿⡟⠁⡼⠁⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⢷⠠⢻⠏⢰⣯⡞⡌⣵⠣⠘⡉⢈⠓⡿⠳⣯⠋⠁⠀⠀⢳⡀⣰⣿⣿⣷⡈⢣⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⠀⠙⣎⠀⣿⣿⣷⣾⣷⣼⣵⣆⠂⡐⢀⣴⣌⠀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣷⣀⠣⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⠀⠄⠑⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⣿⢽⣧⡤⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⠀⢸⣈⢹⣟⣿⣿⣿⣿⣿⣻⢹⣿⣻⢿⣿⢿⣽⣳⣯⣿⢷⣿⡷⣟⣯⣻⣽⠧⠾⢤⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⠀⢇⠤⢾⣟⡾⣽⣿⣽⣻⡗⢹⡿⢿⣻⠸⢿⢯⡟⡿⡽⣻⣯⣿⣎⢷⣣⡿⢾⢕⣎⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⡠⡞⡟⣻⣮⣍⡛⢿⣽⣻⡀⠁⣟⣣⠿⡠⣿⢏⡞⠧⠽⢵⣳⣿⣺⣿⢿⡋⠙⡀⠇⠱⡀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⢰⠠⠁⠀⢻⡿⣛⣽⣿⢟⡁⣭⣥⣅⠀⠀⠀⠀⠀⠀⣶⣟⣧⠿⢿⣿⣯⣿⡇⠀⡇⠀⢀⡇⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⢸⠀⠀⡇⢹⣾⣿⣿⣷⡿⢿⢷⡏⡈⠀⠀⠀⠀⠀⠀⠈⡹⡷⡎⢸⣿⣿⣿⡇⠀⡇⠀⠸⡇⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⢸⡄⠂⠖⢸⣿⣿⣿⡏⢃⠘⡊⠩⠁⠀⠀⠀⠀⠀⠀⠀⠁⠀⠁⢹⣿⣿⣿⡇⢰⢁⡌⢀⠇⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⢷⡘⠜⣤⣿⣿⣿⣷⡅⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣧⣕⣼⣠⡵⠋⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⣸⣻⣿⣾⣿⣿⣿⣿⣾⡄⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⢀⠀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⠀⡇⣿⣻⣿⣿⣿⣿⣿⣿⣿⣦⣤⣀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣳⣿⡸⡀⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⠀⣸⢡⣿⢿⣿⣿⣿⣿⣿⣿⣿⢿⣿⡟⣽⠉⠀⠒⠂⠉⣯⢹⣿⡿⣿⣿⣿⣿⣿⣯⣿⡇⠇⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⠀⢰⡏⣼⡿⣿⣻⣿⣿⣿⣿⣿⢿⣻⡿⠁⠘⡆⠀⠀⠀⢠⠇⠘⣿⣿⣽⣿⣿⣿⣿⣯⣿⣷⣸⠀⠀⠀⠀⠀⠀⠀",
						"⠀⠀⢀⡟⢰⣾⢿⣿⣟⣿⣿⣿⣿⣿⡟⣿⣧⠀⠀⠈⠣⡄⡰⠋⠀⢀⢾⣿⡛⣿⣿⣿⣿⣿⣿⣿⣷⡆⠀⠀⠀⠀⠀⠀",
						"⠀⠀⢸⢁⢦⣿⣻⣿⢿⣻⡽⣾⢿⡿⢷⣽⣻⠃⠂⠴⣎⠘⠦⡸⠠⠄⢻⣟⣿⠻⣿⣻⢷⣯⢿⣿⣽⣷⡀⠀⠀⠀⠀⠀",
						"⠀⠀⡇⠎⣼⡷⣿⣟⣿⣯⢿⣽⣞⡇⣸⣷⡇⠰⠗⠐⣺⣀⣼⠒⠒⠦⠰⣿⣯⠇⢳⣯⣿⣞⣿⢾⣿⢿⢳⡄⠀⠀⠀⠀",
						"⠀⢸⡿⢠⣿⣻⣿⢿⣼⣿⣿⣿⣼⣄⡻⢼⣧⠀⣀⣼⠟⣻⡟⢧⣤⣄⢠⣿⡃⢼⣿⢧⣿⣿⡿⣟⣿⣿⡄⢻⡀⠀⠀⠀",
						"⠀⣼⠀⣾⡷⣿⣿⣿⢾⣿⣿⢾⠗⣛⡥⣾⠟⣞⠉⢀⣠⠙⢰⣀⡈⢙⡟⣿⣽⣲⢭⢛⣿⣿⣻⣽⣾⣷⣷⡀⠱⡀⠀⠀",
						"⢠⢛⣰⣿⣟⣿⣿⣿⣿⣿⢯⣿⣧⢹⣽⣻⢾⣮⣷⣠⠗⢪⠐⢧⣼⣷⣶⣾⢷⣯⠏⣼⣿⣻⣯⣿⣿⣿⣯⣷⡄⢣⠀⠀",
						"⡌⡆⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣦⡹⣿⣟⣾⣳⣿⣧⣼⣴⣝⣛⢾⣷⣯⣿⢊⣼⣿⣿⣿⣿⣿⣿⣿⣿⡿⣷⠈⡇⠀",
						"⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣍⡻⣿⣿⣿⣿⡄⣷⣯⣟⣿⡿⢟⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠐⠀",
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
		},
		config = function()
			-- あたし、セッション検索を美しくしたの…古いセッションが簡単に見つかるように（╹◡╹）
			
			-- Keybindings for session management
			vim.keymap.set("n", "<leader>fs", "<cmd>lua require('persistence').load()<CR>", { desc = "🔍 Load Session" })
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