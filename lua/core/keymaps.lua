--[[
 * Keybindings configuration.
 * 
 * This file defines all custom keybindings for our Neovim configuration,
 * including window management, terminal integration, and essential development shortcuts.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: keymaps.lua
 * Description: Custom keybindings and shortcuts
--]]

-- Terminal management helpers (defined first)
local function create_right_terminal()
	-- Create right terminal if it doesn't exist
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
	vim.cmd("terminal")
	
	-- Immediately set buffer options to hide from buffer tabs
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
	
	-- Give it a unique name to avoid conflicts
	vim.cmd("file RightTerminal")
	vim.cmd("startinsert")
end

local function create_bottom_terminal()
	-- Create bottom terminal if it doesn't exist
	vim.cmd("split")
	vim.cmd("wincmd j")
	vim.cmd("terminal")
	
	-- Immediately set buffer options to hide from buffer tabs
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
	
	-- Give it a unique name to avoid conflicts
	vim.cmd("file BottomTerminal")
	vim.cmd("startinsert")
end

local function focus_right_terminal()
	-- Look for existing right terminal window
	local win_count = vim.fn.winnr("$")
	for i = 1, win_count do
		local win_id = vim.fn.win_getid(i)
		local buf = vim.api.nvim_win_get_buf(win_id)
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:match("RightTerminal") then
			vim.api.nvim_set_current_win(win_id)
			return
		end
	end
	-- If not found, create new one
	create_right_terminal()
end

local function focus_bottom_terminal()
	-- Look for existing bottom terminal window
	local win_count = vim.fn.winnr("$")
	for i = 1, win_count do
		local win_id = vim.fn.win_getid(i)
		local buf = vim.api.nvim_win_get_buf(win_id)
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:match("BottomTerminal") then
			vim.api.nvim_set_current_win(win_id)
			return
		end
	end
	-- If not found, create new one
	create_bottom_terminal()
end

-- Keybinding setup
local opts = { noremap = true, silent = true }
local leader = "<leader>"

-- Leader key shortcuts

-- Window management
local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h", opts)                    -- Navigate left
map("n", "<C-j>", "<C-w>j", opts)                    -- Navigate down
map("n", "<C-k>", "<C-w>k", opts)                    -- Navigate up
map("n", "<C-l>", "<C-w>l", opts)                    -- Navigate right

-- Resize windows
map("n", "<A-h>", "<C-w><", opts)                    -- Resize left
map("n", "<A-j>", "<C-w>-", opts)                    -- Resize down
map("n", "<A-k>", "<C-w>+", opts)                    -- Resize up
map("n", "<A-l>", "<C-w>>", opts)                    -- Resize right

-- Window splitting
map("n", leader .. "sv", "<C-w>v", opts)             -- Split vertically
map("n", leader .. "sh", "<C-w>s", opts)             -- Split horizontally
map("n", leader .. "se", "<C-w>=", opts)             -- Equalize windows
map("n", leader .. "sx", "<C-w>c", opts)             -- Close window

-- Buffer management
map("n", leader .. "bn", ":bnext<CR>", opts)         -- Next buffer
map("n", leader .. "bp", ":bprevious<CR>", opts)     -- Previous buffer
map("n", leader .. "bd", ":bdelete<CR>", opts)       -- Delete buffer
map("n", leader .. "bl", ":buffers<CR>", opts)       -- List buffers

-- File explorer (Nvim-tree)
map("n", leader .. "e", ":NvimTreeToggle<CR>", opts) -- Toggle file explorer
map("n", leader .. "ef", ":NvimTreeFocus<CR>", opts) -- Focus file explorer
map("n", leader .. "ec", ":NvimTreeClose<CR>", opts) -- Close file explorer

-- Terminal management - Simple and working!
map("n", leader .. "tt", ":ToggleTerm<CR>", opts)    -- Toggle terminal
map("n", leader .. "tf", ":ToggleTerm direction=float<CR>", opts) -- Float terminal
map("n", leader .. "th", ":ToggleTerm direction=horizontal<CR>", opts) -- Horizontal terminal
map("n", leader .. "tv", ":ToggleTerm direction=vertical<CR>", opts) -- Vertical terminal
map("n", leader .. "tc", "<C-w>c", opts)              -- Close current window

