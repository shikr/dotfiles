local overrides = require 'custom.configs.overrides'
local lspconfig = require 'custom.configs.lspconfig'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- format & linting
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require 'custom.configs.null-ls'
        end,
      },
      {
        'ray-x/lsp_signature.nvim',
        event = 'LspAttach',
        opts = {
          noice = true,
          max_height = 5,
        },
      },
      {
        'folke/neodev.nvim',
        opts = {},
      },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
          on_attach = lspconfig.on_attach,
          complete_function_calls = true,
          expose_as_code_action = {
            'add_missing_imports',
            'remove_unused',
            'remove_unused_imports',
            'organize_imports',
          },
        },
        -- TODO: disable tsserver path warn
        config = function(_, opts)
          local mason_registry = require 'mason-registry'
          local tsserver_path =
            mason_registry.get_package('typescript-language-server'):get_install_path()

          require('typescript-tools').setup(vim.tbl_deep_extend('force', opts, {
            settings = {
              tsserver_path = tsserver_path .. '/node_modules/typescript/lib/tsserver.js',
            },
          }))
        end,
      },
    },
    config = function()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspload'
    end, -- Override to setup mason-lspconfig
    enabled = not vim.g.vscode,
  },

  {
    'hrsh7th/nvim-cmp',
    opts = overrides.cmp,
    dependencies = {
      'hrsh7th/cmp-emoji',
      {
        'roobert/tailwindcss-colorizer-cmp.nvim',
        opts = {
          color_square_width = 2,
        },
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'b0o/schemastore.nvim',
  },

  {
    'tamago324/nlsp-settings.nvim',
    cmd = 'LspSettings',
    opts = {
      config_home = vim.fn.stdpath 'config' .. '/lua/custom/lsp',
      local_settings_dir = '.nvim',
      loader = 'json',
    },
    enabled = not vim.g.vscode,
  },

  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    build = 'yarn install --frozen-lockfile && yarn compile',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    enabled = not vim.g.vscode,
  },
}
