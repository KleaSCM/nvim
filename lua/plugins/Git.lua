--[[
 * Git Configuration.
 *
 * Includes Neogit, Diffview, Advanced Git Search.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("NeogitOrg/neogit")
Add("sindrets/diffview.nvim")
Add("nvim-lua/plenary.nvim")
Add("aaronhallaert/advanced-git-search.nvim")
Add("tpope/vim-fugitive") 
Add("tpope/vim-rhubarb")

Later(function()
    require("neogit").setup({})
    require("diffview").setup({})
    
    -- Load telescope extension
    -- We assume Telescope is loaded by now or will be
    local ok, telescope = pcall(require, "telescope")
    if ok then
        pcall(telescope.load_extension, "advanced_git_search")
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
    vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
    vim.keymap.set("n", "<leader>gs", "<cmd>Telescope advanced_git_search<cr>", { desc = "Git Search" })
    vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
end)
