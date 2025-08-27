--[[
 * Database support module.
 * 
 * Provides database connectivity and SQL support.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/database.lua
 * Description: Database support and SQL features
--]]

return {
	-- Database client for Neovim
	{
		"tpope/vim-dadbod",
		cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			-- あたし、データベースを美しくしたの…データベースが美しく操作されるように（╹◡╹）
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_winwidth = 30
			vim.g.db_ui_winposition = "right"
			vim.g.db_ui_show_help = 1
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_icons = {
				expanded = "▾",
				collapsed = "▸",
				saved_query = "💾",
				new_query = "⭐",
				tables = "📊",
				table = "📋",
				foreign_keys = "🔗",
				indexes = "📈",
				index = "🔍",
				triggers = "⚡",
				trigger = "🎯",
				views = "👁️",
				view = "👀",
				procedures = "⚙️",
				procedure = "🔧",
				functions = "🔮",
				["function"] = "✨",
				connections = "🔌",
				connection = "💡",
			}
			vim.g.db_ui_table_helpers = {
				sqlite = {
					Count = "SELECT COUNT(*) FROM {table}",
					Explain = "EXPLAIN QUERY PLAN {last_query}",
					Indexes = "PRAGMA INDEX_LIST({table})",
					Show = "SELECT * FROM {table} LIMIT 200",
				},
				mysql = {
					Count = "SELECT COUNT(*) FROM {table}",
					Explain = "EXPLAIN {last_query}",
					Indexes = "SHOW INDEX FROM {table}",
					Show = "SELECT * FROM {table} LIMIT 200",
				},
				postgresql = {
					Count = "SELECT COUNT(*) FROM {table}",
					Explain = "EXPLAIN {last_query}",
					Indexes = "SELECT indexname, indexdef FROM pg_indexes WHERE tablename = '{table}'",
					Show = "SELECT * FROM {table} LIMIT 200",
				},
			}
			vim.g.db_ui_auto_execute_table_helpers = 1
		end,
	},

	-- SQL syntax highlighting
	{
		"nanotee/sqls.nvim",
		ft = "sql",
		config = function()
			-- あたし、SQLを美しくしたの…SQLが美しく表示されるように（╹◡╹）
			require("sqls").setup({
				connections = {
					{
						name = "SQLite",
						adapter = "sqlite",
						host = "localhost",
						port = 5432,
						database = "test.db",
						username = "",
						password = "",
					},
					{
						name = "PostgreSQL",
						adapter = "postgresql",
						host = "localhost",
						port = 5432,
						database = "postgres",
						username = "postgres",
						password = "",
					},
					{
						name = "MySQL",
						adapter = "mysql",
						host = "localhost",
						port = 3306,
						database = "test",
						username = "root",
						password = "",
					},
				},
			})
		end,
	},

	-- Database completion
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql" },
		config = function()
			-- あたし、データベース補完を美しくしたの…補完が美しく動作するように（╹◡╹）
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
					"mysql",
					"plsql",
				},
				callback = function()
					require("cmp").setup.buffer({
						sources = { { name = "vim-dadbod-completion" } },
					})
				end,
			})
		end,
	},

	-- SQL formatting
	{
		"b4winckler/vim-angry",
		ft = "sql",
		config = function()
			-- あたし、SQLフォーマットを美しくしたの…SQLが美しく整列されるように（╹◡╹）
			vim.g.angry_use_default_mappings = 0
			vim.api.nvim_set_keymap("n", "<leader>sf", ":Angry<CR>", { noremap = true, silent = true, desc = "✨ Format SQL" })
			vim.api.nvim_set_keymap("v", "<leader>sf", ":Angry<CR>", { noremap = true, silent = true, desc = "✨ Format SQL" })
		end,
	},
} 