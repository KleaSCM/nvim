--[[
 * LSP core configuration.
 * 
 * This module provides core LSP functionality and status checking.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: core/lsp.lua
 * Description: Core LSP functionality
--]]

-- LSP status checking and debugging
local M = {}

-- Check if LSP is attached to current buffer
function M.check_lsp_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	if #clients == 0 then
		vim.notify("❌ No LSP clients attached to current buffer", vim.log.levels.WARN)
		return false
	end
	
	for _, client in ipairs(clients) do
		vim.notify("✅ LSP Client: " .. client.name .. " (ID: " .. client.id .. ")", vim.log.levels.INFO)
		
		-- Check client capabilities
		if client.server_capabilities then
			if client.server_capabilities.hoverProvider then
				vim.notify("   - Hover: ✅ Available", vim.log.levels.INFO)
			else
				vim.notify("   - Hover: ❌ Not available", vim.log.levels.WARN)
			end
			
			if client.server_capabilities.definitionProvider then
				vim.notify("   - Definition: ✅ Available", vim.log.levels.INFO)
			else
				vim.notify("   - Definition: ❌ Not available", vim.log.levels.WARN)
			end
		end
	end
	
	return true
end

-- Force LSP to attach to current buffer
function M.force_lsp_attach()
	local bufnr = vim.api.nvim_get_current_buf()
	local filetype = vim.bo.filetype
	
	vim.notify("🔧 Attempting to attach LSP for filetype: " .. filetype, vim.log.levels.INFO)
	
	-- Try to start appropriate LSP server
	if filetype == "lua" then
		require("lspconfig").lua_ls.setup({})
		vim.notify("✅ Lua LSP setup completed", vim.log.levels.INFO)
	elseif filetype == "typescript" or filetype == "javascript" then
		require("lspconfig").ts_ls.setup({})
		vim.notify("✅ TypeScript LSP setup completed", vim.log.levels.INFO)
	elseif filetype == "go" then
		require("lspconfig").gopls.setup({})
		vim.notify("✅ Go LSP setup completed", vim.log.levels.INFO)
	elseif filetype == "cpp" or filetype == "c" then
		require("lspconfig").clangd.setup({})
		vim.notify("✅ C/C++ LSP setup completed", vim.log.levels.INFO)
	elseif filetype == "python" then
		require("lspconfig").pyright.setup({})
		vim.notify("✅ Python LSP setup completed", vim.log.levels.INFO)
	elseif filetype == "rust" then
		require("lspconfig").rust_analyzer.setup({})
		vim.notify("✅ Rust LSP setup completed", vim.log.levels.INFO)
	end
	
	-- Wait a bit and check status
	vim.defer_fn(function()
		M.check_lsp_status()
	end, 1000)
end

-- Test LSP functionality
function M.test_lsp()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	if #clients == 0 then
		vim.notify("❌ No LSP clients found. Trying to attach...", vim.log.levels.WARN)
		M.force_lsp_attach()
		return
	end
	
	-- Test hover functionality
	local ok, _ = pcall(vim.lsp.buf.hover)
	if ok then
		vim.notify("✅ Hover test successful!", vim.log.levels.INFO)
	else
		vim.notify("❌ Hover test failed!", vim.log.levels.ERROR)
	end
end

-- Start LSP server manually
function M.start_lsp_server()
	local filetype = vim.bo.filetype
	local lspconfig = require("lspconfig")
	
	vim.notify("🚀 Starting LSP server for: " .. filetype, vim.log.levels.INFO)
	
	if filetype == "lua" then
		lspconfig.lua_ls.setup({})
		lspconfig.lua_ls.manager.start()
	elseif filetype == "typescript" or filetype == "javascript" then
		lspconfig.ts_ls.setup({})
		lspconfig.ts_ls.manager.start()
	elseif filetype == "go" then
		lspconfig.gopls.setup({})
		lspconfig.gopls.manager.start()
	elseif filetype == "cpp" or filetype == "c" then
		lspconfig.clangd.setup({})
		lspconfig.clangd.manager.start()
	elseif filetype == "python" then
		lspconfig.pyright.setup({})
		lspconfig.pyright.manager.start()
	elseif filetype == "rust" then
		lspconfig.rust_analyzer.setup({})
		lspconfig.rust_analyzer.manager.start()
	end
	
	vim.notify("✅ LSP server started for: " .. filetype, vim.log.levels.INFO)
end

-- Create user commands for LSP debugging
vim.api.nvim_create_user_command("LSPStatus", function()
	M.check_lsp_status()
end, {})

vim.api.nvim_create_user_command("LSPAttach", function()
	M.force_lsp_attach()
end, {})

vim.api.nvim_create_user_command("LSPTest", function()
	M.test_lsp()
end, {})

vim.api.nvim_create_user_command("LSPStartServer", function()
	M.start_lsp_server()
end, {})

return M 