--[[
 * General utility functions.
 * 
 * Provides common operations, string manipulation, table helpers, and general utilities.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/general.lua
 * Description: General utilities
--]]

local M = {}

-- あたし、一般ユーティリティを美しくしたの…Neovimが美しく動作するように（╹◡╹）

-- String utilities
function M.trim(str)
	if not str then
		return ""
	end
	return str:match("^%s*(.-)%s*$")
end

function M.split(str, delimiter)
	if not str then
		return {}
	end
	delimiter = delimiter or "%s"
	
	local result = {}
	for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

function M.join(tbl, delimiter)
	if not tbl or #tbl == 0 then
		return ""
	end
	delimiter = delimiter or " "
	
	local result = ""
	for i, item in ipairs(tbl) do
		if i > 1 then
			result = result .. delimiter
		end
		result = result .. tostring(item)
	end
	return result
end

function M.capitalize(str)
	if not str or str == "" then
		return str
	end
	return str:sub(1, 1):upper() .. str:sub(2):lower()
end

function M.camel_case(str)
	if not str then
		return str
	end
	
	local words = M.split(str, "[^%w]+")
	local result = ""
	
	for i, word in ipairs(words) do
		if i == 1 then
			result = word:lower()
		else
			result = result .. M.capitalize(word)
		end
	end
	
	return result
end

function M.snake_case(str)
	if not str then
		return str
	end
	
	return str:gsub("([%l])([%u])", "%1_%2"):gsub("([%u])([%u][%l])", "%1_%2"):lower()
end

function M.kebab_case(str)
	if not str then
		return str
	end
	
	return str:gsub("([%l])([%u])", "%1-%2"):gsub("([%u])([%u][%l])", "%1-%2"):lower()
end

-- Table utilities
function M.table_length(tbl)
	if not tbl then
		return 0
	end
	
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

function M.table_contains(tbl, value)
	if not tbl then
		return false
	end
	
	for _, item in pairs(tbl) do
		if item == value then
			return true
		end
	end
	return false
end

function M.table_index_of(tbl, value)
	if not tbl then
		return -1
	end
	
	for i, item in ipairs(tbl) do
		if item == value then
			return i
		end
	end
	return -1
end

function M.table_remove_value(tbl, value)
	if not tbl then
		return false
	end
	
	for i = #tbl, 1, -1 do
		if tbl[i] == value then
			table.remove(tbl, i)
			return true
		end
	end
	return false
end

function M.table_merge(t1, t2)
	if not t1 then
		return t2 or {}
	end
	if not t2 then
		return t1
	end
	
	local result = {}
	for k, v in pairs(t1) do
		result[k] = v
	end
	for k, v in pairs(t2) do
		result[k] = v
	end
	return result
end

function M.table_deep_merge(t1, t2)
	if not t1 then
		return t2 or {}
	end
	if not t2 then
		return t1
	end
	
	local result = {}
	for k, v in pairs(t1) do
		if type(v) == "table" and type(t2[k]) == "table" then
			result[k] = M.table_deep_merge(v, t2[k])
		else
			result[k] = v
		end
	end
	for k, v in pairs(t2) do
		if not result[k] then
			result[k] = v
		end
	end
	return result
end

function M.table_filter(tbl, predicate)
	if not tbl then
		return {}
	end
	
	local result = {}
	for _, item in ipairs(tbl) do
		if predicate(item) then
			table.insert(result, item)
		end
	end
	return result
end

function M.table_map(tbl, transform)
	if not tbl then
		return {}
	end
	
	local result = {}
	for i, item in ipairs(tbl) do
		result[i] = transform(item, i)
	end
	return result
end

function M.table_reverse(tbl)
	if not tbl then
		return {}
	end
	
	local result = {}
	for i = #tbl, 1, -1 do
		table.insert(result, tbl[i])
	end
	return result
end