-- Right and bottom terminals - Truly separate instances!
map("n", leader .. "cc", focus_right_terminal, opts)   -- Create/focus right terminal
map("n", leader .. "tb", focus_bottom_terminal, opts)  -- Create/focus bottom terminal

-- Terminal navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)       -- Navigate left from terminal
map("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)       -- Navigate down from terminal
map("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)       -- Navigate up from terminal
map("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)       -- Navigate right from terminal
map("t", "<Esc>", "<C-\\><C-n>", opts)              -- Exit terminal mode

	-- Telescope integration
	map("n", leader .. "ff", ":Telescope find_files<CR>", opts) -- Find files
	map("n", leader .. "fg", ":Telescope live_grep<CR>", opts) -- Live grep
	map("n", leader .. "fb", ":Telescope buffers<CR>", opts) -- Find buffers
	map("n", leader .. "fh", ":Telescope help_tags<CR>", opts) -- Help tags
	map("n", leader .. "fr", ":Telescope oldfiles<CR>", opts) -- Recent files
	map("n", leader .. "fm", ":Telescope media_files<CR>", opts) -- Find media files
	map("n", leader .. "fi", ":!feh <cfile><CR>", opts) -- Open image with feh
	map("n", leader .. "fv", ":!mpv <cfile><CR>", opts) -- Open video with mpv

-- Mason management
map("n", leader .. "mm", ":Mason<CR>", opts)         -- Open Mason
map("n", leader .. "ml", ":MasonLog<CR>", opts)      -- Mason log
map("n", leader .. "mu", ":MasonUpdate<CR>", opts)   -- Update Mason packages

-- LSP keybindings
map("n", "gd", vim.lsp.buf.definition, opts)        -- Go to definition
map("n", "gr", vim.lsp.buf.references, opts)        -- Go to references
map("n", "gi", vim.lsp.buf.implementation, opts)    -- Go to implementation
map("n", "K", vim.lsp.buf.hover, opts)              -- Hover documentation
map("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Signature help

-- Code actions
map("n", leader .. "ca", vim.lsp.buf.code_action, opts) -- Code actions
map("n", leader .. "rn", vim.lsp.buf.rename, opts)   -- Rename symbol
map("n", leader .. "f", vim.lsp.buf.format, opts)    -- Format code

-- Git integration
map("n", leader .. "gs", ":Git<CR>", opts)           -- Git status
map("n", leader .. "gc", ":Git commit<CR>", opts)    -- Git commit
map("n", leader .. "gp", ":Git push<CR>", opts)      -- Git push
map("n", leader .. "gl", ":Git log<CR>", opts)       -- Git log

-- Quick save and quit
map("n", leader .. "w", ":w<CR>", opts)              -- Save file
map("n", leader .. "q", ":q<CR>", opts)              -- Quit
map("n", leader .. "wq", ":wq<CR>", opts)            -- Save and quit

-- Dashboard navigation
map("n", leader .. "dd", ":Dashboard<CR>", opts)      -- Return to dashboard

-- Search and replace
map("n", leader .. "s", ":%s/", opts)                -- Search and replace
map("n", "n", "nzzzv", opts)                        -- Center search results
map("n", "N", "Nzzzv", opts)                        -- Center search results

-- Indentation
map("v", "<", "<gv", opts)                          -- Indent left
map("v", ">", ">gv", opts)                          -- Indent right

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)            -- Move line down
map("n", "<A-k>", ":m .-2<CR>==", opts)            -- Move line up
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)        -- Move line down (visual)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)        -- Move line up (visual)

-- Center cursor
map("n", "zz", "zz", opts)                          -- Center cursor
map("n", "zt", "zt", opts)                          -- Top of screen
map("n", "zb", "zb", opts)                          -- Bottom of screen

-- Quick navigation
map("n", "j", "gj", opts)                           -- Move down (wrapped)
map("n", "k", "gk", opts)                           -- Move up (wrapped)
map("v", "j", "gj", opts)                           -- Move down (wrapped, visual)
map("v", "k", "gk", opts)                           -- Move up (wrapped, visual)

-- Escape in terminal mode
map("t", "<Esc>", "<C-\\><C-n>", opts)              -- Escape terminal mode

-- Window layout presets
map("n", leader .. "wl", function()
	-- Layout: File explorer (left), Editor (center), Terminal (right)
	vim.cmd("NvimTreeOpen")
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
	vim.cmd("terminal")
	
	-- Immediately set buffer options to hide from buffer tabs
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
	vim.cmd("file RightTerminal")
	vim.cmd("startinsert")
	vim.cmd("wincmd h")
	vim.cmd("wincmd h")
end, opts)

-- Toggle between layouts
map("n", leader .. "wt", function()
	-- Toggle between different window layouts
	local current_layout = vim.g.current_layout or "default"
	if current_layout == "default" then
		vim.cmd("NvimTreeClose")
		vim.cmd("wincmd l")
		vim.cmd("wincmd c")
		vim.g.current_layout = "editor_only"
	else
		vim.cmd("NvimTreeOpen")
		vim.cmd("vsplit")
		vim.cmd("wincmd l")
		vim.cmd("terminal")
		
		-- Immediately set buffer options to hide from buffer tabs
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
		vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)
		vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
		vim.cmd("file RightTerminal")
		vim.cmd("startinsert")
		vim.cmd("wincmd h")
		vim.cmd("wincmd h")
		vim.g.current_layout = "default"
	end
end, opts)

