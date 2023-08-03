local function bufdelete(bufnr)
  local elements = require('bufferline').get_elements().elements
  if #elements >= 1 then
    if #elements == 1 then
      vim.cmd 'Veil'
    end
    vim.cmd('bd! ' .. bufnr)
  end
end

return { bufdelete = bufdelete }
