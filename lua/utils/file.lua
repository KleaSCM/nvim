--[[
 * File utility functions.
 * 
 * Provides file path manipulation, file operations, and file system helpers.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/file.lua
 * Description: File system utilities
--]]

local M = {}

-- あたし、ファイルユーティリティを美しくしたの…ファイルが美しく操作されるように（╹◡╹）

-- Get file extension
function M.get_file_extension(filename)
	if not filename then
		return ""
	end
	return filename:match("^.+%.(.+)$") or ""
end

-- Get file name without extension
function M.get_filename_without_extension(filename)
	if not filename then
		return ""
	end
	return filename:match("^(.+)%..+$") or filename
end

-- Check if file exists
function M.file_exists(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

-- Check if directory exists
function M.dir_exists(path)
	return vim.fn.isdirectory(path) == 1
end

-- Create directory if it doesn't exist
function M.ensure_dir(path)
	if not M.dir_exists(path) then
		vim.fn.mkdir(path, "p")
		return true
	end
	return false
end

-- Get relative path from current working directory
function M.get_relative_path(absolute_path)
	local cwd = vim.fn.getcwd()
	if absolute_path:sub(1, #cwd) == cwd then
		return absolute_path:sub(#cwd + 2)
	end
	return absolute_path
end

-- Get absolute path from relative path
function M.get_absolute_path(relative_path)
	local cwd = vim.fn.getcwd()
	return cwd .. "/" .. relative_path
end

-- Get project root (looks for .git, package.json, etc.)
function M.get_project_root()
	local current = vim.fn.getcwd()
	local parent = vim.fn.fnamemodify(current, ":h")
	
	while current ~= parent do
		if M.file_exists(current .. "/.git") or
		   M.file_exists(current .. "/package.json") or
		   M.file_exists(current .. "/go.mod") or
		   M.file_exists(current .. "/Cargo.toml") or
		   M.file_exists(current .. "/pyproject.toml") then
			return current
		end
		current = parent
		parent = vim.fn.fnamemodify(current, ":h")
	end
	
	return vim.fn.getcwd()
end

-- Get file size in human readable format
function M.get_file_size(path)
	local file = io.open(path, "r")
	if not file then
		return "Unknown"
	end
	
	local size = file:seek("end")
	file:close()
	
	if size < 1024 then
		return size .. " B"
	elseif size < 1024 * 1024 then
		return string.format("%.1f KB", size / 1024)
	elseif size < 1024 * 1024 * 1024 then
		return string.format("%.1f MB", size / (1024 * 1024))
	else
		return string.format("%.1f GB", size / (1024 * 1024 * 1024))
	end
end

-- Get file modification time
function M.get_file_mtime(path)
	local stat = vim.loop.fs_stat(path)
	if stat then
		return os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec)
	end
	return "Unknown"
end

-- Copy file
function M.copy_file(source, destination)
	local source_file = io.open(source, "rb")
	if not source_file then
		return false, "Cannot open source file"
	end
	
	local dest_file = io.open(destination, "wb")
	if not dest_file then
		source_file:close()
		return false, "Cannot create destination file"
	end
	
	local content = source_file:read("*a")
	dest_file:write(content)
	
	source_file:close()
	dest_file:close()
	
	return true
end

-- Move file
function M.move_file(source, destination)
	local success, err = M.copy_file(source, destination)
	if success then
		os.remove(source)
		return true
	end
	return false, err
end

-- Get all files in directory recursively
function M.get_files_recursive(dir, pattern)
	local files = {}
	local function scan(current_dir)
		local items = vim.fn.readdir(current_dir)
		for _, item in ipairs(items) do
			if item ~= "." and item ~= ".." then
				local full_path = current_dir .. "/" .. item
				if M.dir_exists(full_path) then
					scan(full_path)
				elseif not pattern or item:match(pattern) then
					table.insert(files, full_path)
				end
			end
		end
	end
	
	scan(dir)
	return files
end

-- Find files by pattern in project
function M.find_files_by_pattern(pattern)
	local project_root = M.get_project_root()
	return M.get_files_recursive(project_root, pattern)
end

-- Create backup of file
function M.backup_file(filepath)
	if not M.file_exists(filepath) then
		return false, "File does not exist"
	end
	
	local backup_path = filepath .. ".backup." .. os.time()
	return M.copy_file(filepath, backup_path)
end

-- Restore file from backup
function M.restore_file(backup_path)
	local original_path = backup_path:match("^(.+)%.backup%.%d+$")
	if not original_path then
		return false, "Invalid backup file"
	end
	
	return M.copy_file(backup_path, original_path)
end

-- Get file type icon (requires nvim-web-devicons)
function M.get_file_icon(filename)
	local has_devicons, devicons = pcall(require, "nvim-web-devicons")
	if has_devicons then
		local icon, hl = devicons.get_icon(filename)
		return icon or "📄", hl or "File"
	end
	return "📄", "File"
end

-- Format file path for display
function M.format_path(path, max_length)
	if not max_length then
		max_length = 50
	end
	
	if #path <= max_length then
		return path
	end
	
	local parts = vim.split(path, "/")
	local result = ""
	local current_length = 0
	
	for i = #parts, 1, -1 do
		local part = parts[i]
		if current_length + #part + 1 <= max_length then
			result = part .. (result ~= "" and "/" or "") .. result
			current_length = current_length + #part + 1
		else
			break
		end
	end
	
	return "..." .. result
end

-- Make utilities available globally
_G.FileUtils = M

return M 