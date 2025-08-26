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
	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
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
				linehl = false,
				word_diff = false,
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
				current_line_blame_formatter = "💕 <author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
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

	-- Plenary (required by many plugins)
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},

	-- Git blame
	{
		"f-person/git-blame.nvim",
		config = function()
			require("gitblame").setup({
				enabled = false,
				message_template = "💕 <author> • <date> • <summary>",
				date_format = "%Y-%m-%d %H:%M",
				highlight_group = "Comment",
			})
		end,
	},

	-- Git diff view
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("diffview").setup({
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
			})
		end,
	},
} 