local overrides = require 'configs.overrides'

return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
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
    keys = {
      { '<C-tab>', '<plug>(CybuLastusedNext)', desc = 'Last used tab' },
      { '<C-S-tab>', '<plug>(CybuLastusedPrev)', desc = 'Last used prev tab' },
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
    keys = {
      { 'ga', '<cmd>Lspsaga code_action<cr>', desc = 'Code Action' },
      { 'grn', '<cmd>Lspsaga rename<cr>', desc = 'Rename' },
      { 'gp', '<cmd>Lspsaga peek_definition<cr>', desc = 'Peek Definition' },
      { 'gd', '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
      { 'gh', '<cmd>Lspsaga hover_doc<cr>', desc = 'Hover' },
      { 'gl', '<cmd>Lspsaga show_cursor_diagnostics<cr>', desc = 'Line Diagnostics' },
    },
    opts = function()
      return {
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          code_action = ' ',
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
      require('project_nvim').setup()
    end,
    enabled = not vim.g.vscode,
  },

  {
    'ziontee113/color-picker.nvim',
    cmd = { 'PickColor', 'PickColorInsert' },
    keys = {
      { '<leader>cl', '<cmd>PickColor<cr>', desc = 'Pick Color' },
    },
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
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {},
    enabled = not vim.g.vscode,
  },
}
