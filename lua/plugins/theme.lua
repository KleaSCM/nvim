return {
	-- LazyVim colorscheme configuration
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "rose-pine-moon",
		},
	},

	-- Rose Pine theme - beautiful feminine dark theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				extend_background_behind_borders = true,
			})
		end,
	},
}