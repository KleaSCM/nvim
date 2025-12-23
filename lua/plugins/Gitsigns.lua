--[[
 * Gitsigns Configuration.
 *
 * Signs, Blame, Hunks.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("lewis6991/gitsigns.nvim")

Later(function()
    require("gitsigns").setup({
        signs = {
           add = { text = "▎" },
           change = { text = "▎" },
           delete = { text = "" },
           topdelete = { text = "" },
           changedelete = { text = "▎" },
           -- feminine touch?
           -- add = { text = "🌸" }, -- User might like this, but sticking to standard first
        },
        current_line_blame = true, -- Enable inline blame ("shows my commits")
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 500,
            ignore_whitespace = false,
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
              vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end
    
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Prev Hunk")
            map("n", "<leader>gh", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Blame Line")
        end,
    })
end)
