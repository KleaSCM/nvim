--[[
 * Terminal Configuration.
 *
 * Uses ToggleTerm.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("akinsho/toggleterm.nvim")

Later(function()
    require("toggleterm").setup({
        size = 60, -- Window width
        open_mapping = [[<c-\>]], 
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        direction = "vertical", -- DOCKED (Vertical split)
        float_opts = { border = "curved" },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

    function _G._lazygit_toggle() lazygit:toggle() end

    -- Keymaps
    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm size=60 direction=vertical<cr>", { desc = "Toggle Terminal (Right)" })
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "Horizontal Terminal" })
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", { desc = "Vertical Terminal" })
    vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Lazygit" })
end)