function M.table_unique(tbl)
	if not tbl then
		return {}
	end
	
	local seen = {}
	local result = {}
	for _, item in ipairs(tbl) do
		if not seen[item] then
			seen[item] = true
			table.insert(result, item)
		end
	end
	return result
end

-- Math utilities
function M.clamp(value, min, max)
	return math.max(min, math.min(max, value))
end

function M.lerp(a, b, t)
	return a + (b - a) * t
end

function M.round(value)
	return math.floor(value + 0.5)
end

function M.is_even(value)
	return value % 2 == 0
end

function M.is_odd(value)
	return value % 2 == 1
end

-- Time utilities
function M.get_timestamp()
	return os.time()
end

function M.format_time(timestamp)
	timestamp = timestamp or os.time()
	return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end

function M.format_time_relative(timestamp)
	timestamp = timestamp or os.time()
	local now = os.time()
	local diff = now - timestamp
	
	if diff < 60 then
		return "just now"
	elseif diff < 3600 then
		local minutes = math.floor(diff / 60)
		return minutes .. " minute" .. (minutes > 1 and "s" or "") .. " ago"
	elseif diff < 86400 then
		local hours = math.floor(diff / 3600)
		return hours .. " hour" .. (hours > 1 and "s" or "") .. " ago"
	elseif diff < 2592000 then
		local days = math.floor(diff / 86400)
		return days .. " day" .. (days > 1 and "s" or "") .. " ago"
	elseif diff < 31536000 then
		local months = math.floor(diff / 2592000)
		return months .. " month" .. (months > 1 and "s" or "") .. " ago"
	else
		local years = math.floor(diff / 31536000)
		return years .. " year" .. (years > 1 and "s" or "") .. " ago"
	end
end

