local M = {
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

M.formatters_by_ft = {}

local prettier = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'vue',
  'css',
  'scss',
  'less',
  'html',
  'json',
  'jsonc',
  'yaml',
  'markdown',
  'markdown.mdx',
  'graphql',
  'handlebars',
}

local clang_format = {
  'c',
  'cpp',
}

for _, ft in ipairs(prettier) do
  M.formatters_by_ft[ft] = { 'prettierd' }
end

for _, ft in ipairs(clang_format) do
  M.formatters_by_ft[ft] = { 'clang-format' }
end

M.formatters_by_ft.lua = { 'stylua' }

M.formatters_by_ft.rust = { 'rustfmt' }

M.formatters = {}

M.formatters.prettierd = {
  env = {
    PRETTIERD_DEFAULT_CONFIG = vim.fn.resolve(
      vim.fn.stdpath 'config' .. '/.prettierrc.json'
    ),
  },
}

return M
