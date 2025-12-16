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
      
      -- Replace the header content
      local starter = require("mini.starter")
      starter.config.header = ascii_art
      starter.refresh()
    end
  end,
})