local overrides = require 'custom.configs.overrides'
local bufdelete = require('custom.configs.bufferline').bufdelete

return {
  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
    enabled = not vim.g.vscode,
  },

  {
    'gorbit99/codewindow.nvim',
    event = 'VeryLazy',
    opts = {
      minimap_width = 10,
      auto_enable = true,
      width_multiplier = 6,
      window_border = 'solid',
      screen_bounds = 'background',
      exclude_filetypes = { 'veil' },
    },
    config = function(_, opts)
      local codewindow = require 'codewindow'
      codewindow.setup(opts)
      codewindow.apply_default_keybinds()
      vim.api.nvim_set_hl(0, 'CodewindowBoundsBackground', { bg = '#15171f' })
    end,
    enabled = not vim.g.vscode and vim.g.neovide or false,
  },

  {
    'dstein64/nvim-scrollview',
    event = 'VeryLazy',
    opts = {
      excluded_filetypes = { 'NvimTree', 'veil' },
      signs_on_startup = { 'diagnostics', 'search', 'cursor' },
      diagnostics_hint_symbol = '',
      diagnostics_error_symbol = '',
      diagnostics_warn_symbol = '',
      diagnostics_info_symbol = '',
    },
    enabled = not vim.g.neovide and not vim.g.vscode,
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
        close_command = bufdelete,
        middle_mouse_command = bufdelete,
        right_mouse_command = 'vertical sbuffer %d',
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
