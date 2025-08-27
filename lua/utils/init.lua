--[[
 * Utils initialization module.
 * 
 * Loads all utility functions and makes them available globally.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/init.lua
 * Description: Main utils loader
--]]

-- Load all utility modules
require("utils.file")
require("utils.git")
require("utils.lsp")
require("utils.ui")
require("utils.general")

-- あたし、ユーティリティを美しくしたの…Neovimが美しく動作するように（╹◡╹）
vim.api.nvim_create_user_command("Utils", function()
	vim.notify("✨ Utils loaded successfully!", vim.log.levels.INFO)
end, {}) 