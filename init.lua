
--[[
 * Main Neovim configuration entry point.
 * 
 * This file serves as the primary entry point for our Cursor CLI-centered
 * Neovim configuration. It sets up the basic environment, loads core
 * modules, and initializes the plugin management system.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: init.lua
 * Description: Main Neovim configuration entry point
--]]

-- Bootstrap Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core modules
require("core.options")      -- Basic Neovim options
require("core.keymaps")      -- Keybindings 
require("core.autocmds")     -- Autocommands

-- Initialize Lazy.nvim
require("lazy").setup("plugins")

-- Load additional modules after plugins
require("core.lsp")          -- LSP configuration
require("core.treesitter")   -- Tree-sitter setup
require("core.telescope")    -- Telescope configuration
-- Cursor CLI integration is now handled via terminal splits in keymaps

-- Load utility functions
require("utils")              -- Utility functions

-- Final setup
require("core.statusline")   -- Status line configuration
require("core.tabline")      -- Tab line configuration

-- Print startup message
vim.api.nvim_echo({{"✨ Cursor CLI Neovim loaded successfully!", "Type"}}, true, {})
