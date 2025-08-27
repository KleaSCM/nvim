--[[
 * LSPプラグイン設定
 * 
 * このファイルはMason、言語サーバー設定、コード補完を含む
 * すべてのLSP関連プラグインを設定します。
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: lsp/init.lua
 * Description: LSPプラグイン設定
--]]

return {
	-- Mason configuration
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				-- あたし、MasonでRustツールを完全にセットアップしたの…プロフェッショナルな開発環境に（╹◡╹）
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✅",
						package_pending = "⏳",
						package_uninstalled = "❌",
					},
				},
				-- Essential Rust tools
				ensure_installed = {
					-- LSP servers
					"rust_analyzer",
					"lua_ls",
					"gopls",
					"clangd",
					"pyright",
					"ts_ls",
					
					-- Rust formatters and linters
					"rustfmt",
					"clippy",
					
					-- Debuggers
					"codelldb",
					
					-- Other essential tools
					"stylua",
					"prettier",
					"eslint_d",
					"gofumpt",
					"goimports",
					"clang-format",
					"cppcheck",
					"clang-tidy",
				},
				automatic_installation = true,
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
				-- 自動的にLSPサーバーを開始
				handlers = {
					-- デフォルトハンドラー
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					-- Lua LSPの特別な設定
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
								},
							},
						})
					end,
					-- TypeScript LSPの特別な設定
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							settings = {
								typescript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
									},
								},
								javascript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
									},
								},
							},
						})
					end,
				},
			})
			
			-- 手動でLSPサーバーを設定
			local lspconfig = require("lspconfig")
			
			-- Lua LSP設定
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})
			
			-- TypeScript LSP設定
			lspconfig.ts_ls.setup({
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})
			
			-- Go LSP設定
			lspconfig.gopls.setup({})
			
			-- C/C++ LSP設定
			lspconfig.clangd.setup({})
			
			-- Python LSP設定
			lspconfig.pyright.setup({})
			

			
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
			-- グローバルLSP設定
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
			
			-- LSPイベントハンドラー
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf
					
					-- LSPキーバインドを設定
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
					
					-- LSP接続を通知
					vim.notify("✅ LSP attached: " .. client.name .. " to buffer " .. bufnr, vim.log.levels.INFO)
				end,
			})
			
			-- LSPサーバーの状態を確認するコマンド
			vim.api.nvim_create_user_command("LSPInfo", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
				
				if #clients == 0 then
					vim.notify("❌ No LSP clients attached to current buffer", vim.log.levels.WARN)
					return
				end
				
				for _, client in ipairs(clients) do
					vim.notify("✅ LSP Client: " .. client.name .. " (ID: " .. client.id .. ")", vim.log.levels.INFO)
				end
			end, {})
		end,
	},
} 