local overrides = require 'configs.overrides'
local lspconfig = require 'configs.lspconfig'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'stevearc/conform.nvim',
        cmd = 'Conform',
        opts = function()
          return require 'configs.conform'
        end,
        config = function(_, opts)
          vim.api.nvim_create_user_command('Conform', function(args)
            if args.args == 'toggle' then
              vim.g.disable_autoformat = not vim.g.disable_autoformat
            elseif args.args == 'enable' then
              vim.g.disable_autoformat = false
            elseif args.args == 'disable' then
              vim.g.disable_autoformat = true
            end
          end, {
            desc = 'Toggle Conform',
            nargs = 1,
            complete = function(_, cmdline)
              local args = vim.split(cmdline, ' +')
              if #args == 2 then
                local options = { 'toggle', 'enable', 'disable' }

                return vim.tbl_filter(function(item)
                  return item:match('^' .. args[2])
                end, options)
              end
              return {}
            end,
          })
          require('conform').setup(opts)
        end,
      },
      {
        'ray-x/lsp_signature.nvim',
        event = 'LspAttach',
        opts = {
          noice = true,
          max_height = 5,
        },
      },
      {
        'folke/neodev.nvim',
        opts = {},
      },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
          on_attach = lspconfig.on_attach,
          settings = {
            complete_function_calls = true,
            expose_as_code_action = {
              'add_missing_imports',
              'remove_unused',
              'remove_unused_imports',
              'organize_imports',
            },
          },
        },
      },
    },
    config = function()
      require('nvchad.configs.lspconfig').defaults()
      require 'configs.lspload'
    end, -- Override to setup mason-lspconfig
    enabled = not vim.g.vscode,
  },

  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      {
        'copilotlsp-nvim/copilot-lsp',
        init = function()
          vim.g.copilot_nes_debounce = 500
        end,
      },
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          -- handle manual accept to avoid conflicts with tabs
          accept = false,
          accept_word = '<C-Right>',
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      nes = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_and_goto = '<Tab>',
          accept = false,
          dismiss = '<Esc>',
        },
      },
    },
    config = function(_, args)
      local cmp = require 'cmp'

      cmp.event:on('menu_opened', function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on('menu_closed', function()
        vim.b.copilot_suggestion_hidden = false
      end)

      require('copilot').setup(args)
    end,
    enabled = not vim.g.vscode,
  },

  {
    'hrsh7th/nvim-cmp',
    opts = overrides.cmp,
    dependencies = {
      'hrsh7th/cmp-emoji',
    },
    enabled = not vim.g.vscode,
  },

  {
    'b0o/schemastore.nvim',
  },

  {
    'tamago324/nlsp-settings.nvim',
    cmd = 'LspSettings',
    opts = {
      config_home = vim.fn.stdpath 'config' .. '/lua/custom/lsp',
      local_settings_dir = '.nvim',
      loader = 'json',
    },
    enabled = not vim.g.vscode,
  },

  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    build = 'yarn install --frozen-lockfile && yarn compile',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    enabled = not vim.g.vscode,
  },
}
