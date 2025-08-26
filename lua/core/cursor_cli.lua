--[[
 * Cursor CLI integration module.
 * 
 * This module provides seamless integration with the Cursor CLI,
 * including chat interface, code generation, and file editing.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: cursor_cli.lua
 * Description: Cursor CLI integration and chat interface
--]]

local M = {}

-- Check if Cursor CLI is available
local function check_cursor_cli()
	local handle = io.popen("which cursor")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result ~= ""
	end
	return false
end

-- Execute Cursor CLI command
local function execute_cursor_command(args)
	if not check_cursor_cli() then
		vim.notify("Cursor CLI not found. Please install it first.", vim.log.levels.ERROR)
		return nil
	end

	local cmd = "cursor " .. table.concat(args, " ")
	local handle = io.popen(cmd)
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result
	end
	return nil
end

-- Create chat buffer
local function create_chat_buffer()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.4)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Cursor CLI Chat ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_win_set_option(win, "wrap", true)
	vim.api.nvim_win_set_option(win, "linebreak", true)

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

	-- Add welcome message
	local welcome = {
		"# 💕 Cursor CLI Chat",
		"",
		"Welcome to your AI-powered development assistant!",
		"",
		"## Quick Commands:",
		"- Type your question and press Enter to chat",
		"- Use `:q` to close this window",
		"- Press `i` to enter insert mode",
		"",
		"## Example:",
		"\"Explain this code\" or \"Generate a function\"",
		"",
		"---",
		"",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, welcome)

	-- Set keymaps for the chat buffer
	local opts = { buffer = buf, noremap = true, silent = true }
	vim.keymap.set("n", "i", "i", opts)
	vim.keymap.set("n", "q", ":q<CR>", opts)
	vim.keymap.set("n", "<CR>", function()
		-- Get current line content
		local line = vim.api.nvim_get_current_line()
		if line:match("^%s*$") then return end -- Skip empty lines
		
		-- Add user message
		local user_msg = "**You:** " .. line
		local lines = vim.api.nvim_buf_get_lines(buf, -1, -1, false)
		table.insert(lines, user_msg)
		table.insert(lines, "")
		
		-- Get Cursor CLI response
		local response = execute_cursor_command({ "chat", line })
		if response then
			table.insert(lines, "**Cursor:** " .. response)
		else
			table.insert(lines, "**Error:** Could not get response from Cursor CLI")
		end
		table.insert(lines, "")
		table.insert(lines, "---")
		table.insert(lines, "")
		
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
		
		-- Move cursor to end
		vim.api.nvim_win_set_cursor(win, { #lines, 0 })
	end, opts)

	return buf, win
end

-- Open Cursor chat
function M.open_chat()
	create_chat_buffer()
end

-- Generate code with Cursor
function M.generate_code(prompt)
	if not prompt then
		prompt = vim.fn.input("What would you like me to generate? ")
	end
	
	if prompt and prompt ~= "" then
		local response = execute_cursor_command({ "generate", prompt })
		if response then
			-- Create a new buffer with the generated code
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_option(buf, "modifiable", true)
			vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
			
			-- Split window and show generated code
			vim.cmd("vsplit")
			vim.api.nvim_win_set_buf(0, buf)
			
			-- Add the generated code
			local lines = vim.split(response, "\n")
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			
			-- Set filetype based on content or prompt
			if prompt:match("python") or prompt:match("py") then
				vim.api.nvim_buf_set_option(buf, "filetype", "python")
			elseif prompt:match("javascript") or prompt:match("js") then
				vim.api.nvim_buf_set_option(buf, "filetype", "javascript")
			elseif prompt:match("lua") then
				vim.api.nvim_buf_set_option(buf, "filetype", "lua")
			end
			
			vim.notify("Code generated successfully!", vim.log.levels.INFO)
		else
			vim.notify("Failed to generate code", vim.log.levels.ERROR)
		end
	end
end

-- Inspect code with Cursor
function M.inspect_code()
	local prompt = vim.fn.input("What would you like me to inspect? ")
	if prompt and prompt ~= "" then
		local response = execute_cursor_command({ "inspect", prompt })
		if response then
			vim.notify(response, vim.log.levels.INFO, { title = "Cursor Inspection" })
		else
			vim.notify("Failed to inspect code", vim.log.levels.ERROR)
		end
	end
end

-- Edit file with Cursor
function M.edit_with_cursor()
	local prompt = vim.fn.input("What changes would you like me to make? ")
	if prompt and prompt ~= "" then
		local response = execute_cursor_command({ "edit", prompt })
		if response then
			-- Apply the changes to current buffer
			local lines = vim.split(response, "\n")
			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			vim.notify("File edited successfully!", vim.log.levels.INFO)
		else
			vim.notify("Failed to edit file", vim.log.levels.ERROR)
		end
	end
end

-- Create commands
vim.api.nvim_create_user_command("CursorChat", M.open_chat, {})
vim.api.nvim_create_user_command("CursorGenerate", M.generate_code, {})
vim.api.nvim_create_user_command("CursorInspect", M.inspect_code, {})
vim.api.nvim_create_user_command("CursorEdit", M.edit_with_cursor, {})

-- Auto-completion for Cursor commands
vim.api.nvim_create_autocmd("CmdlineEnter", {
	pattern = "Cursor*",
	callback = function()
		-- This could be enhanced with more sophisticated completion
		vim.cmd("set wildmenu")
		vim.cmd("set wildmode=list:longest")
	end,
})

return M 