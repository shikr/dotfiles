local M = {}

local eslint = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

for _, ft in ipairs(eslint) do
  M[ft] = { 'eslint_d' }
end

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
local lint = require 'lint'

vim.api.nvim_create_autocmd(
  { 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' },
  {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  }
)

return M
