--[[
 * LSP utility functions.
 * 
 * Provides language server operations, diagnostics, and LSP helpers.
 * 
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 * File: utils/lsp.lua
 * Description: LSP utilities
--]]

local M = {}

-- あたし、LSPユーティリティを美しくしたの…LSPが美しく動作するように（╹◡╹）

-- Check if LSP is attached to current buffer
function M.is_lsp_attached()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	return #clients > 0
end

-- Get LSP client names for current buffer
function M.get_lsp_clients()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	
	return names
end

-- Get LSP client by name
function M.get_lsp_client(name)
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	for _, client in ipairs(clients) do
		if client.name == name then
			return client
		end
	end
	
	return nil
end

-- Get all diagnostics for current buffer
function M.get_all_diagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	return vim.diagnostic.get(bufnr)
end

-- Get diagnostics by severity
function M.get_diagnostics_by_severity(severity)
	local bufnr = vim.api.nvim_get_current_buf()
	local all_diagnostics = vim.diagnostic.get(bufnr)
	
	local filtered = {}
	for _, diag in ipairs(all_diagnostics) do
		if diag.severity == severity then
			table.insert(filtered, diag)
		end
	end
	
	return filtered
end

-- Get error diagnostics
function M.get_error_diagnostics()
	return M.get_diagnostics_by_severity(vim.diagnostic.severity.ERROR)
end

-- Get warning diagnostics
function M.get_warning_diagnostics()
	return M.get_diagnostics_by_severity(vim.diagnostic.severity.WARN)
end

-- Get info diagnostics
function M.get_info_diagnostics()
	return M.get_diagnostics_by_severity(vim.diagnostic.severity.INFO)
end

-- Get hint diagnostics
function M.get_hint_diagnostics()
	return M.get_diagnostics_by_severity(vim.diagnostic.severity.HINT)
end

-- Get diagnostic count by severity
function M.get_diagnostic_count(severity)
	local diagnostics = M.get_diagnostics_by_severity(severity)
	return #diagnostics
end

-- Get total diagnostic count
function M.get_total_diagnostic_count()
	local diagnostics = M.get_all_diagnostics()
	return #diagnostics
end

-- Get diagnostic summary
function M.get_diagnostic_summary()
	local errors = M.get_diagnostic_count(vim.diagnostic.severity.ERROR)
	local warnings = M.get_diagnostic_count(vim.diagnostic.severity.WARN)
	local info = M.get_diagnostic_count(vim.diagnostic.severity.INFO)
	local hints = M.get_diagnostic_count(vim.diagnostic.severity.HINT)
	
	local summary = {}
	if errors > 0 then
		table.insert(summary, string.format("💥 %d", errors))
	end
	if warnings > 0 then
		table.insert(summary, string.format("⚠️ %d", warnings))
	end
	if info > 0 then
		table.insert(summary, string.format("💡 %d", info))
	end
	if hints > 0 then
		table.insert(summary, string.format("💭 %d", hints))
	end
	
	return table.concat(summary, " "), { errors = errors, warnings = warnings, info = info, hints = hints }
end

-- Go to next diagnostic
function M.go_to_next_diagnostic()
	vim.diagnostic.goto_next()
end

-- Go to previous diagnostic
function M.go_to_previous_diagnostic()
	vim.diagnostic.goto_prev()
end

-- Go to next error
function M.go_to_next_error()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end

-- Go to previous error
function M.go_to_previous_error()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end

-- Show diagnostic at cursor
function M.show_diagnostic_at_cursor()
	vim.diagnostic.open_float()
end

-- Show line diagnostics
function M.show_line_diagnostics()
	vim.diagnostic.open_float({ scope = "line" })
end

-- Toggle diagnostic virtual text
function M.toggle_diagnostic_virtual_text()
	local config = vim.diagnostic.config()
	local new_value = not config.virtual_text
	vim.diagnostic.config({ virtual_text = new_value })
	
	if new_value then
		vim.notify("✨ Diagnostic virtual text enabled", vim.log.levels.INFO)
	else
		vim.notify("💫 Diagnostic virtual text disabled", vim.log.levels.INFO)
	end
end

-- Toggle diagnostic signs
function M.toggle_diagnostic_signs()
	local config = vim.diagnostic.config()
	local new_value = not config.signs
	vim.diagnostic.config({ signs = new_value })
	
	if new_value then
		vim.notify("✨ Diagnostic signs enabled", vim.log.levels.INFO)
	else
		vim.notify("💫 Diagnostic signs disabled", vim.log.levels.INFO)
	end
end

