local M = {}

function M.close_chat()
  local ok, cc = pcall(require, "codecompanion")
  if ok and type(cc) == "table" then
    if type(cc.close) == "function" then
      pcall(cc.close)
      return
    end
    if type(cc.close_chat) == "function" then
      pcall(cc.close_chat)
      return
    end
  end

  -- Fallback: close windows with buffer name or filetype that looks like CodeCompanion
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf) or ""
    local ok_ft, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
    ft = ok_ft and ft or ""
    if name:match("[Cc]ode[Cc]ompanion") or ft == "codecompanion" then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end
end

return M
