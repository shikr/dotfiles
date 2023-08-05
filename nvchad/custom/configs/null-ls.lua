local present, null_ls = pcall(require, 'null-ls')

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd.with {
    env = {
      PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath 'config'
        .. '/lua/custom/.prettierrc.json',
    },
  },
  require 'typescript.extensions.null-ls.code-actions',

  -- rust
  b.formatting.rustfmt.with {
    extra_args = function(params)
      local Path = require 'plenary.path'
      local cargo_toml = Path:new(params.root .. '/' .. 'Cargo.toml')

      if cargo_toml:exists() and cargo_toml:is_file() then
        for _, line in ipairs(cargo_toml:readlines()) do
          local edition = line:match [[^edition%s*=%s*%"(%d+)%"]]
          if edition then
            return { '--edition=' .. edition }
          end
        end
      end
      -- default edition when we don't find `Cargo.toml` or the `edition` in it.
      return { '--edition=2021' }
    end,
  },

  -- eslint
  b.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { '.eslintrc.json' }
    end,
  },
  b.code_actions.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { '.eslintrc.json' }
    end,
  },

  -- lua
  b.formatting.stylua,
}

null_ls.setup {
  debug = false,
  sources = sources,
  on_attach = require('lsp-format').on_attach,
}
