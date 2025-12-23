--[[
 * Core Options (De-LazyVim'd)
 *
 * Recreating sensible defaults explicitly.
 ]]

local opt = vim.opt

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true -- User likely wanted this default
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- Tabs/Indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Behavior
opt.clipboard = "unnamedplus" -- System clipboard
opt.mouse = "a"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 4
opt.sidescrolloff = 8

-- System
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
