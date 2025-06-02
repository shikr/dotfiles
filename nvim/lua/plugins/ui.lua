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
      routes = {
        {
          filter = {
            event = 'lsp',
            kind = 'progress',
            cond = function(messages)
              local client = vim.tbl_get(messages.opts, 'progress', 'client')
              return client == 'null-ls'
            end,
          },
          opts = { skip = true },
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
    config = function()
      local builtin = require 'veil.builtin'

      require('veil').setup {
        sections = {
          builtin.sections.animated(builtin.headers.frames_nvim, {
            hl = { fg = '#5de4c7' },
          }),
          builtin.sections.buttons {
            {
              icon = '',
              text = 'Find Files',
              shortcut = 'f',
              callback = function()
                require('telescope.builtin').find_files()
              end,
            },
            {
              icon = '󰉋',
              text = 'Navigate',
              shortcut = 'd',
              callback = function()
                vim.cmd 'Triptych'
              end,
            },
            {
              icon = '',
              text = 'Find Word',
              shortcut = 'w',
              callback = function()
                require('telescope.builtin').live_grep()
              end,
            },
            {
              icon = '',
              text = 'Buffers',
              shortcut = 'b',
              callback = function()
                require('telescope.builtin').buffers()
              end,
            },
            {
              icon = '',
              text = 'Projects',
              shortcut = 'p',
              callback = function()
                require('telescope').extensions.projects.projects()
              end,
            },
          },
          builtin.sections.oldfiles(),
        },
        mappings = {},
        startup = true,
        listed = false,
      }
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
}