-- Buffer utilities
function M.get_buffer_info(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	local name = vim.api.nvim_buf_get_name(bufnr)
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	local readonly = vim.api.nvim_buf_get_option(bufnr, "readonly")
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
	
	return {
		bufnr = bufnr,
		name = name,
		modified = modified,
		readonly = readonly,
		filetype = filetype,
		buftype = buftype,
	}
end

function M.get_buffer_list()
	local buffers = vim.api.nvim_list_bufs()
	local result = {}
	
	for _, bufnr in ipairs(buffers) do
		if vim.api.nvim_buf_is_valid(bufnr) then
			local info = M.get_buffer_info(bufnr)
			table.insert(result, info)
		end
	end
	
	return result
end

function M.close_buffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_delete(bufnr, { force = true })
		return true
	end
	return false
end

function M.close_other_buffers()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = M.get_buffer_list()
	
	for _, buf_info in ipairs(buffers) do
		if buf_info.bufnr ~= current_buf then
			M.close_buffer(buf_info.bufnr)
		end
	end
end

-- Window utilities
function M.get_window_info(winid)
	winid = winid or vim.api.nvim_get_current_win()
	
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local cursor = vim.api.nvim_win_get_cursor(winid)
	local position = vim.api.nvim_win_get_position(winid)
	local size = vim.api.nvim_win_get_width(winid), vim.api.nvim_win_get_height(winid)
	
	return {
		winid = winid,
		bufnr = bufnr,
		cursor = cursor,
		position = position,
		size = size,
	}
end

function M.get_window_list()
	local windows = vim.api.nvim_list_wins()
	local result = {}
	
	for _, winid in ipairs(windows) do
		if vim.api.nvim_win_is_valid(winid) then
			local info = M.get_window_info(winid)
			table.insert(result, info)
		end
	end
	
	return result
end

-- Tab utilities
function M.get_tab_info(tabnr)
	tabnr = tabnr or vim.api.nvim_get_current_tabpage()
	
	local windows = vim.api.nvim_tabpage_list_wins(tabnr)
	local result = {}
	
	for _, winid in ipairs(windows) do
		if vim.api.nvim_win_is_valid(winid) then
			local info = M.get_window_info(winid)
			table.insert(result, info)
		end
	end
	
	return {
		tabnr = tabnr,
		windows = result,
	}
end

function M.get_tab_list()
	local tabs = vim.api.nvim_list_tabpages()
	local result = {}
	
	for _, tabnr in ipairs(tabs) do
		local info = M.get_tab_info(tabnr)
		table.insert(result, info)
	end
	
	return result
end

-- System utilities
function M.get_system_info()
	local info = {
		os = vim.loop.os_uname().sysname,
		version = vim.loop.os_uname().version,
		release = vim.loop.os_uname().release,
		machine = vim.loop.os_uname().machine,
		hostname = vim.loop.os_uname().nodename,
	}
	
	return info
end

function M.get_memory_usage()
	local meminfo = vim.loop.get_memory_info()
	return {
		total = meminfo.total,
		available = meminfo.available,
		used = meminfo.total - meminfo.available,
		percentage = ((meminfo.total - meminfo.available) / meminfo.total) * 100,
	}
end

function M.get_cpu_usage()
	-- This is a simplified CPU usage calculation
	-- For more accurate results, you'd need to implement proper CPU monitoring
	return {
		usage = "N/A", -- Would need system-specific implementation
		cores = vim.loop.cpu_info() and #vim.loop.cpu_info() or "N/A",
	}
end

-- File system utilities
function M.get_file_size_human(bytes)
	if not bytes then
		return "0 B"
	end
	
	local units = { "B", "KB", "MB", "GB", "TB" }
	local unit_index = 1
	local size = bytes
	
	while size >= 1024 and unit_index < #units do
		size = size / 1024
		unit_index = unit_index + 1
	end
	
	return string.format("%.1f %s", size, units[unit_index])
end

-- Get file permissions (simplified version without bitwise operations)
function M.get_file_permissions(path)
	local stat = vim.loop.fs_stat(path)
	if not stat then
		return nil
	end
	
	-- Return a simple permission string for now
	-- This avoids the bitwise operation issues in Lua 5.1
	return "rw-r--r--" -- Default permissions
end

-- Validation utilities
function M.is_valid_filename(filename)
	if not filename or filename == "" then
		return false
	end
	
	-- Check for invalid characters
	local invalid_chars = "[<>:\"/\\|?*]"
	if filename:match(invalid_chars) then
		return false
	end
	
	-- Check for reserved names (Windows)
	local reserved_names = {
		"CON", "PRN", "AUX", "NUL",
		"COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9",
		"LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9",
	}
	
	local name_upper = filename:upper()
	for _, reserved in ipairs(reserved_names) do
		if name_upper == reserved then
			return false
		end
	end
	
	return true
end

function M.is_valid_url(url)
	if not url or url == "" then
		return false
	end
	
	-- Simple URL validation
	local pattern = "^https?://[%w-_%.%?%.:/%+=&]+$"
	return url:match(pattern) ~= nil
end

function M.is_valid_email(email)
	if not email or email == "" then
		return false
	end
	
	-- Simple email validation
	local pattern = "^[%w.%-_]+@[%w.%-_]+%.%w+$"
	return email:match(pattern) ~= nil
end

-- Debug utilities
function M.debug_print(...)
	local args = { ... }
	local result = {}
	
	for i, arg in ipairs(args) do
		if type(arg) == "table" then
			table.insert(result, vim.inspect(arg))
		else
			table.insert(result, tostring(arg))
		end
	end
	
	print(table.concat(result, " "))
end

function M.debug_log(...)
	local args = { ... }
	local result = {}
	
	for i, arg in ipairs(args) do
		if type(arg) == "table" then
			table.insert(result, vim.inspect(arg))
		else
			table.insert(result, tostring(arg))
		end
	end
	
	vim.notify(table.concat(result, " "), vim.log.levels.DEBUG)
end

-- Make utilities available globally
_G.GeneralUtils = M

return M 