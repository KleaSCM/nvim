-- Neovim Keymaps Configuration
-- This file contains all the keyboard shortcuts (keymaps) for Neovim
-- Keymaps make it easier to navigate and edit text in Neovim

-- First, we set up some basic variables
-- 'keymap' is a function that helps us create keyboard shortcuts
-- 'opts' stands for options, and we set two important ones:
--   - noremap: true (means the shortcut won't be remapped again)
--   - silent: true (means no messages will be shown when using the shortcut)
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===========================================
-- WINDOW NAVIGATION
-- ===========================================
-- In Neovim, you can split your screen into multiple windows
-- These shortcuts help you move between different windows
-- Think of it like moving between different panels in your editor

-- Move to the window on the LEFT
-- Press: Ctrl + h
keymap("n", "<C-h>", "<C-w>h", opts)

-- Move to the window BELOW
-- Press: Ctrl + j
keymap("n", "<C-j>", "<C-w>j", opts)

-- Move to the window ABOVE
-- Press: Ctrl + k
keymap("n", "<C-k>", "<C-w>k", opts)

-- Move to the window on the RIGHT
-- Press: Ctrl + l
keymap("n", "<C-l>", "<C-w>l", opts)

-- ===========================================
-- WINDOW RESIZING
-- ===========================================
-- These shortcuts help you make windows bigger or smaller
-- Like adjusting the size of panels in your editor

-- Make the current window SHORTER
-- Press: Ctrl + Up Arrow
keymap("n", "<C-Up>", ":resize -2<CR>", opts)

-- Make the current window TALLER
-- Press: Ctrl + Down Arrow
keymap("n", "<C-Down>", ":resize +2<CR>", opts)

-- Make the current window NARROWER
-- Press: Ctrl + Left Arrow
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Make the current window WIDER
-- Press: Ctrl + Right Arrow
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ===========================================
-- BUFFER NAVIGATION
-- ===========================================
-- Buffers are like open files in your editor
-- These shortcuts help you move between different open files

-- Go to the NEXT buffer (file)
-- Press: Shift + l
keymap("n", "<S-l>", ":bnext<CR>", opts)

-- Go to the PREVIOUS buffer (file)
-- Press: Shift + h
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- ===========================================
-- SEARCH
-- ===========================================
-- When you search for text, the matches are highlighted
-- This shortcut clears those highlights

-- Clear search highlights
-- Press: Leader key (usually \) + h
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- ===========================================
-- BUFFER MANAGEMENT
-- ===========================================
-- These shortcuts help you manage your open files

-- Close the current buffer (file)
-- Press: Shift + q
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- ===========================================
-- TEXT MANIPULATION
-- ===========================================
-- These shortcuts help you copy, paste, and move text

-- Better paste in visual mode (preserves what you copied)
-- Press: p (in visual mode)
keymap("v", "p", '"_dP', opts)

-- Move the selected text DOWN one line
-- Press: Alt + j (in visual mode)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)

-- Move the selected text UP one line
-- Press: Alt + k (in visual mode)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Move the selected text DOWN one line (alternative)
-- Press: J (in visual mode)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Move the selected text UP one line (alternative)
-- Press: K (in visual mode)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- ===========================================
-- INDENTATION
-- ===========================================
-- These shortcuts help you indent (add spaces at the start of lines)
-- while staying in visual mode

-- Indent the selected text to the LEFT
-- Press: < (in visual mode)
keymap("v", "<", "<gv", opts)

-- Indent the selected text to the RIGHT
-- Press: > (in visual mode)
keymap("v", ">", ">gv", opts)

-- ===========================================
-- TERMINAL
-- ===========================================
-- This shortcut helps you exit terminal mode

-- Exit terminal mode
-- Press: Ctrl + x
keymap("t", "<C-x>", "<C-\\><C-N>", opts)

-- ===========================================
-- FILE OPERATIONS
-- ===========================================
-- These shortcuts help you save your work

-- Save the current file
-- Press: Ctrl + s (works in both normal and insert mode)
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<cmd>w<CR>", opts)

-- ===========================================
-- QUIT NEOVIM
-- ===========================================
-- This shortcut helps you exit Neovim

-- Quit Neovim
-- Press: Ctrl + q
keymap("n", "<C-q>", "<cmd>q<CR>", opts)

-- ===========================================
-- TEXT SELECTION
-- ===========================================
-- This shortcut helps you select all text in a file

-- Select all text in the current file
-- Press: Ctrl + a
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- ===========================================
-- TAB MANAGEMENT
-- ===========================================
-- These shortcuts help you work with tabs
-- Tabs are like having multiple files open in different windows

-- Create a NEW tab
-- Press: te
keymap("n", "te", ":tabedit<CR>", opts)

-- Go to the NEXT tab
-- Press: Tab
keymap("n", "<tab>", ":tabnext<CR>", opts)

-- Go to the PREVIOUS tab
-- Press: Shift + Tab
keymap("n", "<S-tab>", ":tabprev<CR>", opts)

-- ===========================================
-- CONFIGURATION
-- ===========================================
-- This shortcut helps you quickly open this keymaps file

-- Open this keymaps configuration file
-- Press: Leader key (usually \) + kb
keymap("n", "<leader>kb", ":e ~/.config/nvim/lua/core/keymaps.lua<CR>", { desc = "Open keymaps file" }) 