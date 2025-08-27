--[[
 * 自動コマンド設定モジュール
 * 
 * このモジュールは自動的な動作とユーザー体験向上のための
 * 様々な自動コマンドを定義します。
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: autocmds.lua
 * Description: 自動コマンドと自動動作の設定
--]]

local api = vim.api

-- 自動コマンドグループを作成
local group = api.nvim_create_augroup("CursorNeovim", { clear = true })

-- ターミナルリサイズ時にウィンドウを自動調整
-- 理由: ターミナルサイズ変更後もレイアウトを維持するため
api.nvim_create_autocmd("VimResized", {
	group = group,
	command = "wincmd =",
})

-- NvimTreeが最後のウィンドウになったら自動で閉じる
-- 理由: ファイルツリーだけが残ってしまう状況を防ぐため
api.nvim_create_autocmd("BufEnter", {
	group = group,
	nested = true,
	callback = function()
		local is_ntree = vim.fn.bufname(vim.fn.bufnr()) == "NvimTree_" .. vim.fn.tabpagenr()
		if is_ntree and vim.fn.winnr("$") == 1 then
			vim.cmd("quit")
		end
	end,
})

-- サポートされているファイルタイプで保存時に自動フォーマット
-- 理由: コードの一貫性を保ち、手動フォーマットの手間を省くため
api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.yaml", "*.yml" },
	callback = function()
		if vim.fn.exists(":Format") == 2 then
			vim.cmd("Format")
		elseif vim.fn.exists(":lua vim.lsp.buf.format()") == 2 then
			vim.lsp.buf.format()
		end
	end,
})

-- クイックフィックスとロケーションリストを離れる時に自動で閉じる
-- 理由: 画面が散らかるのを防ぎ、作業フローをスムーズにするため
api.nvim_create_autocmd("WinLeave", {
	group = group,
	pattern = "*",
	callback = function()
		local win_info = vim.fn.getwininfo(vim.fn.winnr())
		if win_info and #win_info > 0 and win_info[1] then
			if win_info[1].quickfix == 1 then
				vim.cmd("cclose")
			end
			if win_info[1].loclist == 1 then
				vim.cmd("lclose")
			end
		end
	end,
})

-- ヤンク時にハイライト表示
-- 理由: コピーした範囲を視覚的に確認できるようにするため
api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- 挿入モードを離れる時に自動保存（オプション）
-- 理由: 作業の途中でデータを失うリスクを減らすため
api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd("silent! write")
		end
	end,
})

-- ヘルプウィンドウを離れる時に自動で閉じる
-- 理由: ヘルプが画面に残り続けるのを防ぐため
api.nvim_create_autocmd("BufLeave", {
	group = group,
	pattern = "*help*",
	command = "quit",
})

-- 挿入モードでカーソルラインを非表示
-- 理由: 挿入時の視認性を向上させるため
api.nvim_create_autocmd("InsertEnter", {
	group = group,
	pattern = "*",
	command = "set nocursorline",
})

-- 全モードで診断を常に表示
-- 理由: エラーや警告を常に確認できるようにするため
api.nvim_create_autocmd("ModeChanged", {
	group = group,
	pattern = "*",
	callback = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})
	end,
})

-- 挿入モードを離れる時にカーソルラインを表示
-- 理由: 通常モードでの位置確認を容易にするため
api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	command = "set cursorline",
})

-- 挿入モードで絶対行番号に切り替え
-- 理由: 挿入時の正確な位置把握を容易にするため
api.nvim_create_autocmd("InsertEnter", {
	group = group,
	pattern = "*",
	command = "set norelativenumber",
})

-- 挿入モードを離れる時に相対行番号に戻す
-- 理由: 通常モードでのナビゲーション効率を向上させるため
api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	command = "set relativenumber",
})

-- ディレクトリを開く時にNvimTreeを自動で開き、undoディレクトリを作成
-- 理由: ディレクトリ作業の効率化とundo履歴の永続化のため
api.nvim_create_autocmd("VimEnter", {
	group = group,
	pattern = "*",
	callback = function()
		-- undoディレクトリを作成
		local undo_dir = vim.fn.stdpath("data") .. "/undodir"
		if vim.fn.isdirectory(undo_dir) == 0 then
			vim.fn.mkdir(undo_dir, "p")
		end
		
		-- ディレクトリを開く時にNvimTreeを開く
		local argv0 = vim.fn.argv(0)
		if argv0 and argv0 ~= "" and vim.fn.isdirectory(argv0) == 1 then
			vim.cmd("NvimTreeOpen")
			vim.cmd("wincmd l")
		end
		
		-- 利用可能な場合はセッションを復元
		if vim.fn.argc() == 0 and vim.fn.filereadable("~/.vim/session.vim") == 1 then
			vim.cmd("source ~/.vim/session.vim")
		end
	end,
})

