--[[
 * Dashboard Configuration.
 *
 * Uses dashboard-nvim with custom ASCII art.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

Add("nvimdev/dashboard-nvim")

-- ASCII art header
local custom_header = {
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠤⠔⠀⠁⠲⠤⣤⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠁⠀⢁⠂⠄⡠⠀⠠⢁⠡⠀⢍⠢⣀⠀⠜⢢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠸⢦⠄⠀⣠⠊⠁⠀⣰⠄⡀⠙⠋⠳⠀⠁⠀⠠⣀⠠⢈⠊⠳⡄⡺⠖⠊⢹⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠙⡶⠁⡴⠂⡰⠃⢈⡆⠀⠇⠂⢸⠀⠀⠡⡈⢧⠀⠘⠒⠚⡥⠀⠀⣸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⣠⠔⠓⠳⣀⡼⢁⡜⠀⡰⠁⠀⣼⠀⢈⠀⠄⠈⡇⠀⠀⢱⠘⣷⠀⠈⡼⢻⡀⠰⠿⣟⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠗⡄⠀⣸⠁⣼⡠⢲⠃⠀⢠⡇⠈⢀⠂⠀⠈⣇⢰⠀⠈⢆⠐⢣⢰⠁⣸⡷⣄⣀⣈⠾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⣰⢀⠟⠁⣇⠸⠇⡀⢏⡇⢰⡏⡇⠀⠀⠀⡀⢠⠟⣌⣄⠀⢸⠆⠌⡇⣇⢸⣿⠈⢿⠤⠇⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⡟⡧⣤⢖⡇⢸⠀⠰⣸⠠⡞⠒⢳⢈⠓⠙⠠⡸⠀⠹⡿⡌⠉⡇⢂⠹⢸⣹⡿⣿⠾⣹⢰⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢀⣧⡶⠇⠈⣷⢸⠀⢱⢋⣞⣀⡀⠈⢫⡀⠀⢣⡀⠀⣠⣿⣷⣦⣆⢸⣻⣎⢹⡇⠙⢽⣔⠂⠘⠆⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⡺⠁⠀⣼⠷⣿⡴⠈⢰⣿⢿⣿⣿⣧⠀⠱⠀⠀⠀⠀⣿⣿⣿⠏⢻⣾⠿⢷⣾⢁⣀⣀⠉⡿⣘⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢀⠔⠀⠀⡘⠋⠀⢺⡇⠹⣾⣏⠀⢿⠛⠿⠀⠀⠀⠀⠀⠀⠑⠠⠚⠀⣼⠃⠀⢨⢻⣸⣉⣻⠀⠃⢈⣦⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠐⢏⢠⢴⢹⠳⣤⣠⣾⢷⠀⠸⣿⡄⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠠⢋⣤⡴⡏⣟⣈⡜⠁⠐⠾⠛⡬⠂⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠈⢹⢸⠀⣿⣽⣟⢺⡄⡂⣿⡟⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⣿⠋⡷⢀⡟⠤⡟⣄⣠⠞⣦⡰⡄⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢠⠿⠀⢸⡟⣼⠂⢸⣇⢡⠸⡿⠇⠁⠠⢀⡀⠀⠀⠀⣀⠤⡶⠁⢈⣿⠟⢅⢸⠃⣶⠭⣈⣷⠈⣇⠈⠃⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⡀⢰⢮⠀⣿⠙⣾⠀⡞⣼⢌⢷⡱⢄⡀⠀⠠⠘⡌⠉⠁⢀⠔⣓⣀⠜⠃⠀⢀⡝⢠⡏⣷⡂⢼⣶⡘⢄⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢁⡿⠉⣼⠃⣸⢏⡼⠁⣿⡆⠙⠊⠳⠤⠄⠀⡰⢣⡤⣂⡥⠒⠙⡄⠀⠀⠀⡾⠸⣼⡇⢡⢻⡐⣯⣹⡪⢦⡀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⡜⠀⢸⠃⠈⡎⢋⡄⣼⣧⢹⠀⠀⠀⢀⠠⠊⠀⠀⢠⠿⡄⠀⠀⠈⠐⠄⣀⢧⠸⣟⣧⠀⢧⢱⠘⢧⣟⢄⠳⡄⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⣸⡇⢰⠇⠀⡈⠀⡿⠀⣾⡷⠾⠰⠶⡎⢀⠀⠀⠀⣀⣿⣀⣾⠀⠀⠈⠀⠀⣀⡹⠏⠉⠉⢇⠀⠹⣷⠀⠷⡀⢇⢸⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⢰⣇⠗⠁⠀⠀⠀⣼⣧⡾⡡⠀⠀⠀⠑⢌⠒⢴⣲⠀⢠⣾⠛⣻⣄⡀⢠⡔⠝⠁⠀⠀⠀⠀⠀⢡⠀⠙⠷⣀⠑⢤⣛⡇⠀⠀⠀⠀",
  "",
}

local opts = {
    theme = "doom",
    hide = {
        statusline = false,
    },
    config = {
        header = custom_header,
        center = {
            {action = 'Telescope find_files', desc = " Find File", key = "f"},
            {action = "ene | startinsert", desc = " New File", key = "n"},
            {action = 'Telescope live_grep', desc = " Find Text", key = "g"},
            {action = 'Telescope oldfiles', desc = " Recent Files", key = "r"},
            {action = 'e ~/.config/nvim/init.lua', desc = " Config", key = "c"},
            {action = function() vim.api.nvim_input("qa") end, desc = " Quit", key = "q"},
        },
        footer = function()
            return {"⚡ Neovim loaded (mini.deps)"}
        end,
    },
}

-- Format buttons
for _, button in ipairs(opts.config.center) do
    button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
    button.key_format = " %s"
end

require("dashboard").setup(opts)

-- Explicit Keymaps for Dashboard
vim.keymap.set("n", "<leader>dd", "<cmd>Dashboard<cr>", { desc = "Dashboard" })
vim.keymap.set("n", "<leader>dh", "<cmd>Dashboard<cr>", { desc = "Home Dashboard" })
