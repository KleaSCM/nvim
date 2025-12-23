--[[
 * Telescope Configuration.
 *
 * Fuzzy Finder (De-LazyVim'd)
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("nvim-telescope/telescope.nvim")
Add("nvim-lua/plenary.nvim")

Later(function()
    require("telescope").setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            -- mappings = { ... } -- Add custom mappings later if needed
        },
    })
end)

-- Keymaps (Standard LazyVim-like)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })
