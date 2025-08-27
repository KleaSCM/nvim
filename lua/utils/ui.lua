--[[
 * UI utility functions.
 * 
 * Provides notifications, status updates, and UI helpers.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/ui.lua
 * Description: UI utilities
--]]

local M = {}

-- あたし、UIユーティリティを美しくしたの…UIが美しく表示されるように（╹◡╹）

-- Notification system
local function notify(message, level, opts)
	level = level or vim.log.levels.INFO
	opts = opts or {}
	
	-- Use nvim-notify if available
	local has_notify, notify = pcall(require, "notify")
	if has_notify then
		notify(message, level, opts)
	else
		-- Fallback to vim.notify
		vim.notify(message, level, opts)
	end
end

-- Success notification
function M.notify_success(message, opts)
	notify("✨ " .. message, vim.log.levels.INFO, opts)
end

-- Error notification
function M.notify_error(message, opts)
	notify("💥 " .. message, vim.log.levels.ERROR, opts)
end

-- Warning notification
function M.notify_warning(message, opts)
	notify("⚠️ " .. message, vim.log.levels.WARN, opts)
end

-- Info notification
function M.notify_info(message, opts)
	notify("💡 " .. message, vim.log.levels.INFO, opts)
end

-- Debug notification
function M.notify_debug(message, opts)
	notify("🔍 " .. message, vim.log.levels.DEBUG, opts)
end

-- Status line updates
function M.update_status_line()
	-- Force status line refresh
	vim.cmd("redrawstatus!")
end

-- Echo message with highlighting
function M.echo(message, highlight)
	highlight = highlight or "None"
	vim.api.nvim_echo({ { message, highlight } }, true, {})
end

-- Echo message with multiple highlights
function M.echo_multi(parts)
	vim.api.nvim_echo(parts, true, {})
end

-- Show popup menu
function M.show_popup(title, items, callback)
	local lines = { title }
	table.insert(lines, string.rep("─", #title))
	
	for _, item in ipairs(items) do
		table.insert(lines, item)
	end
	
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, #line)
	end
	
	local height = #lines
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width + 2,
		height = height + 2,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	
	-- Set keymaps
	local opts = { buffer = buf, silent = true, nowait = true }
	vim.keymap.set("n", "<CR>", function()
		local line = vim.api.nvim_win_get_cursor(win)[1]
		if callback and line > 2 then
			callback(line - 2, items[line - 2])
		end
		vim.api.nvim_win_close(win, true)
	end, opts)
	
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, opts)
	
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, opts)
	
	-- Auto-close on focus loss
	vim.api.nvim_create_autocmd("WinLeave", {
		buffer = buf,
		callback = function()
			vim.api.nvim_win_close(win, true)
		end,
		once = true,
	})
end

-- Show confirmation dialog
function M.confirm(message, callback_yes, callback_no)
	local lines = { message, "", "Press y for Yes, n for No" }
	
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, #line)
	end
	
	local height = #lines
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width + 2,
		height = height + 2,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	
	-- Set keymaps
	local opts = { buffer = buf, silent = true, nowait = true }
	vim.keymap.set("n", "y", function()
		vim.api.nvim_win_close(win, true)
		if callback_yes then
			callback_yes()
		end
	end, opts)
	
	vim.keymap.set("n", "n", function()
		vim.api.nvim_win_close(win, true)
		if callback_no then
			callback_no()
		end
	end, opts)
	
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
		if callback_no then
			callback_no()
		end
	end, opts)
	
	-- Auto-close on focus loss
	vim.api.nvim_create_autocmd("WinLeave", {
		buffer = buf,
		callback = function()
			vim.api.nvim_win_close(win, true)
		end,
		once = true,
	})
end

-- Show progress bar
function M.show_progress(title, current, total, callback)
	local percentage = math.floor((current / total) * 100)
	local bar_width = 30
	local filled = math.floor((percentage / 100) * bar_width)
	local empty = bar_width - filled
	
	local bar = string.rep("█", filled) .. string.rep("░", empty)
	local lines = {
		title,
		string.format("Progress: %d%%", percentage),
		string.format("[%s] %d/%d", bar, current, total),
	}
	
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, #line)
	end
	
	local height = #lines
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width + 2,
		height = height + 2,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	
	-- Update progress
	if callback then
		callback(buf, win)
	end
	
	return buf, win
