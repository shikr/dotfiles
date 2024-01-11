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

for _, ft in ipairs(prettier) do
  M.formatters_by_ft[ft] = { 'prettierd' }
end

M.formatters_by_ft.lua = { 'stylua' }

M.formatters_by_ft.rust = { 'rustfmt' }

M.formatters = {}

M.formatters.prettierd = {
  env = {
    PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath 'config' .. '/lua/custom/.prettierrc.json',
  },
}

M.formatters.rustfmt = {
  prepend_args = function(self, ctx)
    for _, root in ipairs(vim.lsp.buf.list_workspace_folders()) do
      if string.sub(ctx.dirname, 1, #root) == root then
        local Path = require 'plenary.path'
        local cargo_toml = Path:new(root .. '/Cargo.toml')

        if cargo_toml:exists() and cargo_toml:is_file() then
          for _, line in ipairs(cargo_toml:readlines()) do
            local edition = line:match [[^edition%s*=%s*%"(%d+)%"]]
            if edition then
              return { '--edition=' .. edition }
            end
          end
        end
      end
    end

    return { '--edition=2021' }
  end,
}

return M
