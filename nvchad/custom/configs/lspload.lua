local load_servers = require('custom.configs.lspconfig').load_servers

local servers = {
  'html',
  'cssls',
  'taplo',
  'pyright',
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
    opts = function(on_attach, capabilities)
      local tl_on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        if client.server_capabilities.colorProvider then
          require('document-color').buf_attach(bufnr)
        end
      end

      local tl_capabilities = capabilities

      tl_capabilities.textDocument.colorProvider = {
        dynamicRegistration = true,
      }

      return {
        on_attach = tl_on_attach,
        capabilities = tl_capabilities,
      }
    end,
  },
}

load_servers(servers)
