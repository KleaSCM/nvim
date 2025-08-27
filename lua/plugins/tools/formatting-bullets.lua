--[[
 * Auto formatting and bullet support module.
 * 
 * Provides automatic formatting, bullet management, and text enhancement.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: tools/formatting-bullets.lua
 * Description: Auto formatting and bullet support
--]]

return {
	-- Auto formatting with conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "✨ Format Buffer",
			},
		},
		opts = {
			-- あたし、フォーマットを美しくしたの…コードが美しく整列されるように（╹◡╹）
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable auto format for certain filetypes
				local disable_filetypes = { "c", "cpp", "go" }
				return not vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype)
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				toml = { "prettier" },
				rust = { "rustfmt" },
				go = { "gofumpt", "goimports" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				python = { "black", "isort" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2", "-ci" },
				},
				prettier = {
					prepend_args = { "--tab-width", "4", "--use-tabs" },
				},
			},
		},
		init = function()
			-- あたし、フォーマットを自動的に適用したの…コードが美しく整列されるように（╹◡╹）
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},

	-- Beautiful bullet management
	{
		"dkarter/bullets.vim",
		ft = { "markdown", "text", "gitcommit", "scratch" },
		config = function()
			-- あたし、箇条書きを美しくしたの…リストが美しく表示されるように（╹◡╹）
			vim.g.bullets_enabled_file_types = {
				"markdown",
				"text",
				"gitcommit",
				"scratch",
			}
			
			vim.g.bullets_checkbox_markers = " .oOX"
			vim.g.bullets_mapping_leader = "<leader>l"
			vim.g.bullets_line_spacing = 1
			vim.g.bullets_align_line_prefix = 1
			vim.g.bullets_auto_indent_after_colon = 1
			vim.g.bullets_outline_levels = { "ROM", "ABC", "abc", "123", "iii" }
			vim.g.bullets_renumber_on_change = 1
			vim.g.bullets_max_nesting_level = 20
			vim.g.bullets_nested_keymaps = 1
			vim.g.bullets_auto_newline_after_colon = 1
			vim.g.bullets_trim_whitespace = 1
			vim.g.bullets_blank_lines_between_bullets = 1
			vim.g.bullets_insert_mappings = 1
			vim.g.bullets_delete_last_bullet_if_empty = 1
			vim.g.bullets_pad_right = 0
			vim.g.bullets_auto_newline_after_colon = 1
			vim.g.bullets_auto_newline_after_colon = 1
		end,
	},

	-- Enhanced text objects and formatting
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			-- あたし、テキストオブジェクトを美しくしたの…テキストが美しく編集されるように（╹◡╹）
			require("nvim-surround").setup({
				keymaps = {
					insert = "<C-g>s",
					insert_line = "<C-g>S",
					normal = "ys",
					normal_cur = "yss",
					normal_line = "yS",
					normal_cur_line = "ySS",
					visual = "S",
					visual_line = "gS",
					delete = "ds",
					change = "cs",
				},
				surrounds = {
					["l"] = {
						add = function()
							return { { "[" }, { "]" } }
						end,
						find = "%b[]",
						delete = "^%[().-()%]",
						change = {
							target = "^%[().-()%]",
							replacement = function()
								return { { "(" }, { ")" } }
							end,
						},
					},
					["r"] = {
						add = function()
							return { { "(" }, { ")" } }
						end,
						find = "%b()",
						delete = "^%(().-()%)",
						change = {
							target = "^%(().-()%)",
							replacement = function()
								return { { "[" }, { "]" } }
							end,
						},
					},
					["a"] = {
						add = function()
							return { { "<" }, { ">" } }
						end,
						find = "%b<>",
						delete = "^%<(.-%s*).-()%>",
						change = {
							target = "^%<(.-%s*).-()%>",
							replacement = function()
								return { { "(", { " " } }, { ")" } }
							end,
						},
					},
				},
			})
		end,
	},

	-- Auto pairs and brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			-- あたし、自動ペアを美しくしたの…括弧が美しく挿入されるように（╹◡╹）
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})
		end,
	},

	-- Comment management
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- あたし、コメントを美しくしたの…コメントが美しく管理されるように（╹◡╹）
			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = "<leader>cc",
					block = "<leader>cb",
				},
				opleader = {
					line = "<leader>c",
					block = "<leader>b",
				},
				extra = {
					above = "<leader>cO",
					below = "<leader>co",
					eol = "<leader>cA",
				},
				mappings = {
					basic = true,
					extra = true,
				},
				pre_hook = nil,
				post_hook = nil,
			})
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			-- あたし、インデントガイドを美しくしたの…コードが美しく整列されるように（╹◡╹）
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = true,
				char = "└",
				show_start = true,
				show_end = true,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
				},
			},
		},
	},
} 