local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Filetypes
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = true

-- List chars
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  extends = "›",
  precedes = "‹",
} 