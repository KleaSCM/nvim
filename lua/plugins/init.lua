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

	-- LSP plugins (Mason, language servers)
	{ import = "plugins.lsp" },

	-- Completion plugins (nvim-cmp, LuaSnip, snippets)
	{ import = "plugins.completion" },

	-- Tools plugins (git integration, utilities)
	{ import = "plugins.tools" },
	
	-- Auto formatting and bullet support
	{ import = "plugins.tools.formatting-bullets" },
	
	-- Obsidian note-taking support
	{ import = "plugins.tools.obsidian" },
	
	-- Colorizer for color codes
	{ import = "plugins.tools.colorizer" },
	
	-- Database support and SQL features
	{ import = "plugins.tools.database" },
	
	-- Utility functions are loaded in init.lua, not as plugins
} 