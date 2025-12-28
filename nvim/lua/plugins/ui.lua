local overrides = require 'configs.overrides'
local bufdelete = require('configs.bufferline').bufdelete

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
      vim.api.nvim_set_hl(0, 'CodewindowBoundsBackground', { link = 'Visual' })
    end,
    enabled = not vim.g.vscode and vim.g.neovide or false,
  },

  {
    'dstein64/nvim-scrollview',
    event = 'VeryLazy',
    opts = {
      excluded_filetypes = { 'NvimTree', 'veil' },
      signs_on_startup = { 'diagnostics', 'search', 'cursor' },
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
    'folke/snacks.nvim',
    priority = 100,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
      },
      indent = {
        enabled = true,
        indent = {
          enabled = true,
          hl = {
            'SnacksIndent1',
            'SnacksIndent2',
            'SnacksIndent3',
            'SnacksIndent4',
          },
        },
        scope = {
          enabled = true,
          hl = 'SnacksIndentScope',
        },
      },
      quickfile = {
        enabled = true,
      },
      scroll = {
        enabled = true,
      },
      statuscolumn = {
        enabled = true,
        left = { 'fold', 'mark', 'sign' },
        right = { 'git' },
        folds = {
          open = true,
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            {
              icon = ' ',
              key = 'f',
              desc = 'Find files',
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = '󰉋 ',
              key = 'd',
              desc = 'File explorer',
              action = ':Triptych',
            },
            {
              icon = ' ',
              key = 's',
              desc = 'Find text',
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = ' ',
              key = 'c',
              desc = 'Configuration',
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = '󰒲 ',
              key = 'L',
              desc = 'Lazy',
              action = ':Lazy',
              enabled = package.loaded.lazy ~= nil,
            },
            {
              icon = ' ',
              key = 'q',
              desc = 'Quit Neovim',
              action = ':qa',
            },
          },
        },
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keys', section = 'keys', indent = 2, padding = 1 },
          {
            icon = ' ',
            title = 'Recent Files',
            section = 'recent_files',
            indent = 2,
            padding = 1,
          },
          { section = 'startup' },
        },
      },
    },
    config = function(_, opts)
      local prev = { new_name = '', old_name = '' }
      vim.api.nvim_create_autocmd('User', {
        pattern = 'NvimTreeSetup',
        callback = function()
          local events = require('nvim-tree.api').events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })

      require('snacks').setup(opts)
    end,
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
    event = 'VeryLazy',
    keys = {
      { '<M-Left>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move tab to left' },
      { '<M-Right>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move tab to right' },
    },
    opts = {
      options = {
        separator_style = 'thick',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icons = {
            error = ' ',
            warning = ' ',
            info = ' ',
            hint = ' ',
          }

          local s = ' '
          local current = 0
          for e, n in pairs(diagnostics_dict) do
            local sym = icons[e] or ''
            s = s .. n .. sym
            current = current + n

            if current ~= count then
              s = s .. ' '
            end
          end

          return s
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
    end,
    enabled = not vim.g.vscode,
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    event = 'ModeChanged *:[vV\22]',
    opts = {
      match_types = {
        nbsp = false,
        lead = false,
      },
      list_chars = {
        space = '⋅',
        trail = '⬩',
      },
    },
  },
}
