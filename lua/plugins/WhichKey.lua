--[[
 * WhichKey Configuration.
 *
 * The "small window" for keybinds.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("folke/which-key.nvim")

Later(function()
    require("which-key").setup({
        plugins = {
            spelling = { enabled = true },
        },
    })
    
    -- Register Groups
    local wk = require("which-key")
    wk.add({
        { "<leader>f", group = "File" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code/AI" },
        { "<leader>t", group = "Terminal" },
        { "<leader>b", group = "Buffer" },
    })
end)
