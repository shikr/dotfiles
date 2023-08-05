local overrides = require 'custom.configs.overrides'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    dependencies = {
      'windwp/nvim-ts-autotag',
      'HiPhish/nvim-ts-rainbow2',
      {
        'm-demare/hlargs.nvim',
        opts = {},
      },
    },
    enabled = not vim.g.vscode,
  },

  {
    'numToStr/Comment.nvim',
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
    'lukas-reineke/lsp-format.nvim',
    config = true,
    enabled = not vim.g.vscode,
  },

  {
    'samodostal/image.nvim',
    opts = {
      render = {
        foreground_color = true,
        background_color = true,
      },
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'm00qek/baleia.nvim' },
    event = 'BufAdd *.{jpeg,jpg,png,bmp,webp,tiff,tif,gif}',
    enabled = not vim.g.vscode,
  },

  {
    'willothy/moveline.nvim',
    build = 'make',
    init = function()
      local utils = require 'core.utils'
      utils.lazy_load 'moveline.nvim'
      utils.load_mappings 'moveline'
    end,
    enabled = not vim.g.vscode,
  },

  {
    'declancm/cinnamon.nvim',
    init = function()
      require('core.utils').lazy_load 'cinnamon.nvim'
    end,
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
    init = function()
      require('core.utils').lazy_load 'nvim-ufo'
    end,
    opts = true,
    enabled = not vim.g.vscode,
  },

  {
    'nacro90/numb.nvim',
    init = function()
      require('core.utils').lazy_load 'numb.nvim'
    end,
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
