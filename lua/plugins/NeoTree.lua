--[[
 * NeoTree Configuration.
 *
 * File Explorer.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("nvim-neo-tree/neo-tree.nvim")
Add("nvim-lua/plenary.nvim")
Add("MunifTanjim/nui.nvim")
Add("nvim-tree/nvim-web-devicons")

Later(function()
    require("neo-tree").setup({
        close_if_last_window = false,
        filesystem = {
            follow_current_file = { enabled = true },
            hijack_netrw_behavior = "open_default",
        },
    })
    
    -- Keymaps
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
    vim.keymap.set("n", "<leader>be", "<cmd>Neotree buffers<cr>", { desc = "Buffer Explorer" })
    vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status<cr>", { desc = "Git Explorer" })
end)
