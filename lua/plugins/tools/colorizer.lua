--[[
 * Colorizer plugin configuration.
 * 
 * Shows actual colors for color codes in your files.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/colorizer.lua
 * Description: Color highlighting for color codes
--]]

return {
	-- NvChad colorizer - Beautiful color highlighting
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- あたし、カラーライザーを美しくしたの…色が美しく表示されるように（╹◡╹）
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { css = true, css_fn = true },
					html = { css = true, css_fn = true },
					javascript = { css = true, css_fn = true },
					typescript = { css = true, css_fn = true },
					typescriptreact = { css = true, css_fn = true },
					javascriptreact = { css = true, css_fn = true },
					lua = { css = true, css_fn = true },
					rust = { css = true, css_fn = true },
					go = { css = true, css_fn = true },
					c = { css = true, css_fn = true },
					cpp = { css = true, css_fn = true },
					python = { css = true, css_fn = true },
					markdown = { css = true, css_fn = true },
					yaml = { css = true, css_fn = true },
					json = { css = true, css_fn = true },
					toml = { css = true, css_fn = true },
					sh = { css = true, css_fn = true },
					zsh = { css = true, css_fn = true },
				},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
					mode = "background",
					tailwind = true,
					sass = { enable = true, parsers = { css } },
					virtualtext = "■",
					always_update = true,
				},
				buftypes = {},
			})
		end,
	},
} 