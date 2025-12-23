local M = {}
local ns = vim.api.nvim_create_namespace("user_extmarks")

function M.set(buf, line, col, opts)
  buf = buf or 0
  opts = opts or {}
  return vim.api.nvim_buf_set_extmark(buf, ns, line, col, opts)
end

function M.list(buf)
  buf = buf or 0
  return vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {details=true})
end

function M.clear(buf, start_line, end_line)
  buf = buf or 0
  return vim.api.nvim_buf_clear_namespace(buf, ns, start_line or 0, end_line or -1)
end

function M.clear_line(buf, row)
  buf = buf or 0
  row = row or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  local marks = vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {details=true})
  for _, m in ipairs(marks) do
    local id, r = m[1], m[2]
    if r == row then
      pcall(vim.api.nvim_buf_del_extmark, buf, ns, id)
    end
  end
end

function M.toggle_at_cursor(opts)
  local buf = 0
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local marks = vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {details=true})
  for _, m in ipairs(marks) do
    local id, r = m[1], m[2]
    if r == row then
      pcall(vim.api.nvim_buf_del_extmark, buf, ns, id)
      return
    end
  end
  local opts = opts or {}
  vim.api.nvim_buf_set_extmark(buf, ns, row, col, opts)
end

return M
