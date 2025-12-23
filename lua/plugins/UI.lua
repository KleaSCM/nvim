--[[
 * UI Configuration.
 *
 * Includes Lualine, Noice, Notify.
 *
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

-- Dependencies
Add("MunifTanjim/nui.nvim")
Add("rcarriga/nvim-notify")

-- Noice (Command, Messages, Popupmenu)
Add("folke/noice.nvim")

-- Lualine (Statusline)
Add("nvim-lualine/lualine.nvim")
Add("nvim-tree/nvim-web-devicons") -- Icon dependency

Later(function()
    require("notify").setup({
        background_colour = "#000000",
    })

    require("lualine").setup({
        options = {
            theme = "auto", -- Should pick up Rose Pine automatically
            globalstatus = true,
        },
    })
    
    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        -- Filter out annoying messages here
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "require%('lspconfig'%)",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "notify",
                    find = "require%('lspconfig'%)",
                },
                opts = { skip = true },
            },
        },
    })
end)
