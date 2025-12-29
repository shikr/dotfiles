local formatters = {
  ['clang-format'] = { 'c', 'cpp' },
  prettierd = {
    'scss',
    'less',
    'yaml',
    'markdown',
    'markdown.mdx',
    'handlebars',
    opts = {
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.resolve(
          vim.fn.stdpath 'config' .. '/.prettierrc.json'
        ),
      },
    },
  },
  biome = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'css',
    'graphql',
    'vue',
    'astro',
    'html',
    'svelte',
  },
  stylua = { 'lua' },
  rustfmt = { 'rust' },
}

local M = {
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
}

M.formatters_by_ft = {}

for formatter, filetypes in pairs(formatters) do
  for _, ft in ipairs(filetypes) do
    M.formatters_by_ft[ft] = M.formatters_by_ft[ft] or {}
    table.insert(M.formatters_by_ft[ft], formatter)
  end
end

M.formatters = {}

for formatter, filetypes in pairs(formatters) do
  if filetypes.opts ~= nil then
    M.formatters[formatter] = filetypes.opts
  end
end

return M
