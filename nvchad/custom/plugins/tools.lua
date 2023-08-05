local overrides = require 'custom.configs.overrides'

return {
  {
    'williamboman/mason.nvim',
    opts = overrides.mason,
    enabled = not vim.g.vscode,
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = overrides.gitsigns,
    enabled = not vim.g.vscode,
  },

  {
    'ghillb/cybu.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    init = function()
      require('core.utils').load_mappings 'cybu'
    end,
    keys = {
      { '<plug>(CybuLastusedNext)' },
      { '<plug>(CybuLastusedPrev)' },
    },
    opts = {
      display_time = 500,
      style = {
        border = 'rounded',
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    init = function()
      require('core.utils').load_mappings 'lspsaga'
    end,
    opts = function()
      return {
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          code_action = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
          border = 'rounded',
        },
        outline = {
          win_position = 'left',
        },
      }
    end,
    enabled = not vim.g.vscode,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      --Please make sure you install markdown and markdown_inline parser
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },

  {
    'ahmedkhalf/project.nvim',
    init = function()
      require('telescope').load_extension 'projects'
    end,
    config = function()
      require('project_nvim').setup {
        exclude_dirs = { '~/.config/nvim/*' },
      }
    end,
    enabled = not vim.g.vscode,
  },

  {
    'ziontee113/color-picker.nvim',
    cmd = { 'PickColor', 'PickColorInsert' },
    init = function()
      require('core.utils').load_mappings 'colorpicker'
    end,
    opts = {
      keymap = {
        ['<S-Left>'] = '<Plug>ColorPickerSlider10Decrease',
        ['<S-Right>'] = '<Plug>ColorPickerSlider10Increase',
        ['<C-Left>'] = '<Plug>ColorPickerSlider5Decrease',
        ['<C-Right>'] = '<Plug>ColorPickerSlider5Increase',
        ['<Left>'] = '<Plug>ColorPickerSlider1Decrease',
        ['<Right>'] = '<Plug>ColorPickerSlider1Increase',
        ['c'] = '<Plug>ColorPickerChangeOutputType',
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'rest-nvim/rest.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('rest-nvim').setup()
      vim.api.nvim_create_user_command('Rest', 'lua require("rest-nvim").run()', {})
    end,
    cmd = 'Rest',
    ft = 'http',
    enabled = not vim.g.vscode,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      require('core.utils').lazy_load 'todo-comments.nvim'
    end,
    opts = {},
    enabled = not vim.g.vscode,
  },
}
