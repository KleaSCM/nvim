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

	-- Git staging is already configured above

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

	-- Language-specific tools and formatters (using Mason's built-in system)
	{
		"williamboman/mason.nvim",
		config = function()
			-- あたし、Masonの設定を改善したの…言語固有のツールが自動でインストールされるように（╹◡╹）
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✅",
						package_pending = "⏳",
						package_uninstalled = "❌",
					},
				},
				-- Ensure all important tools are installed
				ensure_installed = {
					-- Go tools
					"gopls",
					"gofumpt",
					"goimports",
					"gomodifytags",
					"impl",
					"fillstruct",
					"delve", -- Go debugger
					
					-- C++ tools
					"clangd",
					"clang-format",
					"cppcheck",
					"clang-tidy",
					
					-- TypeScript/JavaScript tools
					"typescript-language-server",
					"prettier",
					"eslint_d",
					
					-- General tools
					"stylua",
					"luacheck",
					"lua-language-server",
					"rust-analyzer",
					"pyright",
				},
				automatic_installation = true,
			})
		end,
	},

	-- Auto-formatting and code actions
	{
		"stevearc/conform.nvim",
		config = function()
			-- あたし、自動フォーマットを設定したの…コードが美しくなるように（╹◡╹）
			-- Only use formatters that are actually available
			local conform = require("conform")
			
			-- Function to check if a formatter is available
			local function is_formatter_available(formatter_name)
				local ok, _ = pcall(vim.fn.executable, formatter_name)
				return ok and vim.fn.executable(formatter_name) == 1
			end
			
			-- Configure formatters based on availability
			local formatters_by_ft = {
				-- Go formatting (only if tools are available)
				go = {},
				
				-- C++ formatting (only if clang-format is available)
				cpp = {},
				c = {},
				
				-- TypeScript/JavaScript formatting (only if prettier is available)
				typescript = {},
				javascript = {},
				tsx = {},
				jsx = {},
				
				-- General formatting (only if tools are available)
				lua = {},
				json = {},
				yaml = {},
				markdown = {},
				html = {},
				css = {},
			}
			
			-- Add available formatters
			if is_formatter_available("goimports") then
				table.insert(formatters_by_ft.go, "goimports")
			end
			
			if is_formatter_available("gofumpt") then
				table.insert(formatters_by_ft.go, "gofumpt")
			end
			
			if is_formatter_available("clang-format") then
				formatters_by_ft.cpp = { "clang_format" }
				formatters_by_ft.c = { "clang_format" }
			end
			
			if is_formatter_available("prettier") then
				formatters_by_ft.typescript = { "prettier" }
				formatters_by_ft.javascript = { "prettier" }
				formatters_by_ft.tsx = { "prettier" }
				formatters_by_ft.jsx = { "prettier" }
				formatters_by_ft.json = { "prettier" }
				formatters_by_ft.yaml = { "prettier" }
				formatters_by_ft.markdown = { "prettier" }
				formatters_by_ft.html = { "prettier" }
				formatters_by_ft.css = { "prettier" }
			end
			
			if is_formatter_available("stylua") then
				formatters_by_ft.lua = { "stylua" }
			end
			
			-- Set the formatters
			conform.setup({
				formatters_by_ft = formatters_by_ft,
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				notify_on_error = true,
			})
			
			-- Format keybindings
			vim.keymap.set("n", "<leader>ff", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format buffer" })
			
			vim.keymap.set("n", "<leader>fF", function()
				require("conform").format({ async = false, lsp_fallback = true })
			end, { desc = "Format buffer (sync)" })
			
			-- Notify about available formatters
			local available_count = 0
			for ft, formatters in pairs(formatters_by_ft) do
				if #formatters > 0 then
					available_count = available_count + 1
				end
			end
			
			if available_count > 0 then
				vim.notify("✨ Formatting configured for " .. available_count .. " file types", vim.log.levels.INFO)
			else
				vim.notify("💫 No formatters available - consider installing some development tools", vim.log.levels.INFO)
			end
		end,
	},

	-- Treesitter for enhanced syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- あたし、Treesitterを美しくしたの…シンタックスハイライトが最高になるように（╹◡╹）
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"cpp",
					"c",
					"typescript",
					"javascript",
					"tsx",
					"lua",
					"rust",
					"python",
					"html",
					"css",
					"json",
					"yaml",
					"markdown",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						node_decremental = "<BS>",
						scope_incremental = "<TAB>",
					},
				},
				textobjects = {
					enable = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
					},
				},
			})
		end,
	},

	-- Linting and diagnostics
	{
		"mfussenegger/nvim-lint",
		config = function()
			-- あたし、リンティングを設定したの…コードの品質が上がるように（╹◡╹）
			-- Only use linters that are actually available
			local lint = require("lint")
			
			-- Function to check if a linter is available
			local function is_linter_available(linter_name)
				local ok, _ = pcall(vim.fn.executable, linter_name)
				return ok and vim.fn.executable(linter_name) == 1
			end
			
			-- Configure linters based on availability
			local linters_by_ft = {
				-- Go linting (only if golangci-lint is available)
				go = {},
				
				-- C++ linting (only if tools are available)
				cpp = {},
				c = {},
				
				-- TypeScript/JavaScript linting (only if eslint_d is available)
				typescript = {},
				javascript = {},
				tsx = {},
				jsx = {},
				
				-- General linting (only if tools are available)
				lua = {},
				markdown = {},
			}
			
			-- Add available linters
			if is_linter_available("golangci-lint") then
				linters_by_ft.go = { "golangci-lint" }
			end
			
			if is_linter_available("cppcheck") then
				table.insert(linters_by_ft.cpp, "cppcheck")
				table.insert(linters_by_ft.c, "cppcheck")
			end
			
			if is_linter_available("clang-tidy") then
				table.insert(linters_by_ft.cpp, "clang-tidy")
				table.insert(linters_by_ft.c, "clang-tidy")
			end
			
			if is_linter_available("eslint_d") then
				linters_by_ft.typescript = { "eslint_d" }
				linters_by_ft.javascript = { "eslint_d" }
				linters_by_ft.tsx = { "eslint_d" }
				linters_by_ft.jsx = { "eslint_d" }
			end
			
			if is_linter_available("luacheck") then
				linters_by_ft.lua = { "luacheck" }
			end
			
			if is_linter_available("markdownlint") then
				linters_by_ft.markdown = { "markdownlint" }
			end
			
			-- Set the linters
			lint.linters_by_ft = linters_by_ft
			
			-- Auto-lint on save (only if linters are available)
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					-- Only lint if there are linters available for this filetype
					local ft = vim.bo.filetype
					if linters_by_ft[ft] and #linters_by_ft[ft] > 0 then
						require("lint").try_lint()
					end
				end,
			})
			
			-- InsertLeave autocmd with better error handling
			vim.api.nvim_create_autocmd("InsertLeave", {
				pattern = "*",
				callback = function()
					-- Only lint if there are linters available for this filetype
					local ft = vim.bo.filetype
					if linters_by_ft[ft] and #linters_by_ft[ft] > 0 then
						-- Use pcall to safely run linting
						local ok, _ = pcall(require("lint").try_lint)
						if not ok then
							-- If linting fails, just continue silently
							-- This prevents errors from breaking the user experience
						end
					end
				end,
			})
			
			-- Notify about available linters
			local available_count = 0
			for ft, linters in pairs(linters_by_ft) do
				if #linters > 0 then
					available_count = available_count + 1
				end
			end
			
			if available_count > 0 then
				vim.notify("✨ Linting configured for " .. available_count .. " file types", vim.log.levels.INFO)
			else
				vim.notify("💫 No linters available - consider installing some development tools", vim.log.levels.INFO)
			end
		end,
	},

	-- Debug adapter protocol for debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio", -- Required by dap-ui
		},
		config = function()
			-- あたし、デバッグツールを追加したの…Go、C++、TypeScriptのデバッグが簡単になるように（╹◡╹）
			local dap = require("dap")
			local dapui = require("dapui")
			
			-- Setup DAP UI
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.33 },
							{ id = "breakpoints", size = 0.17 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 0.33,
						position = "right",
					},
					{
						elements = {
							{ id = "repl", size = 0.45 },
							{ id = "console", size = 0.55 },
						},
						size = 0.27,
						position = "bottom",
					},
				},
			})
			
			-- Setup Go debugging
			require("dap-go").setup()
			
			-- Setup Python debugging
			require("dap-python").setup("python")
			
			-- DAP keybindings
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dc", dap.continue)
			vim.keymap.set("n", "<leader>di", dap.step_into)
			vim.keymap.set("n", "<leader>do", dap.step_over)
			vim.keymap.set("n", "<leader>du", dap.step_out)
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
			vim.keymap.set("n", "<leader>dl", dap.run_last)
			vim.keymap.set("n", "<leader>dt", dapui.toggle)
		end,
	},

	-- Import additional tool modules
	{ import = "plugins.tools.task-management" },
	{ import = "plugins.tools.file-management" },
	{ import = "plugins.tools.media-preview" },
	{ import = "plugins.tools.session-management" },
	{ import = "plugins.tools.advanced-git" },
	{ import = "plugins.tools.enhanced-lsp" },
	{ import = "plugins.tools.beautiful-ui" },
} 