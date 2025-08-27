--[[
 * Git utility functions.
 * 
 * Provides Git operations, status information, and repository helpers.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/git.lua
 * Description: Git utilities
--]]

local M = {}

-- あたし、Gitユーティリティを美しくしたの…Gitが美しく操作されるように（╹◡╹）

-- Check if current directory is a git repository
function M.is_git_repo()
	return vim.fn.isdirectory(vim.fn.getcwd() .. "/.git") == 1
end

-- Get git root directory
function M.get_git_root()
	if not M.is_git_repo() then
		return nil
	end
	
	local current = vim.fn.getcwd()
	local parent = vim.fn.fnamemodify(current, ":h")
	
	while current ~= parent do
		if vim.fn.isdirectory(current .. "/.git") == 1 then
			return current
		end
		current = parent
		parent = vim.fn.fnamemodify(current, ":h")
	end
	
	return current
end

-- Get current git branch
function M.get_current_branch()
	if not M.is_git_repo() then
		return nil
	end
	
	local branch = vim.fn.system("git branch --show-current")
	return vim.trim(branch)
end

-- Get git status
function M.get_git_status()
	if not M.is_git_repo() then
		return nil
	end
	
	local status = vim.fn.system("git status --porcelain")
	local lines = vim.split(status, "\n")
	
	local result = {
		modified = 0,
		added = 0,
		deleted = 0,
		untracked = 0,
		renamed = 0,
		copied = 0,
		unmerged = 0,
	}
	
	for _, line in ipairs(lines) do
		if line ~= "" then
			local status_code = line:sub(1, 2)
			if status_code:match("^M") then
				result.modified = result.modified + 1
			elseif status_code:match("^A") then
				result.added = result.added + 1
			elseif status_code:match("^D") then
				result.deleted = result.deleted + 1
			elseif status_code:match("^%?%?") then
				result.untracked = result.untracked + 1
			elseif status_code:match("^R") then
				result.renamed = result.renamed + 1
			elseif status_code:match("^C") then
				result.copied = result.copied + 1
			elseif status_code:match("^U") or status_code:match("^AA") or status_code:match("^DD") then
				result.unmerged = result.unmerged + 1
			end
		end
	end
	
	return result
end

-- Get last commit information
function M.get_last_commit()
	if not M.is_git_repo() then
		return nil
	end
	
	local hash = vim.fn.system("git rev-parse HEAD")
	local author = vim.fn.system("git log -1 --pretty=format:'%an'")
	local date = vim.fn.system("git log -1 --pretty=format:'%ad' --date=short")
	local message = vim.fn.system("git log -1 --pretty=format:'%s'")
	
	return {
		hash = vim.trim(hash):sub(1, 8),
		full_hash = vim.trim(hash),
		author = vim.trim(author),
		date = vim.trim(date),
		message = vim.trim(message),
	}
end

-- Get commit count
function M.get_commit_count()
	if not M.is_git_repo() then
		return 0
	end
	
	local count = vim.fn.system("git rev-list --count HEAD")
	return tonumber(vim.trim(count)) or 0
end

-- Get file git status
function M.get_file_git_status(filepath)
	if not M.is_git_repo() then
		return nil
	end
	
	local status = vim.fn.system("git status --porcelain " .. vim.fn.shellescape(filepath))
	local line = vim.split(status, "\n")[1]
	
	if not line or line == "" then
		return "clean"
	end
	
	local status_code = line:sub(1, 2)
	if status_code:match("^M") then
		return "modified"
	elseif status_code:match("^A") then
		return "added"
	elseif status_code:match("^D") then
		return "deleted"
	elseif status_code:match("^%?%?") then
		return "untracked"
	elseif status_code:match("^R") then
		return "renamed"
	elseif status_code:match("^C") then
		return "copied"
	elseif status_code:match("^U") or status_code:match("^AA") or status_code:match("^DD") then
		return "unmerged"
	end
	
	return "unknown"
end

-- Get git diff for file
function M.get_file_diff(filepath)
	if not M.is_git_repo() then
		return nil
	end
	
	local diff = vim.fn.system("git diff " .. vim.fn.shellescape(filepath))
	return diff
end

-- Get git blame for line
function M.get_git_blame(filepath, line_number)
	if not M.is_git_repo() then
		return nil
	end
	
	local blame = vim.fn.system("git blame -L " .. line_number .. "," .. line_number .. " " .. vim.fn.shellescape(filepath))
	local line = vim.split(blame, "\n")[1]
	
	if not line or line == "" then
		return nil
	end
	
	-- Parse blame line: hash author date line_number content
	local hash, author, date, line_num, content = line:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%d+)%s+(.+)")
	
	return {
		hash = hash,
		author = author,
		date = date,
		line_number = tonumber(line_num),
		content = content,
	}
