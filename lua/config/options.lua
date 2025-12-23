-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Set colorscheme after everything loads
vim.defer_fn(function()
	vim.cmd("colorscheme rose-pine-moon")
end, 100)
