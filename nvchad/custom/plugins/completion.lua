local overrides = require 'custom.configs.overrides'

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
    },
    config = function()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end, -- Override to setup mason-lspconfig
    enabled = not vim.g.vscode,
  },

  {
    'hrsh7th/nvim-cmp',
    opts = overrides.cmp,
    dependencies = {
      'hrsh7th/cmp-emoji',
    },
    enabled = not vim.g.vscode,
  },

  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    opts = {
      color_square_width = 2,
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
