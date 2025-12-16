-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local extmarks = require("config.extmarks")

vim.keymap.set("n", "<leader>me", function()
	extmarks.toggle_at_cursor({virt_text={{" ⟶ note","Comment"}}, virt_text_pos="eol"})
end, {desc = "Toggle extmark at cursor (virt text)"})
