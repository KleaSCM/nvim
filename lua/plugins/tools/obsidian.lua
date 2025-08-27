--[[
 * Obsidian support module.
 * 
 * Provides Obsidian note-taking features and markdown enhancements.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/obsidian.lua
 * Description: Obsidian note-taking support
--]]

return {
	-- Obsidian.nvim - Full Obsidian support
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			-- あたし、Obsidianを美しくしたの…ノートが美しく管理されるように（╹◡╹）
			local vault_path = "~/Documents/Work"
			
			-- Check if the actual Obsidian vault exists
			local vault_full_path = vim.fn.expand(vault_path)
			
			if vim.fn.isdirectory(vault_full_path) == 1 then
				-- Found your actual Obsidian vault!
				vim.notify("🎉 Found your Obsidian vault at " .. vault_path, vim.log.levels.INFO)
			else
				-- Vault doesn't exist, create a local notes directory
				vault_path = "~/notes"
				local notes_path = vim.fn.expand(vault_path)
				if vim.fn.isdirectory(notes_path) == 0 then
					vim.fn.mkdir(notes_path, "p")
				end
				
				-- Create workspace subdirectories
				local workspaces = { "personal", "work", "projects" }
				for _, workspace in ipairs(workspaces) do
					local workspace_path = notes_path .. "/" .. workspace
					if vim.fn.isdirectory(workspace_path) == 0 then
						vim.fn.mkdir(workspace_path, "p")
					end
				end
				
				vim.notify("📝 Created local notes directory with workspaces at " .. notes_path, vim.log.levels.INFO)
			end
			
			return {
				dir = vault_path,
				notes_subdir = "notes",
				daily_notes = {
					folder = "daily",
					date_format = "%Y-%m-%d",
					alias_format = "%B %-d, %Y",
					template = nil,
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
					completion_func = nil,
				},
				new_notes_location = "current_dir",
				mappings = {
					["<leader>on"] = { action = ":ObsidianNew", desc = "📝 New Note" },
					["<leader>oo"] = { action = ":ObsidianOpen", desc = "📖 Open Note" },
					["<leader>os"] = { action = ":ObsidianSearch", desc = "🔍 Search Notes" },
					["<leader>ot"] = { action = ":ObsidianTemplate", desc = "📋 Insert Template" },
					["<leader>ol"] = { action = ":ObsidianLink", desc = "🔗 Link Note" },
					["<leader>ob"] = { action = ":ObsidianBacklinks", desc = "↩️ Show Backlinks" },
					["<leader>of"] = { action = ":ObsidianFollowLink", desc = "➡️ Follow Link" },
				},
				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,
				note_path_func = function(spec)
					local path = spec.dir / spec.subdir
					return path:expand()
				end,
				-- Use your actual vault structure instead of artificial workspaces
				workspaces = {
					{
						name = "main",
						path = vault_path,
					},
				},
				templates = {
					subdir = "templates",
					date_format = "%Y-%m-%d-%H%M",
					time_format = "%H:%M",
					substitutions = {},
				},
				callbacks = {},
				log_level = vim.log.levels.INFO,
				disable_frontmatter = false,
				note_frontmatter_func = function(note)
					if note.crumbs and #note.crumbs > 0 then
						local breadcrumbs = {}
						for _, crumb in ipairs(note.crumbs) do
							table.insert(breadcrumbs, crumb.text)
						end
						note.frontmatter.breadcrumbs = breadcrumbs
					end
				end,
				ui = {
					enable = true,
					update_debounce = 200,
					checkboxes = {
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "󰆧", hl_group = "ObsidianDone" },
						[">"] = { char = "󰐷", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "󰘧", hl_group = "ObsidianTilde" },
					},
					external_link_icon = { char = "󰉹", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					block_ids = { hl_group = "ObsidianBlockID" },
					highlights = { hl_group = "ObsidianHighlight" },
					callouts = { hl_group = "ObsidianCallout" },
					image_filters = {},
					use_daily_notes = false,
					main_window = {
						anchor = "center",
						width = 0.6,
						height = 0.8,
						row = 0.1,
						col = 0.2,
						border = "rounded",
						relative = "editor",
						z_index = 1,
					},
					popup_mappings = {
						scroll = "<c-u>",
						scroll_up = "<c-b>",
					},
					code_blocks = {
						hl_group = "ObsidianCodeBlock",
					},
				},
			}
		end,
	},

	-- Markdown preview with glow
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		keys = {
			{ "<leader>mp", "<cmd>Glow<CR>", desc = "📖 Markdown Preview" },
		},
		config = function()
			-- あたし、Markdownプレビューを美しくしたの…ノートが美しく表示されるように（╹◡╹）
			require("glow").setup({
				style = "dark",
				width = 120,
				height = 100,
				width_ratio = 0.7,
				height_ratio = 0.7,
			})
		end,
	},

	-- Markdown enhancements
	{
		"preservim/vim-markdown",
		ft = "markdown",
		config = function()
			-- あたし、Markdownを美しくしたの…ノートが美しく編集されるように（╹◡╹）
			vim.g.markdown_fenced_languages = {
				"html",
				"python",
				"bash=sh",
				"rust",
				"go",
				"javascript",
				"typescript",
				"lua",
				"vim",
			}
			vim.g.markdown_syntax_conceal = 1
			vim.g.markdown_folding = 1
			vim.g.markdown_no_default_key_mappings = 1
		end,
	},

	-- Table mode for markdown
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "text" },
		config = function()
			-- あたし、テーブルモードを美しくしたの…テーブルが美しく編集されるように（╹◡╹）
			vim.g.table_mode_corner = "|"
			vim.g.table_mode_header_fillchar = "="
			vim.g.table_mode_align_char = ":"
			vim.g.table_mode_delimiter = "|"
			vim.g.table_mode_corner_corner = "|"
			vim.g.table_mode_header_fillchar = "="
		end,
	},

	-- Markdown links and references
	{
		"mzlogin/vim-markdown-toc",
		ft = "markdown",
		config = function()
			-- あたし、目次を美しくしたの…目次が美しく生成されるように（╹◡╹）
			vim.g.vmt_auto_update_on_save = 1
			vim.g.vmt_dont_insert_fence = 1
			vim.g.vmt_fence_text = "TOC"
			vim.g.vmt_fence_on_empty_line = 0
			vim.g.vmt_cycle_list_item_markers = 1
			vim.g.vmt_include_headings_before = 1
			vim.g.vmt_auto_update_on_save = 1
		end,
	},
} 