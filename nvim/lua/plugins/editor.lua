local overrides = require 'configs.overrides'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'windwp/nvim-ts-autotag',
        opts = {},
      },
      {
        'HiPhish/rainbow-delimiters.nvim',
        opts = {
          highlight = {
            'RainbowDelimiter1',
            'RainbowDelimiter2',
            'RainbowDelimiter3',
            'RainbowDelimiter4',
            'RainbowDelimiter5',
            'RainbowDelimiter6',
          },
        },
        config = function(_, opts)
          require('rainbow-delimiters.setup').setup(opts)
        end,
      },
      {
        'm-demare/hlargs.nvim',
        opts = {},
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
    opts = function()
      return {
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    enabled = not vim.g.vscode,
  },

  {
    'nvim-tree/nvim-web-devicons',
    opts = overrides.devicons,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
  },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'skardyy/neo-img',
    build = ':NeoImg Install',
    opts = {},
    enabled = not vim.g.vscode,
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    ft = 'markdown',
    opts = {},
    enabled = not vim.g.vscode,
  },

  {
    'nvim-mini/mini.move',
    event = 'VeryLazy',
    opts = {
      mappings = {
        left = '<M-Left>',
        right = '<M-Right>',
        down = '<M-Down>',
        up = '<M-Up>',

        line_left = '<M-Left>',
        line_right = '<M-Right>',
        line_down = '<M-Down>',
        line_up = '<M-Up>',
      },
    },
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'VeryLazy',
    opts = true,
    enabled = not vim.g.vscode,
  },

  {
    'nacro90/numb.nvim',
    event = 'VeryLazy',
    config = true,
    enabled = not vim.g.vscode,
  },

  {
    'gbprod/stay-in-place.nvim',
    keys = {
      { '>', mode = { 'n', 'x' } },
      { '<', mode = { 'n', 'x' } },
      { '=', mode = { 'n', 'x' } },
      '>>',
      '<<',
      '==',
    },
    config = true,
  },

  {
    'ethanholz/nvim-lastplace',
    event = 'VeryLazy',
    config = true,
    enabled = not vim.g.vscode,
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
}
