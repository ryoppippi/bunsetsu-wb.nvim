local M = {}

local tokenize = function(line, iskeyword)
  return vim.fn["bunsetsu#tokenize"](line, iskeyword)
end

M.lineTokenize = function()
  local line = vim.fn.getline(".")
  local iskeyword = vim.o.iskeyword
  local result = tokenize(line, iskeyword)
  return result
end

local getIndent = function()
  return vim.fn.indent(vim.fn.line("."))
end

vim.b.cache = {}
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.b.cache = {}
  end,
})

-- pos -1 before
-- pos 0 current
-- pos 1 after
M.getCWORD = function(pos)
  if pos == nil then
    pos = 0
  end

  local current_col = vim.fn.col(".")
  local current_lnum = vim.fn.line(".")
  local indent = getIndent()

  local cache_result_key = "bunsetsu_wb_result_" .. current_lnum
  local cr = vim.b.cache[cache_result_key]
  local result = cr and cr or M.lineTokenize()
  vim.b.cache[cache_result_key] = result

  local cache_token_info = "bunsetsu_wb_token_length_" .. current_lnum
  local token_info = vim.b.cache[cache_token_info]
  if token_info == nil then
    token_info = {}
    local total_len = 0
    for _, token in ipairs(result) do
      local total_len_with_token = total_len + string.len(token)
      local info = { token = token, col = total_len + 1, colend = total_len_with_token }
      table.insert(token_info, info)
      total_len = total_len_with_token
    end
  end
  vim.b.cache[cache_token_info] = token_info

  if indent >= current_col then
    return token_info[1]
  end
  for i, info in ipairs(token_info) do
    if info.col <= current_col and current_col <= info.colend then
      if pos == 0 then
        return info
      end
      if pos == -1 then
        return token_info[math.max(i - 1, 1)]
      end
      if pos == 1 then
        return token_info[math.min(i + 1, #token_info)]
      end
    end
  end
  return token_info[#token_info]
end

M.w = function()
  local current_lnum = vim.fn.line(".")
  local r = M.getCWORD(1)
  local col = r.col
  vim.fn.setpos(".", { 0, current_lnum, col, 0 })
  return r
end

M.e = function()
  local current_col = vim.fn.col(".")
  local current_lnum = vim.fn.line(".")
  local r = M.getCWORD(0)

  local col = r.colend
  if current_col == r.colend then
    r = M.getCWORD(1)
    col = r.colend
  end

  vim.fn.setpos(".", { 0, current_lnum, col, 0 })
  return r
end

M.b = function()
  local current_col = vim.fn.col(".")
  local current_lnum = vim.fn.line(".")
  local r = M.getCWORD(0)
  local col = r.col

  if current_col == r.col then
    r = M.getCWORD(-1)
    col = r.col
  end
  vim.fn.setpos(".", { 0, current_lnum, col, 0 })
  return r
end

return M