end

-- Stage file
function M.stage_file(filepath)
	if not M.is_git_repo() then
		return false, "Not a git repository"
	end
	
	local result = vim.fn.system("git add " .. vim.fn.shellescape(filepath))
	return vim.v.shell_error == 0, result
end

-- Unstage file
function M.unstage_file(filepath)
	if not M.is_git_repo() then
		return false, "Not a git repository"
	end
	
	local result = vim.fn.system("git reset HEAD " .. vim.fn.shellescape(filepath))
	return vim.v.shell_error == 0, result
end

-- Commit changes
function M.commit_changes(message)
	if not M.is_git_repo() then
		return false, "Not a git repository"
	end
	
	local result = vim.fn.system("git commit -m " .. vim.fn.shellescape(message))
	return vim.v.shell_error == 0, result
end

-- Push changes
function M.push_changes()
	if not M.is_git_repo() then
		return false, "Not a git repository"
	end
	
	local result = vim.fn.system("git push")
	return vim.v.shell_error == 0, result
end

-- Pull changes
function M.pull_changes()
	if not M.is_git_repo() then
		return false, "Not a git repository"
	end
	
	local result = vim.fn.system("git pull")
	return vim.v.shell_error == 0, result
end

-- Get git log
function M.get_git_log(count)
	if not M.is_git_repo() then
		return {}
	end
	
	count = count or 10
	local log = vim.fn.system("git log --oneline -n " .. count)
	local lines = vim.split(log, "\n")
	
	local commits = {}
	for _, line in ipairs(lines) do
		if line ~= "" then
			local hash, message = line:match("^(%S+)%s+(.+)")
			if hash and message then
				table.insert(commits, {
					hash = hash,
					message = message,
				})
			end
		end
	end
	
	return commits
end

-- Get git tags
function M.get_git_tags()
	if not M.is_git_repo() then
		return {}
	end
	
	local tags = vim.fn.system("git tag --sort=-version:refname")
	local lines = vim.split(tags, "\n")
	
	local result = {}
	for _, tag in ipairs(lines) do
		if tag ~= "" then
			table.insert(result, tag)
		end
	end
	
	return result
end

-- Get git remote info
function M.get_git_remotes()
	if not M.is_git_repo() then
		return {}
	end
	
	local remotes = vim.fn.system("git remote -v")
	local lines = vim.split(remotes, "\n")
	
	local result = {}
	for _, line in ipairs(lines) do
		if line ~= "" then
			local name, url, type = line:match("^(%S+)%s+(%S+)%s+(%S+)")
			if name and url then
				result[name] = {
					url = url,
					type = type,
				}
			end
		end
	end
	
	return result
end

-- Get git stash list
function M.get_git_stash_list()
	if not M.is_git_repo() then
		return {}
	end
	
	local stash = vim.fn.system("git stash list")
	local lines = vim.split(stash, "\n")
	
	local result = {}
	for _, line in ipairs(lines) do
		if line ~= "" then
			local stash_id, branch, message = line:match("^stash@{(%d+)}: ([^:]+): (.+)")
			if stash_id then
				table.insert(result, {
					id = tonumber(stash_id),
					branch = branch,
					message = message,
				})
			end
		end
	end
	
	return result
end

-- Create git status summary
function M.get_git_summary()
	if not M.is_git_repo() then
		return "Not a git repository"
	end
	
	local status = M.get_git_status()
	local branch = M.get_current_branch()
	local commit = M.get_last_commit()
	local count = M.get_commit_count()
	
	local summary = string.format("🌿 Branch: %s | 📊 Commits: %d", branch or "unknown", count)
	
	if status then
		if status.modified > 0 then
			summary = summary .. string.format(" | 💫 Modified: %d", status.modified)
		end
		if status.added > 0 then
			summary = summary .. string.format(" | ✨ Added: %d", status.added)
		end
		if status.deleted > 0 then
			summary = summary .. string.format(" | 💔 Deleted: %d", status.deleted)
		end
		if status.untracked > 0 then
			summary = summary .. string.format(" | 💭 Untracked: %d", status.untracked)
		end
	end
	
	if commit then
		summary = summary .. string.format(" | 📝 Last: %s", commit.message)
	end
	
	return summary
end

-- Make utilities available globally
_G.GitUtils = M

return M 