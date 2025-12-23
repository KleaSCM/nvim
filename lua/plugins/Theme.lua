--[[
 * Theme Configuration.
 *
 * Sets up Rose Pine theme.
 *
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 ]]

local MiniDeps = require("mini.deps")
local Add = MiniDeps.add

Add({
    source = "rose-pine/neovim",
    name = "rose-pine"
})

require("rose-pine").setup({
    variant = "moon",
    dark_variant = "moon",
    extend_background_behind_borders = true,
})

vim.cmd("colorscheme rose-pine-moon")