-- Quick window resizing presets
map("n", leader .. "wr", function()
	-- Reset window sizes to default
	vim.cmd("wincmd =")
end, opts)

-- Focus management
map("n", leader .. "1", ":1wincmd w<CR>", opts)     -- Focus window 1
map("n", leader .. "2", ":2wincmd w<CR>", opts)     -- Focus window 2
map("n", leader .. "3", ":3wincmd w<CR>", opts)     -- Focus window 3
map("n", leader .. "4", ":4wincmd w<CR>", opts)     -- Focus window 4

-- Print current layout info
map("n", leader .. "li", function()
	print("Current layout: " .. (vim.g.current_layout or "default"))
	print("Window count: " .. vim.fn.winnr("$"))
end, opts) 

-- Mouse-friendly window management
map("n", "<C-Left>", "<C-w>h", opts)      -- Navigate left
map("n", "<C-Right>", "<C-w>l", opts)     -- Navigate right
map("n", "<C-Up>", "<C-w>k", opts)        -- Navigate up
map("n", "<C-Down>", "<C-w>j", opts)      -- Navigate down

-- Mouse-friendly resizing
map("n", "<C-S-Left>", "<C-w><", opts)    -- Resize left
map("n", "<C-S-Right>", "<C-w>>", opts)   -- Resize right
map("n", "<C-S-Up>", "<C-w>+", opts)      -- Resize up
map("n", "<C-S-Down>", "<C-w>-", opts)    -- Resize down 

-- Perfect three-panel layout with both terminals
map("n", leader .. "wl", function()
	-- First, ensure we have the right layout
	local win_count = vim.fn.winnr("$")
	
	-- If we have more than 3 windows, close extras
	while win_count > 3 do
		vim.cmd("wincmd c")
		win_count = vim.fn.winnr("$")
	end
	
	-- If we have less than 3 windows, create them
	if win_count < 3 then
		-- Create right terminal if needed
		vim.cmd("vsplit")
		vim.cmd("wincmd l")
		vim.cmd("terminal")
		
		-- Immediately set buffer options to hide from buffer tabs
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
		vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)
		vim.api.nvim_buf_set_option(buf, "filetype", "terminal")
		vim.cmd("file RightTerminal")
		
		-- Create bottom terminal if needed
		vim.cmd("split")
		vim.cmd("wincmd j")
		vim.cmd("terminal")
		
		-- Immediately set buffer options to hide from buffer tabs
		local buf2 = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf2, "buftype", "terminal")
		vim.api.nvim_buf_set_option(buf2, "bufhidden", "hide")
		vim.api.nvim_buf_set_option(buf2, "swapfile", false)
		vim.api.nvim_buf_set_option(buf2, "filetype", "terminal")
		vim.cmd("file BottomTerminal")
	end
	
	-- Set window sizes for perfect layout
	vim.cmd("wincmd h")  -- Go to left (file explorer)
	vim.cmd("vertical resize 30")
	
	vim.cmd("wincmd l")  -- Go to center (editor)
	vim.cmd("vertical resize 40")
	
	vim.cmd("wincmd h")  -- Back to left
	vim.cmd("wincmd j")  -- Go to bottom terminal
	vim.cmd("resize 20")
	
	-- Focus the editor
	vim.cmd("wincmd k")
	vim.cmd("wincmd l")
	
	print("✨ Perfect three-panel layout set up!")
end, opts) 

 