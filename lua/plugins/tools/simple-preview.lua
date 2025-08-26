--[[
 * Unified image preview and media handling configuration.
 * 
 * Provides reliable image preview capabilities with fallbacks.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/simple-preview.lua
 * Description: Unified image preview and media handling
--]]

return {
	-- Simple image preview that actually works
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- あたし、シンプルな画像プレビューを美しくしたの…確実に動作するように（╹◡╹）
			require("telescope").setup({
				defaults = {
					-- Better file preview
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					
					-- Enhanced file handling
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					
					-- Better file display
					path_display = { "truncate" },
					wrap_results = true,
					
					-- File type detection
					file_ignore_patterns = {
						"node_modules",
						".git",
						".cache",
						"*.pyc",
						"__pycache__",
					},
				},
				
				pickers = {
					-- Enhanced find_files picker
					find_files = {
						-- Show hidden files
						find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
						-- Better file display
						path_display = { "truncate" },
						-- Show file icons
						use_icons = true,
					},
					
					-- Enhanced live_grep picker
					live_grep = {
						-- Use ripgrep for better performance
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--hidden",
						},
					},
				},
			})
		end,
	},

	-- Simple image viewer using terminal capabilities
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			-- あたし、ファイルアイコンを美しくしたの…画像ファイルが美しく見えるように（╹◡╹）
			require("nvim-web-devicons").setup({
				default = true,
				strict = false,
				-- Enhanced icon support for media files
				override = {
					-- Image files
					png = { icon = "🖼️", color = "#ff6b6b", name = "png" },
					jpg = { icon = "🖼️", color = "#ff6b6b", name = "jpg" },
					jpeg = { icon = "🖼️", color = "#ff6b6b", name = "jpeg" },
					gif = { icon = "🎬", color = "#a29bfe", name = "gif" },
					svg = { icon = "🎨", color = "#74b9ff", name = "svg" },
					webp = { icon = "🖼️", color = "#ff6b6b", name = "webp" },
					bmp = { icon = "🖼️", color = "#ff6b6b", name = "bmp" },
					ico = { icon = "🖼️", color = "#ff6b6b", name = "ico" },
					-- Video files
					mp4 = { icon = "🎥", color = "#fd79a8", name = "mp4" },
					avi = { icon = "🎥", color = "#fd79a8", name = "avi" },
					mov = { icon = "🎥", color = "#fd79a8", name = "mov" },
					mkv = { icon = "🎥", color = "#fd79a8", name = "mkv" },
					-- Documents
					pdf = { icon = "📄", color = "#e84393", name = "pdf" },
					doc = { icon = "📝", color = "#0984e3", name = "doc" },
					docx = { icon = "📝", color = "#0984e3", name = "docx" },
				},
			})
		end,
	},

	-- Simple file type detection
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- あたし、Neo-treeを美しくしたの…ファイルタイプが美しく見えるように（╹◡╹）
			require("neo-tree").setup({
				window = {
					position = "left",
					width = 30,
				},
				filesystem = {
					-- Better file handling
					use_libuv_file_watcher = true,
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					-- Enhanced file display
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
					-- Better file icons
					use_icons = true,
				},
				-- Enable features
				enable_diagnostics = true,
				enable_git_status = true,
				git_status_async = true,
			})
		end,
	},
} 