local function has_bufnr(elements, bufnr)
  for _, element in ipairs(elements) do
    if bufnr == element.id then
      return true
    end
  end

  return false
end

local function bufdelete(bufnr)
  local elements = require('bufferline').get_elements().elements

  if #elements >= 1 then
    if #elements == 1 and has_bufnr(elements, bufnr) then
      vim.cmd 'Veil'
    end
    vim.cmd('bd! ' .. bufnr)
  end
end

return { bufdelete = bufdelete }
