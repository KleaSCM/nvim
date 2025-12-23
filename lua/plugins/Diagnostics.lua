--[[
 * Diagnostics Configuration.
 *
 * "Violent and Screaming" edition as requested.
 * Includes flashing errors, red backgrounds, and Trouble.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("folke/trouble.nvim")

Later(function()
    require("trouble").setup({
         icons = {
            error = "🚨",
            warning = "⚠️",
            hint = "💡",
        },
        signs = {
            error = "🚨",
            warning = "⚠️",
        },
    })
    
    -- Diagnostic Config
    vim.diagnostic.config({
        underline = true,
        update_in_insert = true, -- Scream while typing
        severity_sort = true,
        virtual_text = {
            spacing = 4,
            prefix = "●",
            source = "if_many",
        },
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "🔥 DIAGNOSTICS 🔥",
            prefix = "",
        },
        signs = true,
    })

    -- Highlight Overrides (Violent Red)
    local function set_hl()
          vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff0000", bg = "#330000", bold = true, standout = true })
          vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffa500", bg = "#332200", bold = true, standout = true })
          vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = "#ff0000", undercurl = true, bold = true })
          vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff0000", bg = "#330000", bold = true })
    end
    set_hl()
    
    -- Re-apply on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_hl,
    })

    -- Auto-open float on cursor hover
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
             local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end)
