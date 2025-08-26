--[[
 * Dashboard configuration module.
 * 
 * Provides a beautiful startup screen with main keybindings
 * and a placeholder for the cute ASCII girl.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
--]]

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = "󰙴 Files", group = "DiagnosticHint", action = "Telescope find_files", key = "f" },
					{ desc = "󰈚 Recent", group = "DiagnosticHint", action = "Telescope oldfiles", key = "r" },
					{ desc = "󰋚 Search", group = "DiagnosticHint", action = "Telescope live_grep", key = "s" },
					{ desc = "󰊄 Git", group = "DiagnosticHint", action = "Telescope git_status", key = "g" },
					{ desc = "🪟 Layout", group = "DiagnosticHint", action = function() vim.cmd("lua require('core.keymaps').set_perfect_layout()") end, key = "l" },
					{ desc = "💻 Right Terminal", group = "DiagnosticHint", action = function() vim.cmd("lua require('core.keymaps').create_right_terminal()") end, key = "t" },
					{ desc = "🖥️ Bottom Terminal", group = "DiagnosticHint", action = function() vim.cmd("lua require('core.keymaps').create_bottom_terminal()") end, key = "b" },
					{ desc = "📁 Explorer", group = "DiagnosticHint", action = function() vim.cmd("NvimTreeToggle") end, key = "e" },
				},
				project = { enable = false },
				footer = {
					"PLACEHOLDER",
					"",
					"💕"
				}
			}
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" }
} 