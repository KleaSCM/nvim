--[[
 * Autocommands configuration module.
 * 
 * This module defines various autocommands for automatic behaviors
 * and enhanced user experience.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: autocmds.lua
 * Description: Autocommands and automatic behaviors
--]]

local api = vim.api

-- Create autocommands group
local group = api.nvim_create_augroup("CursorNeovim", { clear = true })

-- Auto-resize windows when terminal is resized
api.nvim_create_autocmd("VimResized", {
	group = group,
	command = "wincmd =",
})

-- Auto-close NvimTree when it's the last window
api.nvim_create_autocmd("BufEnter", {
	group = group,
	nested = true,
	callback = function()
		local is_ntree = vim.fn.bufname(vim.fn.bufnr()) == "NvimTree_" .. vim.fn.tabpagenr()
		if is_ntree and vim.fn.winnr("$") == 1 then
			vim.cmd("quit")
		end
	end,
})

-- Auto-format on save for supported filetypes
api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.yaml", "*.yml" },
	callback = function()
		if vim.fn.exists(":Format") == 2 then
			vim.cmd("Format")
		elseif vim.fn.exists(":lua vim.lsp.buf.format()") == 2 then
			vim.lsp.buf.format()
		end
	end,
})

-- Auto-close quickfix and location lists when leaving them
api.nvim_create_autocmd("WinLeave", {
	group = group,
	pattern = "*",
	callback = function()
		local win_info = vim.fn.getwininfo(vim.fn.winnr())
		if win_info and #win_info > 0 and win_info[1] then
			if win_info[1].quickfix == 1 then
				vim.cmd("cclose")
			end
			if win_info[1].loclist == 1 then
				vim.cmd("lclose")
			end
		end
	end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- Auto-save when leaving insert mode (optional)
api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd("silent! write")
		end
	end,
})

-- Auto-close help windows when leaving them
api.nvim_create_autocmd("BufLeave", {
	group = group,
	pattern = "*help*",
	command = "quit",
})

-- Auto-hide cursor line in insert mode
api.nvim_create_autocmd("InsertEnter", {
	group = group,
	pattern = "*",
	command = "set nocursorline",
})

-- Always show diagnostics in all modes
api.nvim_create_autocmd("ModeChanged", {
	group = group,
	pattern = "*",
	callback = function()
		-- あたし、診断を常に表示するようにしたの…エラーが見えるように（╹◡╹）
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})
	end,
})

api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	command = "set cursorline",
})

-- Auto-switch to absolute line numbers in insert mode
api.nvim_create_autocmd("InsertEnter", {
	group = group,
	pattern = "*",
	command = "set norelativenumber",
})

api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	command = "set relativenumber",
})

-- Auto-open NvimTree when opening a directory and create undo directory
api.nvim_create_autocmd("VimEnter", {
	group = group,
	pattern = "*",
	callback = function()
		-- Create undo directory
		local undo_dir = vim.fn.stdpath("data") .. "/undodir"
		if vim.fn.isdirectory(undo_dir) == 0 then
			vim.fn.mkdir(undo_dir, "p")
		end
		
		-- Open NvimTree if opening a directory
		local argv0 = vim.fn.argv(0)
		if argv0 and argv0 ~= "" and vim.fn.isdirectory(argv0) == 1 then
			vim.cmd("NvimTreeOpen")
			vim.cmd("wincmd l")
		end
		
		-- Restore session if available
		if vim.fn.argc() == 0 and vim.fn.filereadable("~/.vim/session.vim") == 1 then
			vim.cmd("source ~/.vim/session.vim")
		end
	end,
})

-- VIOLENT DIAGNOSTIC CONFIGURATION! 🔥💀⚡
api.nvim_create_autocmd("VimEnter", {
	group = group,
	pattern = "*",
	callback = function()
		-- Make diagnostics absolutely TERRIFYING!
		vim.diagnostic.config({
			-- Clean, simple diagnostic display! 💥⚡
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			
			-- Clean, simple diagnostic display! 💥⚡
			virtual_text = {
				spacing = 4,
				prefix = "",
				source = "if_many",
				format = function(diagnostic)
					local icons = {
						[1] = "💥",
						[2] = "⚠️",
						[3] = "💡",
						[4] = "💭",
					}
					return icons[diagnostic.severity] .. " " .. diagnostic.message
				end,
			},
			
			-- VIOLENT SIGNS!
			signs = {
				active = true,
				values = {
					{ name = "DiagnosticSignError", text = "💥💥💥", texthl = "DiagnosticSignError" },
					{ name = "DiagnosticSignWarn", text = "⚠️⚠️⚠️", texthl = "DiagnosticSignWarn" },
					{ name = "DiagnosticSignHint", text = "💡", texthl = "DiagnosticSignHint" },
					{ name = "DiagnosticSignInfo", text = "💭", texthl = "DiagnosticSignInfo" },
				},
			},
			
			-- VIOLENT UNDERLINES!
			underline = {
				severity = { min = vim.diagnostic.severity.HINT },
			},
		})
		
		-- VIOLENT ERROR HIGHLIGHTS!
		vim.api.nvim_set_hl(0, "DiagnosticError", {
			fg = "#ff0000",
			bg = "#000000",
			sp = "#ff0000",
			bold = true,
			underline = true,
			italic = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticWarn", {
			fg = "#ff8800",
			bg = "#000000",
			sp = "#ff8800",
			bold = true,
			underline = true,
			italic = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticInfo", {
			fg = "#00ff00",
			bg = "#000000",
			sp = "#00ff00",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticHint", {
			fg = "#0088ff",
			bg = "#000000",
			sp = "#0088ff",
			bold = true,
		})
		
		-- VIOLENT SIGN HIGHLIGHTS!
		vim.api.nvim_set_hl(0, "DiagnosticSignError", {
			fg = "#ff0000",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", {
			fg = "#ff8800",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", {
			fg = "#00ff00",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", {
			fg = "#0088ff",
			bg = "#000000",
			bold = true,
		})
	end,
})

