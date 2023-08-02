local overrides = require 'custom.configs.overrides'

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

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
  },

  -- override plugin configs
  {
    'williamboman/mason.nvim',
    opts = overrides.mason,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    dependencies = {
      'windwp/nvim-ts-autotag',
      'HiPhish/nvim-ts-rainbow2',
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = overrides.blankline,
    enabled = not vim.g.vscode,
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = overrides.gitsigns,
  },

  {
    'nvim-tree/nvim-web-devicons',
    opts = overrides.devicons,
  },

  {
    'hrsh7th/nvim-cmp',
    opts = overrides.cmp,
    dependencies = {
      'hrsh7th/cmp-emoji',
    },
  },

  -- Install a plugin
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
  },

  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    opts = {
      color_square_width = 2,
    },
  },

  {
    'lewis6991/satellite.nvim',
    event = 'VeryLazy',
    config = true,
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
    },
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
  },

  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    init = function()
      require('core.utils').load_mappings 'lspsaga'
    end,
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
    },
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      --Please make sure you install markdown and markdown_inline parser
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },

  {
    'lukas-reineke/lsp-format.nvim',
    config = true,
  },

  {
    'b0o/schemastore.nvim',
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
  },

  -- https://github.com/TheZoraiz/ascii-image-converter
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
  },

  {
    'willothy/moveline.nvim',
    build = 'make',
    init = function()
      local utils = require 'core.utils'
      utils.lazy_load 'moveline.nvim'
      utils.load_mappings 'moveline'
    end,
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
  },

  {
    'tamago324/nlsp-settings.nvim',
    cmd = 'LspSettings',
    opts = {
      config_home = vim.fn.stdpath 'config' .. '/lua/custom/lsp',
      local_settings_dir = '.nvim',
      loader = 'json',
    },
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        relative = 'editor',
      },
    },
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
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      require('core.utils').lazy_load 'todo-comments.nvim'
    end,
    opts = {},
  },

  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    build = 'yarn install --frozen-lockfile && yarn compile',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },

  {
    'willothy/veil.nvim',
    lazy = false,
    config = true,
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
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
      },
    },
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}

return plugins