end

-- Hide progress bar
function M.hide_progress(win)
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
	end
end

-- Show floating window
function M.show_floating(content, opts)
	opts = opts or {}
	
	local width = opts.width or 50
	local height = opts.height or 10
	local title = opts.title or "Info"
	
	local lines = { title }
	table.insert(lines, string.rep("─", #title))
	
	if type(content) == "string" then
		for line in content:gmatch("[^\r\n]+") do
			table.insert(lines, line)
		end
	elseif type(content) == "table" then
		for _, line in ipairs(content) do
			table.insert(lines, tostring(line))
		end
	end
	
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = opts.border or "rounded",
	})
	
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	
	-- Set keymaps
	local buf_opts = { buffer = buf, silent = true, nowait = true }
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, buf_opts)
	
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, buf_opts)
	
	-- Auto-close on focus loss
	vim.api.nvim_create_autocmd("WinLeave", {
		buffer = buf,
		callback = function()
			vim.api.nvim_win_close(win, true)
		end,
		once = true,
	})
	
	return buf, win
end

-- Show help window
function M.show_help(content, title)
	title = title or "Help"
	M.show_floating(content, {
		title = title,
		width = 80,
		height = 20,
		border = "double",
	})
end

-- Show error window
function M.show_error(message, details)
	local content = { "Error: " .. message }
	if details then
		table.insert(content, "")
		table.insert(content, "Details:")
		if type(details) == "string" then
			table.insert(content, details)
		elseif type(details) == "table" then
			for _, detail in ipairs(details) do
				table.insert(content, detail)
			end
		end
	end
	
	M.show_floating(content, {
		title = "💥 Error",
		width = 70,
		height = 15,
		border = "double",
	})
end

-- Show success window
function M.show_success(message, details)
	local content = { "Success: " .. message }
	if details then
		table.insert(content, "")
		table.insert(content, "Details:")
		if type(details) == "string" then
			table.insert(content, details)
		elseif type(details) == "table" then
			for _, detail in ipairs(details) do
				table.insert(content, detail)
			end
		end
	end
	
	M.show_floating(content, {
		title = "✨ Success",
		width = 70,
		height = 15,
		border = "double",
	})
end

-- Show info window
function M.show_info(message, details)
	local content = { "Info: " .. message }
	if details then
		table.insert(content, "")
		table.insert(content, "Details:")
		if type(details) == "string" then
			table.insert(content, details)
		elseif type(details) == "table" then
			for _, detail in ipairs(details) do
				table.insert(content, detail)
			end
		end
	end
	
	M.show_floating(content, {
		title = "💡 Information",
		width = 70,
		height = 15,
		border = "double",
	})
end

-- Toggle UI elements
function M.toggle_ui_element(element)
	if element == "statusline" then
		vim.o.laststatus = vim.o.laststatus == 0 and 2 or 0
		M.notify_info("Status line " .. (vim.o.laststatus == 0 and "hidden" or "shown"))
	elseif element == "tabline" then
		vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
		M.notify_info("Tab line " .. (vim.o.showtabline == 0 and "hidden" or "shown"))
	elseif element == "line_numbers" then
		vim.o.number = not vim.o.number
		M.notify_info("Line numbers " .. (vim.o.number and "shown" or "hidden"))
	elseif element == "relative_numbers" then
		vim.o.relativenumber = not vim.o.relativenumber
		M.notify_info("Relative numbers " .. (vim.o.relativenumber and "shown" or "hidden"))
	elseif element == "sign_column" then
		vim.o.signcolumn = vim.o.signcolumn == "no" and "yes" or "no"
		M.notify_info("Sign column " .. (vim.o.signcolumn == "no" and "hidden" or "shown"))
	elseif element == "cursor_line" then
		vim.o.cursorline = not vim.o.cursorline
		M.notify_info("Cursor line " .. (vim.o.cursorline and "highlighted" or "normal"))
	elseif element == "cursor_column" then
		vim.o.cursorcolumn = not vim.o.cursorcolumn
		M.notify_info("Cursor column " .. (vim.o.cursorcolumn and "highlighted" or "normal"))
	else
		M.notify_warning("Unknown UI element: " .. element)
	end
end

-- Make utilities available globally
_G.UIUtils = M

return M 