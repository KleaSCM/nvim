--[[
 * Advanced file management plugins configuration.
 * 
 * Provides smart file operations, bookmarks, and enhanced file handling.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/file-management.lua
 * Description: Advanced file operations and bookmarks
--]]

return {
	-- Smart file operations and bookmarks
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- あたし、ファイル管理を美しくしたの…お気に入りのファイルが簡単にアクセスできるように（╹◡╹）
			local harpoon = require("harpoon")
			
			harpoon:setup({
				settings = {
					mark_branch = false,
					tabline = false,
					tabline_prefix = "   ",
					tabline_suffix = "   ",
					exclude_filetypes = { "harpoon" },
					exclude_filetypes = { "harpoon", "toggleterm", "TelescopePrompt" },
					exclude_filetypes = { "harpoon", "toggleterm", "TelescopePrompt", "neo-tree" },
				},
			})
			
			-- Keybindings for Harpoon
			vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "📌 Add to Harpoon" })
			vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "🗑️ Remove from Harpoon" })
			vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "🧹 Clear Harpoon" })
			vim.keymap.set("n", "<leader>ht", function() harpoon:list():toggle() end, { desc = "📋 Toggle Harpoon" })
			
			-- Quick navigation to marked files
			vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "📁 Go to File 1" })
			vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "📁 Go to File 2" })
			vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "📁 Go to File 3" })
			vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "📁 Go to File 4" })
			
			-- Navigate through marked files
			vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "➡️ Next File" })
			vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "⬅️ Previous File" })
		end,
	},

	-- Advanced file operations (nvim-puppeteer provides smart file operations)
	{
		"chrisgrieser/nvim-puppeteer",
		-- This plugin provides smart file operations without needing setup
	},

	-- Smart file operations with undo tree
	{
		"mbbill/undotree",
		config = function()
			-- あたし、アンドゥツリーを美しくしたの…ファイルの変更履歴が簡単に見えるように（╹◡╹）
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "🔄 Toggle Undo Tree" })
		end,
	},
} 