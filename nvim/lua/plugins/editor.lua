local overrides = require 'configs.overrides'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    dependencies = {
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
      {
        'gcc',
        function()
          require('Comment.api').toggle.linewise.current()
        end,
        desc = 'Comment line',
      },
      {
        'gc',
        function()
          require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end,
        desc = 'Comment line',
        mode = 'v',
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'nvim-tree/nvim-web-devicons',
    opts = overrides.devicons,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = overrides.blankline,
    enabled = not vim.g.vscode,
  },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'mrshmllow/document-color.nvim',
    opts = {
      mode = 'background',
    },
    enabled = not vim.g.vscode,
  },

  {
    '3rd/image.nvim',
    opts = {},
    event = 'BufAdd *.{jpeg,jpg,png,webp,gif,avif}',
    enabled = not vim.g.vscode,
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    ft = 'markdown',
    opts = {},
  },

  {
    'willothy/moveline.nvim',
    build = 'make',
    keys = {
      {
        '<M-up>',
        function()
          require('moveline').up()
        end,
        desc = 'Move line up',
      },
      {
        '<M-down>',
        function()
          require('moveline').down()
        end,
        desc = 'Move line down',
      },
      {
        '<M-up>',
        function()
          require('moveline').block_up()
        end,
        mode = 'v',
        desc = 'Move block up',
      },
      {
        '<M-down>',
        function()
          require('moveline').block_down()
        end,
        mode = 'v',
        desc = 'Move block down',
      },
    },
    event = 'VeryLazy',
    enabled = not vim.g.vscode,
  },

  {
    'declancm/cinnamon.nvim',
    event = 'VeryLazy',
    opts = {
      extra_keymaps = true,
      extended_keymaps = true,
      always_scroll = true,
      -- hide_cursor = true,
    },
    enabled = not vim.g.vscode,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        opts = function()
          local builtin = require 'statuscol.builtin'
          return {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
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