-- Toggle diagnostic underlines
function M.toggle_diagnostic_underlines()
	local config = vim.diagnostic.config()
	local new_value = not config.underline
	vim.diagnostic.config({ underline = new_value })
	
	if new_value then
		vim.notify("✨ Diagnostic underlines enabled", vim.log.levels.INFO)
	else
		vim.notify("💫 Diagnostic underlines disabled", vim.log.levels.INFO)
	end
end

-- Get LSP capabilities for current buffer
function M.get_lsp_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	local capabilities = {}
	for _, client in ipairs(clients) do
		if client.server_capabilities then
			table.insert(capabilities, {
				name = client.name,
				capabilities = client.server_capabilities,
			})
		end
	end
	
	return capabilities
end

-- Check if LSP supports specific capability
function M.supports_capability(capability_name)
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	for _, client in ipairs(clients) do
		if client.server_capabilities and client.server_capabilities[capability_name] then
			return true, client.name
		end
	end
	
	return false, nil
end

-- Get LSP server status
function M.get_lsp_server_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	local status = {}
	for _, client in ipairs(clients) do
		table.insert(status, {
			name = client.name,
			status = client.status or "unknown",
			progress = client.progress or {},
		})
	end
	
	return status
end

-- Restart LSP server
function M.restart_lsp_server()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	for _, client in ipairs(clients) do
		vim.lsp.stop_client(client.id)
	end
	
	vim.notify("🔄 LSP servers restarted", vim.log.levels.INFO)
end

-- Get LSP workspace folders
function M.get_lsp_workspace_folders()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	
	local folders = {}
	for _, client in ipairs(clients) do
		if client.workspace_folders then
			for _, folder in ipairs(client.workspace_folders) do
				table.insert(folders, {
					name = folder.name,
					uri = folder.uri,
					client = client.name,
				})
			end
		end
	end
	
	return folders
end

-- Get LSP document symbols
function M.get_document_symbols()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local bufnr = vim.api.nvim_get_current_buf()
	local symbols = vim.lsp.buf_document_symbol()
	
	return symbols or {}
end

-- Get LSP workspace symbols
function M.get_workspace_symbols(query)
	if not M.is_lsp_attached() then
		return {}
	end
	
	query = query or ""
	local symbols = vim.lsp.buf_workspace_symbol(query)
	
	return symbols or {}
end

-- Get LSP references
function M.get_references()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local references = vim.lsp.buf_references()
	return references or {}
end

-- Get LSP implementations
function M.get_implementations()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local implementations = vim.lsp.buf_implementation()
	return implementations or {}
end

-- Get LSP definitions
function M.get_definitions()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local definitions = vim.lsp.buf_definition()
	return definitions or {}
end

-- Get LSP type definitions
function M.get_type_definitions()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local type_definitions = vim.lsp.buf_type_definition()
	return type_definitions or {}
end

-- Get LSP hover information
function M.get_hover()
	if not M.is_lsp_attached() then
		return nil
	end
	
	local hover = vim.lsp.buf_hover()
	return hover
end

-- Get LSP signature help
function M.get_signature_help()
	if not M.is_lsp_attached() then
		return nil
	end
	
	local signature_help = vim.lsp.buf_signature_help()
	return signature_help
end

-- Get LSP code actions
function M.get_code_actions()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local code_actions = vim.lsp.buf_code_action()
	return code_actions or {}
end

-- Get LSP range code actions
function M.get_range_code_actions()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local code_actions = vim.lsp.buf_range_code_action()
	return code_actions or {}
end

-- Get LSP formatting
function M.format_document()
	if not M.is_lsp_attached() then
		return false, "No LSP attached"
	end
	
	local success, result = pcall(vim.lsp.buf.format)
	return success, result
end

-- Get LSP rename
function M.rename_symbol(new_name)
	if not M.is_lsp_attached() then
		return false, "No LSP attached"
	end
	
	local success, result = pcall(vim.lsp.buf.rename, new_name)
	return success, result
end

-- Get LSP call hierarchy
function M.get_incoming_calls()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local calls = vim.lsp.buf_incoming_calls()
	return calls or {}
end

-- Get LSP outgoing calls
function M.get_outgoing_calls()
	if not M.is_lsp_attached() then
		return {}
	end
	
	local calls = vim.lsp.buf_outgoing_calls()
	return calls or {}
end

-- Create LSP status summary
function M.get_lsp_summary()
	if not M.is_lsp_attached() then
		return "No LSP attached"
	end
	
	local clients = M.get_lsp_clients()
	local diagnostic_summary = M.get_diagnostic_summary()
	
	local summary = string.format("🔧 LSP: %s | %s", table.concat(clients, ", "), diagnostic_summary)
	return summary
end

-- Make utilities available globally
_G.LSPUtils = M

return M 