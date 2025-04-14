-- Load leader keys first
require("core.leader")

-- Load core modules
require("core.options")
require("core.keymaps")
require("core.lazy")

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable filetype detection and loading
vim.cmd("filetype plugin indent on")

-- Set up basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.hlsearch = true
vim.opt.incsearch = true 