-- Auto-configure terminal buffers
api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "*",
	callback = function()
		-- Set buffer options to hide from buffer tabs
		vim.bo.buftype = "terminal"
		vim.bo.bufhidden = "hide"
		vim.bo.swapfile = false
		vim.bo.filetype = "terminal"
		
		-- Give it a unique name if it doesn't have one
		local buf_name = vim.api.nvim_buf_get_name(0)
		if buf_name == "" or buf_name:match("^term://") then
			-- Check if this is a Telescope terminal preview
			local buf_type = vim.bo.buftype
			if buf_type == "terminal" then
				-- Generate a unique name with timestamp to avoid conflicts
				local timestamp = os.time()
				local unique_name = "Terminal_" .. timestamp .. "_" .. math.random(1000, 9999)
				
				-- Use pcall to safely rename without errors
				local ok, _ = pcall(vim.cmd, "file " .. unique_name)
				if not ok then
					-- If renaming fails, just use a simple name
					pcall(vim.cmd, "file Terminal_" .. timestamp)
				end
			end
		end
	end,
})

-- Auto-close terminal when job ends (safely!)
api.nvim_create_autocmd("TermClose", {
	group = group,
	pattern = "*",
	callback = function()
		-- あたし、ターミナルを安全に閉じるようにしたの…エラーが出ちゃうから（╹◡╹）
		local buf = vim.api.nvim_get_current_buf()
		if vim.api.nvim_buf_is_valid(buf) then
			-- Use pcall to safely close without errors
			local ok, _ = pcall(vim.api.nvim_buf_delete, buf, { force = false })
			if not ok then
				-- If deletion fails, just hide it instead
				vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
			end
		end
	end,
})

-- Handle Telescope terminal previews gracefully
api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "*",
	callback = function()
		-- あたし、Telescopeのターミナルプレビューを美しくしたの…エラーが出ちゃうから（╹◡╹）
		local buf = vim.api.nvim_get_current_buf()
		local buf_name = vim.api.nvim_buf_get_name(buf)
		
		-- Check if this is a Telescope terminal preview
		if buf_name:match("^Telescope") or buf_name:match("^term://.*telescope") then
			-- Set Telescope terminal options
			vim.bo.buftype = "terminal"
			vim.bo.bufhidden = "hide"
			vim.bo.swapfile = false
			vim.bo.filetype = "terminal"
			
			-- Give it a unique name to avoid conflicts
			local timestamp = os.time()
			local unique_name = "TelescopeTerminal_" .. timestamp .. "_" .. math.random(1000, 9999)
			
			-- Use pcall to safely rename without errors
			local ok, _ = pcall(vim.cmd, "file " .. unique_name)
			if not ok then
				-- If renaming fails, just use a simple name
				pcall(vim.cmd, "file TelescopeTerminal_" .. timestamp)
			end
		end
	end,
})

-- Auto-clean up temporary buffers (safely!)
api.nvim_create_autocmd("BufHidden", {
	group = group,
	pattern = "*",
	callback = function()
		-- あたし、このバッファクリーンアップを安全にしたの…Lualine Noticesが怒っちゃって（ ; ; ）
		local buf = vim.api.nvim_get_current_buf()
		local buf_name = vim.api.nvim_buf_get_name(buf)
		local buf_type = vim.bo.buftype
		local buf_listed = vim.bo.buflisted
		
		-- Skip important system buffers
		if buf_name:match("^Lualine") or 
		   buf_name:match("^Telescope") or
		   buf_name:match("^Neo%-tree") or
		   buf_name:match("^Trouble") or
		   buf_name:match("^Mason") or
		   buf_name:match("^Lazy") or
		   buf_name:match("^Terminal_") or
		   buf_name:match("^term://") then
			return
		end
		
		-- Only delete truly temporary, unlisted buffers
		if buf_type == "nofile" and not buf_listed then
			-- Check if buffer is still valid and not in use
			if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "modifiable") then
				-- Use pcall to safely delete without errors
				local ok, _ = pcall(vim.api.nvim_buf_delete, buf, { force = false })
				if not ok then
					-- If deletion fails, just hide it instead
					vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
				end
			end
		end
	end,
})

-- Auto-set filetype for specific patterns
api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.conf",
	command = "set filetype=conf",
})

api.nvim_create_autocmd("BufRead", {
	group = group,
	pattern = "*.conf",
	command = "set filetype=conf",
})

api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.env*",
	command = "set filetype=sh",
})

api.nvim_create_autocmd("BufRead", {
	group = group,
	pattern = "*.env*",
	command = "set filetype=sh",
})

-- Auto-create undo directory
-- (Now handled in the combined VimEnter autocmd above)

-- Auto-save session
api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	pattern = "*",
	command = "mksession! ~/.vim/session.vim",
})

-- Auto-restore session
-- (Now handled in the combined VimEnter autocmd above) 