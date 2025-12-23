--[[
 * AI Configuration.
 *
 * CodeCompanion & Copilot.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("zbirenbaum/copilot.lua")
Add("nvim-lua/plenary.nvim") -- Dependency
Add("olimorris/codecompanion.nvim")

Later(function()
    require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
    })

    require("codecompanion").setup({
        strategies = {
            chat = { adapter = "copilot" },
            inline = { adapter = "copilot" },
            agent = { adapter = "copilot" },
        },
    })
    
    -- AI Keymaps matching user recall
    -- Leader c group
    vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "AI Chat" })
    vim.keymap.set("n", "<leader>ci", "<cmd>CodeCompanionInline<cr>", { desc = "AI Inline" })
    vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
    -- Also mapping leader a for compatibility
    vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<cr>", { desc = "AI Chat" })
end)
