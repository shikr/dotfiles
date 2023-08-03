local overrides = require 'custom.configs.overrides'

return {
  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
    enabled = not vim.g.vscode,
  },

  {
    'dstein64/nvim-scrollview',
    event = 'VeryLazy',
    opts = {
      exclude_filetypes = { 'NvimTree' },
      signs_on_startup = { 'diagnostics', 'search', 'cursor' },
      diagnostics_hint_symbol = '',
      diagnostics_error_symbol = '',
      diagnostics_warn_symbol = '',
      diagnostics_info_symbol = '',
    },
    enabled = not vim.g.vscode,
  },

  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        relative = 'editor',
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'willothy/veil.nvim',
    lazy = false,
    config = true,
    enabled = not vim.g.vscode,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
    event = 'VeryLazy',
    enabled = not vim.g.vscode,
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    init = function()
      require('core.utils').lazy_load 'bufferline.nvim'
    end,
    opts = {
      options = {
        separator_style = 'thick',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        middle_mouse_command = 'bdelete! %d',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },
        hover = {
          enabled = true,
          delay = 100,
          reveal = { 'close' },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      require('core.utils').load_mappings 'bufferline'
    end,
    enabled = not vim.g.vscode,
  },
}
