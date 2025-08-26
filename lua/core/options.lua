--[[
 * Core Neovim options configuration.
 * 
 * This module contains all the basic Neovim options and settings
 * that provide a modern, responsive editing experience.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: options.lua
 * Description: Core Neovim options and settings
--]]

local opt = vim.opt
local g = vim.g

-- General options
opt.mouse = "a"                    -- Enable mouse in all modes
opt.clipboard = "unnamedplus"      -- Use system clipboard
opt.swapfile = false               -- Disable swap files
opt.backup = false                 -- Disable backup files
opt.undofile = true                -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Search options
opt.ignorecase = true              -- Case insensitive search
opt.smartcase = true               -- Case sensitive when uppercase present
opt.hlsearch = true                -- Highlight search results
opt.incsearch = true               -- Incremental search

-- Indentation
opt.expandtab = true               -- Use spaces instead of tabs
opt.shiftwidth = 4                 -- Size of an indent
opt.tabstop = 4                    -- Number of spaces a tab counts for
opt.softtabstop = 4                -- Number of spaces a tab counts for while editing
opt.smartindent = true             -- Smart indentation
opt.breakindent = true             -- Preserve indentation in wrapped lines

-- Line numbers and signs
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Show relative line numbers
opt.signcolumn = "yes"             -- Always show sign column
opt.cursorline = true              -- Highlight current line
opt.cursorcolumn = false           -- Don't highlight current column

-- UI options
opt.showmode = false               -- Don't show mode in command line
opt.showcmd = true                 -- Show partial commands
opt.ruler = false                  -- Don't show ruler
opt.laststatus = 3                 -- Always show status line
opt.showtabline = 2                -- Always show tab line
opt.winbar = "%=%m %f"            -- Show file info in winbar

-- Performance
opt.lazyredraw = true              -- Don't redraw while executing macros
opt.updatetime = 300               -- Faster completion
opt.timeoutlen = 300               -- Faster key sequence completion

-- Window options
opt.splitbelow = true              -- Horizontal splits below
opt.splitright = true              -- Vertical splits right
opt.scrolloff = 8                  -- Lines of context around cursor
opt.sidescrolloff = 8             -- Columns of context around cursor

-- File options
opt.fileencoding = "utf-8"         -- File encoding
opt.termguicolors = true           -- Enable true colors
opt.completeopt = "menuone,noselect" -- Completion options

-- Disable built-in plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit"
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- Set colorscheme
opt.background = "dark"

-- Performance optimizations
opt.hidden = true                  -- Allow hidden buffers
opt.history = 1000                 -- Command history
opt.wildmenu = true                -- Command line completion
opt.wildmode = "list:longest"      -- Command line completion mode
opt.wildignore = "*.o,*.obj,*.pyc,*.so,*.dll,*.dylib,*.exe,*.out,*.app"

-- Grep options
opt.grepprg = "rg --vimgrep"      -- Use ripgrep for grep
opt.grepformat = "%f:%l:%c:%m"    -- Grep format

-- Terminal options
opt.scrollback = 10000             -- Terminal scrollback lines

-- Disable some providers
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- Set default shell
opt.shell = "/usr/bin/zsh"

-- Enable filetype detection
opt.filetype = "on"
opt.syntax = "on"

-- Set default indentation for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "json", "yaml", "markdown" },
	command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2"
})

-- Set default indentation for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "rust", "cpp", "c" },
	command = "setlocal shiftwidth=4 tabstop=4 softtabstop=4"
}) 

-- Aggressive error highlighting - make errors SCREAM at you!
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("AggressiveErrors", { clear = true }),
	callback = function()
		-- Make errors SCREAM with bright red background and white text
		vim.api.nvim_set_hl(0, "Error", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff",
			reverse = true
		})
		
		-- Make error messages in the command line impossible to miss
		vim.api.nvim_set_hl(0, "ErrorMsg", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff"
		})
		
		-- Aggressive warning highlighting
		vim.api.nvim_set_hl(0, "WarningMsg", { 
			bg = "#ff8800", 
			fg = "#000000", 
			bold = true, 
			underline = true,
			sp = "#000000"
		})
		
		-- Make diagnostic errors SCREAM
		vim.api.nvim_set_hl(0, "DiagnosticError", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff",
			reverse = true
		})
		
		-- Aggressive diagnostic warnings
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { 
			bg = "#ff8800", 
			fg = "#000000", 
			bold = true, 
			underline = true,
			sp = "#000000"
		})
		
		-- Make quickfix errors stand out
		vim.api.nvim_set_hl(0, "QuickFixLine", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff"
		})
		
		-- Make ALL diagnostic errors SCREAM with flashing effects
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff",
			reverse = true
		})
		
		-- Aggressive diagnostic hints
		vim.api.nvim_set_hl(0, "DiagnosticHint", { 
			bg = "#00ff00", 
			fg = "#000000", 
			bold = true, 
			underline = true,
			sp = "#000000"
		})
		
		-- Make error signs impossible to miss
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { 
			bg = "#ff0000", 
			fg = "#ffffff", 
			bold = true, 
			underline = true,
			sp = "#ffffff",
			reverse = true
		})
		
		-- Aggressive warning signs
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { 
			bg = "#ff8800", 
			fg = "#000000", 
			bold = true, 
			underline = true,
			sp = "#000000"
		})
	end,
})

-- Apply aggressive highlighting immediately
vim.api.nvim_command("doautocmd ColorScheme") 

-- Error display - make errors SCREAM!
vim.opt.errorbells = true          -- Ring bell on errors
vim.opt.visualbell = true          -- Visual bell instead of audio
vim.opt.showmatch = true           -- Show matching brackets
vim.opt.matchtime = 1              -- Show match for 0.1 seconds
vim.opt.showcmd = true             -- Show command being typed
vim.opt.ruler = true               -- Show cursor position
vim.opt.laststatus = 2             -- Always show status line
vim.opt.cmdheight = 2              -- Make command line taller for errors 

	-- Mouse support - make everything interactive and cute!
	vim.opt.mouse = "a"                    -- Enable mouse in all modes
	vim.opt.mousemodel = "extend"          -- Extend selection with mouse
	vim.opt.mousefocus = true              -- Mouse can focus windows
	vim.opt.mousehide = false              -- Don't hide mouse cursor
	vim.opt.mousemoveevent = true          -- Enable mouse move events 