-- 診断表示の設定
-- 理由: エラーや警告を目立たせ、開発効率を向上させるため
api.nvim_create_autocmd("VimEnter", {
	group = group,
	pattern = "*",
	callback = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			
			virtual_text = {
				spacing = 4,
				prefix = "",
				source = "if_many",
				format = function(diagnostic)
					local icons = {
						[1] = "💥",
						[2] = "⚠️",
						[3] = "💡",
						[4] = "💭",
					}
					return icons[diagnostic.severity] .. " " .. diagnostic.message
				end,
			},
			
			signs = {
				active = true,
				values = {
					{ name = "DiagnosticSignError", text = "💥💥💥", texthl = "DiagnosticSignError" },
					{ name = "DiagnosticSignWarn", text = "⚠️⚠️⚠️", texthl = "DiagnosticSignWarn" },
					{ name = "DiagnosticSignHint", text = "💡", texthl = "DiagnosticSignHint" },
					{ name = "DiagnosticSignInfo", text = "💭", texthl = "DiagnosticSignHint" },
				},
			},
			
			underline = {
				severity = { min = vim.diagnostic.severity.HINT },
			},
		})
		
		-- 診断サインのハイライト設定
		vim.api.nvim_set_hl(0, "DiagnosticError", {
			fg = "#ff0000",
			bg = "#000000",
			sp = "#ff0000",
			bold = true,
			underline = true,
			italic = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticWarn", {
			fg = "#ff8800",
			bg = "#000000",
			sp = "#ff8800",
			bold = true,
			underline = true,
			italic = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticInfo", {
			fg = "#00ff00",
			bg = "#000000",
			sp = "#00ff00",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticHint", {
			fg = "#0088ff",
			bg = "#000000",
			sp = "#0088ff",
			bold = true,
		})
		
		-- 診断サインのハイライト設定
		vim.api.nvim_set_hl(0, "DiagnosticSignError", {
			fg = "#ff0000",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", {
			fg = "#ff8800",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", {
			fg = "#00ff00",
			bg = "#000000",
			bold = true,
		})
		
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", {
			fg = "#0088ff",
			bg = "#000000",
			bold = true,
		})
	end,
})

-- ターミナルバッファの自動設定
-- 理由: ターミナルバッファを適切に管理し、バッファタブから隠すため
api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "*",
	callback = function()
		-- バッファオプションを設定してバッファタブから隠す
		vim.bo.buftype = "terminal"
		vim.bo.bufhidden = "hide"
		vim.bo.swapfile = false
		vim.bo.filetype = "terminal"
		
		-- 一意の名前がない場合は生成
		local buf_name = vim.api.nvim_buf_get_name(0)
		if buf_name == "" or buf_name:match("^term://") then
			local buf_type = vim.bo.buftype
			if buf_type == "terminal" then
				-- タイムスタンプとランダム値で一意の名前を生成
				local timestamp = os.time()
				local unique_name = "Terminal_" .. timestamp .. "_" .. math.random(1000, 9999)
				
				-- エラーを避けるためにpcallで安全にリネーム
				local ok, _ = pcall(vim.cmd, "file " .. unique_name)
				if not ok then
					pcall(vim.cmd, "file Terminal_" .. timestamp)
				end
			end
		end
	end,
})

-- ターミナルのジョブ終了時に安全に閉じる
-- 理由: エラーを避け、適切なバッファ管理を行うため
api.nvim_create_autocmd("TermClose", {
	group = group,
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if vim.api.nvim_buf_is_valid(buf) then
			-- エラーを避けるためにpcallで安全に閉じる
			local ok, _ = pcall(vim.api.nvim_buf_delete, buf, { force = false })
			if not ok then
				-- 削除に失敗した場合は隠すだけ
				vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
			end
		end
	end,
})

-- Telescopeのターミナルプレビューを適切に処理
-- 理由: プレビュー機能の安定性を向上させ、エラーを防ぐため
api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local buf_name = vim.api.nvim_buf_get_name(buf)
		
		-- Telescopeのターミナルプレビューかチェック
		if buf_name:match("^Telescope") or buf_name:match("^term://.*telescope") then
			-- Telescopeターミナルのオプションを設定
			vim.bo.buftype = "terminal"
			vim.bo.bufhidden = "hide"
			vim.bo.swapfile = false
			vim.bo.filetype = "terminal"
			
			-- 競合を避けるために一意の名前を生成
			local timestamp = os.time()
			local unique_name = "TelescopeTerminal_" .. timestamp .. "_" .. math.random(1000, 9999)
			
			-- エラーを避けるためにpcallで安全にリネーム
			local ok, _ = pcall(vim.cmd, "file " .. unique_name)
			if not ok then
				pcall(vim.cmd, "file TelescopeTerminal_" .. timestamp)
			end
		end
	end,
})

-- 一時バッファの自動クリーンアップ
-- 理由: システムバッファの保護とメモリ管理の最適化のため
api.nvim_create_autocmd("BufHidden", {
	group = group,
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local buf_name = vim.api.nvim_buf_get_name(buf)
		local buf_type = vim.bo.buftype
		local buf_listed = vim.bo.buflisted
		
		-- 重要なシステムバッファはスキップ
		if buf_name:match("^Lualine") or 
		   buf_name:match("^Telescope") or
		   buf_name:match("^Neo%-tree") or
		   buf_name:match("^Trouble") or
		   buf_name:match("^Mason") or
		   buf_name:match("^Lazy") or
		   buf_name:match("^Terminal_") or
		   buf_name:match("^term://") then
			return
		end
		
		-- 真に一時的でリストされていないバッファのみ削除
		if buf_type == "nofile" and not buf_listed then
			-- バッファが有効で使用中でないかチェック
			if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "modifiable") then
				-- エラーを避けるためにpcallで安全に削除
				local ok, _ = pcall(vim.api.nvim_buf_delete, buf, { force = false })
				if not ok then
					-- 削除に失敗した場合は隠すだけ
					vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
				end
			end
		end
	end,
})

-- 特定のパターンのファイルタイプを自動設定
-- 理由: 適切なシンタックスハイライトと機能を提供するため
api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.conf",
	command = "set filetype=conf",
})

api.nvim_create_autocmd("BufRead", {
	group = group,
	pattern = "*.conf",
	command = "set filetype=conf",
})

api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.env*",
	command = "set filetype=sh",
})

api.nvim_create_autocmd("BufRead", {
	group = group,
	pattern = "*.env*",
	command = "set filetype=sh",
})

-- セッションの自動保存
-- 理由: 作業環境の状態を保持し、次回起動時に復元できるようにするため
api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	pattern = "*",
	command = "mksession! ~/.vim/session.vim",
}) 