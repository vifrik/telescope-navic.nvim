local M = {}

function M.deep_copy(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end
  if seen and seen[obj] then
    return seen[obj]
  end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
    res[M.deep_copy(k, s)] = M.deep_copy(v, s)
  end
  return res
end

function M.get_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return bufnr, filename
end

return M
