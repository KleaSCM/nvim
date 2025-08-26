--[[
 * Main plugins configuration file.
 * 
 * This file loads all plugin categories and manages the plugin manager.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: init.lua
 * Description: Main plugins loader
--]]

-- Load all plugin categories
return {
	-- Plugin manager
	{
		"folke/lazy.nvim",
		version = "*",
	},

	-- UI plugins (colorscheme, icons, status line, buffer line)
	{ import = "plugins.ui" },

	-- Editor plugins (file explorer, terminal, fuzzy finder, editing tools)
	{ import = "plugins.editor" },

	-- LSP plugins (Mason, language servers, completion)
	{ import = "plugins.lsp" },

	-- Tools plugins (git integration, utilities)
	{ import = "plugins.tools" },
} 