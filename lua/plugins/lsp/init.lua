--[[
 * LSP plugins configuration.
 * 
 * This file contains all LSP-related plugins including Mason,
 * language server configuration, and code completion.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: lsp/init.lua
 * Description: LSP plugins configuration
--]]

return {
	-- Mason for LSP, formatters, and linters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason LSP config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"gopls",
					"rust_analyzer",
					"clangd",
					"jsonls",
					"yamlls",
					"marksman",
					"bashls",
					"html",
					"cssls",
					"emmet_ls",
				},
				automatic_installation = true,
			})
		end,
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- あたし、LSPサーバーの設定を追加したの…エラーが出ちゃうから（╹◡╹）
			local lspconfig = require("lspconfig")
			
			-- Global LSP configuration
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
			
			-- LSP keybindings that work globally
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
			
			-- LSP event handlers
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf
					
					-- あたし、LSPの設定を改善したの…ホバーと定義が正しく動作するように（╹◡╹）
					if client.server_capabilities.hoverProvider then
						vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, noremap = true, silent = true })
					end
					
					if client.server_capabilities.definitionProvider then
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, noremap = true, silent = true })
					end
					
					if client.server_capabilities.referencesProvider then
						vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, noremap = true, silent = true })
					end
					
					if client.server_capabilities.renameProvider then
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, noremap = true, silent = true })
					end
					
					if client.server_capabilities.codeActionProvider then
						vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, silent = true })
					end
				end,
			})
			
			-- Configure TypeScript/JavaScript LSP with enhanced features
			lspconfig.ts_ls.setup({
				on_attach = function(client, bufnr)
					-- あたし、TypeScript LSPの設定を改善したの…TS開発が最高になるように（╹◡╹）
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					
					-- TypeScript specific keybindings
					vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>gs", vim.lsp.buf.document_symbol, bufopts)
					vim.keymap.set("n", "<leader>gw", vim.lsp.buf.workspace_symbol, bufopts)
					vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, bufopts)
					vim.keymap.set("n", "<leader>go", vim.lsp.buf.code_action, bufopts)
					
					-- Debug LSP connection
					vim.notify("TypeScript LSP attached to buffer " .. bufnr, vim.log.levels.INFO)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- Enhanced TypeScript LSP settings
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
						format = {
							indentSize = 2,
							convertTabsToSpaces = true,
							tabSize = 2,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
						},
						format = {
							indentSize = 2,
							convertTabsToSpaces = true,
							tabSize = 2,
						},
					},
				},
				-- Ensure server starts properly
				autostart = true,
				flags = {
					debounce_text_changes = 150,
				},
			})
			
			-- Configure Lua LSP
			lspconfig.lua_ls.setup({
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			
			-- Configure HTML LSP
			lspconfig.html.setup({
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			
			-- Configure CSS LSP
			lspconfig.cssls.setup({
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			
			-- Configure Emmet LSP
			lspconfig.emmet_ls.setup({
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			
			-- Configure C++ LSP (clangd) with enhanced features
			lspconfig.clangd.setup({
				on_attach = function(client, bufnr)
					-- あたし、C++ LSPの設定を改善したの…C++開発が最高になるように（╹◡╹）
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					
					-- C++ specific keybindings
					vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>gs", vim.lsp.buf.document_symbol, bufopts)
					vim.keymap.set("n", "<leader>gw", vim.lsp.buf.workspace_symbol, bufopts)
					vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, bufopts)
					
					-- Debug LSP connection
					vim.notify("C++ LSP attached to buffer " .. bufnr, vim.log.levels.INFO)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- Enhanced C++ LSP settings
				settings = {
					clangd = {
						arguments = {
							"--background-index",
							"--clang-tidy",
							"--completion-style=detailed",
							"--fallback-style=Google",
							"--header-insertion=iwyu",
							"--suggest-missing-includes",
							"--all-scopes-completion",
							"--cross-file-rename",
							"--enable-config",
							"--function-arg-placeholders",
							"--pch-storage=memory",
							"--pretty",
							"--ranking-model=heuristics",
							"--strict-file-overview",
						},
						completion = {
							detailedLabel = true,
							triggerAfterInsertion = true,
						},
						diagnostics = {
							enable = true,
							clangTidy = true,
						},
						index = {
							background = true,
							external = {
								dir = vim.fn.expand("~/.cache/clangd"),
								changeThreshold = 1000,
							},
						},
					},
				},
				-- Ensure server starts properly
				autostart = true,
				flags = {
					debounce_text_changes = 150,
				},
			})
			
			-- Configure Rust LSP (rust-analyzer)
			lspconfig.rust_analyzer.setup({
				on_attach = function(client, bufnr)
					-- あたし、Rust LSPの設定を追加したの…rust-analyzerが動作するように（╹◡╹）
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					
					-- Rust-specific keybindings
					vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format, bufopts)
					vim.keymap.set("n", "<leader>ra", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})
			
			-- Configure Go LSP (gopls) with enhanced features
			lspconfig.gopls.setup({
				on_attach = function(client, bufnr)
					-- あたし、Go LSPの設定を改善したの…Go開発が最高になるように（╹◡╹）
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					
					-- Go-specific keybindings
					vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>gs", vim.lsp.buf.document_symbol, bufopts)
					vim.keymap.set("n", "<leader>gw", vim.lsp.buf.workspace_symbol, bufopts)
					
					-- Debug LSP connection
					vim.notify("Go LSP attached to buffer " .. bufnr, vim.log.levels.INFO)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- Enhanced Go LSP settings
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
							nilness = true,
							fieldalignment = true,
						},
						staticcheck = true,
						gofumpt = true,
						usePlaceholders = true,
						completionDocumentation = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						matcher = "fuzzy",
						symbolMatcher = "fuzzy",
						symbolStyle = "full",
						buildFlags = { "-tags=all" },
						env = {
							GOFLAGS = "-mod=mod",
						},
					},
				},
				-- Ensure server starts properly
				autostart = true,
				flags = {
					debounce_text_changes = 150,
				},
			})
			
			-- Configure Python LSP (pyright)
			lspconfig.pyright.setup({
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end,
	},
} 