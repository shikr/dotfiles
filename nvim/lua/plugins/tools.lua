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
    'DrKJeff16/project.nvim',
    init = function()
      require('telescope').load_extension 'projects'
    end,
    cmd = {
      'Project',
      'ProjectAdd',
      'ProjectConfig',
      'ProjectDelete',
      'ProjectExportJSON',
      'ProjectImportJSON',
      'ProjectHealth',
      'ProjectHistory',
      'ProjectRecents',
      'ProjectRoot',
      'ProjectSession',
    },
    opts = {},
    enabled = not vim.g.vscode,
  },

  {
    'gennaro-tedesco/nvim-possession',
    dependencies = { 'ibhagwan/fzf-lua' },
    event = 'VeryLazy',
    opts = {
      autosave = true,
      autoload = true,
      autoswitch = {
        enable = true,
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

  {
    'simonmclean/triptych.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      mappings = {
        nav_left = { '<BS>', '<Left>', 'h' },
        nav_right = { '<Right>', 'l' },
        cd = '<CR>',
      },
    },
    cmd = 'Triptych',
  },
}
