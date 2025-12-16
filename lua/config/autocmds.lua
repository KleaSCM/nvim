-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Replace LazyVim logo with ASCII girl after mini.starter loads
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterOpened",
  callback = function()    
    -- Read ASCII art from cutegirl.txt
    local ascii_art = {}
    local file = io.open(vim.fn.expand("~/.config/nvim/cutegirl.txt"), "r")
    if file then
      for line in file:lines() do
        table.insert(ascii_art, line)
      end
      file:close()
      
      -- Replace header content
      local starter = require("mini.starter")
      starter.config.header = ascii_art
      starter.refresh()
    end
  end,
}) 