local load_servers = require('configs.lspconfig').load_servers

local servers = {
  'html',
  'cssls',
  'taplo',
  'pyright',
  'bashls',
  'cmake',
  'biome',
  {
    'clangd',
    opts = {
      cmd = { 'clangd', '--clang-tidy' },
    },
  },
  {
    'rust_analyzer',
    opts = {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
        },
      },
    },
  },
  {
    'jsonls',
    opts = {
      settings = {
        json = {
          schemas = vim.list_extend(
            require('schemastore').json.schemas(),
            require('nlspsettings').get_default_schemas()
          ),
          validate = { enable = true },
        },
      },
    },
  },
  {
    'emmet_ls',
    opts = {
      filetypes = {
        'css',
        'html',
        'javascript',
        'javascriptreact',
        'less',
        'sass',
        'scss',
        'svelte',
        'typescriptreact',
        'vue',
      },
    },
  },
  {
    'tailwindcss',
    opts = {
      settings = {
        tailwindCSS = {
          classFunctions = {
            'tw',
            'tw\\.[a-z-]+',
            'clsx',
            'tv',
            'cn',
            'cx',
          },
        },
      },
    },
  },
}

load_servers(servers)
