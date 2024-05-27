local M = {}

---Convert a snake_case string to camelCase
---@param str string?
---@return string?
function M.snake_to_camel(str)
  if not str then
    return nil
  end
  return (str:gsub("^%l", string.upper):gsub("_%l", string.upper):gsub("_", ""))
end

---Convert a camelCase string to snake_case
---@param str string
---@return string|nil
function M.camel_to_snake(str)
  if not str then
    return nil
  end
  return (str:gsub("%u", "_%1"):gsub("^_", ""):lower())
end

--- Split the current line by the given separator
--- @param separator string
--- @return nil
function M.split_line(separator)
  -- 保存当前光标位置
  local save_cursor = vim.api.nvim_win_get_cursor(0)
  -- 获取当前行内容
  local line_content = vim.api.nvim_get_current_line()
  -- 拆分行
  vim.api.nvim_win_set_cursor(0, { save_cursor[1], 0 })
  local parts = vim.split(line_content, separator)
  -- 清空当前行
  vim.api.nvim_feedkeys("d$", "n", true)
  -- 逐个插入拆分的部分
  for _, part in ipairs(parts) do
    vim.api.nvim_feedkeys(part .. "\n", "n", true)
  end
  -- 恢复光标位置
  vim.api.nvim_win_set_cursor(0, { save_cursor[1], save_cursor[2] })
end

return M
