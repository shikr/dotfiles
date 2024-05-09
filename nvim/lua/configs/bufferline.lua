local function has_bufnr(elements, bufnr)
  for _, element in ipairs(elements) do
    if bufnr == element.id then
      return true
    end
  end

  return false
end

local function close(bufnr, win)
  local layout = vim.fn.winlayout()[1]
  if win ~= nil and layout ~= 'leaf' then
    vim.api.nvim_win_close(win, true)
  end

  vim.api.nvim_buf_delete(bufnr, { force = true })
end

local function bufdelete(bufnr, window)
  local elements = require('bufferline').get_elements().elements

  if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'veil' then
    if #elements == 1 and has_bufnr(elements, bufnr) then
      vim.cmd 'Veil'
    end
    close(bufnr, window)
  end
end

return { bufdelete = bufdelete }
