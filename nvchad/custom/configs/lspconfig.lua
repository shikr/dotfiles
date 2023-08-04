local default_on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities

local lspconfig = require 'lspconfig'

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  default_on_attach(client, bufnr)
end

local function format_opts(opts)
  if opts == nil then
    return {}
  elseif type(opts) == 'function' then
    return opts()
  end

  return opts
end

-- if you just want default config for the servers then put them in a table
local servers = {
  'html',
  'cssls',
  'tsserver',
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
    opts = function()
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

for _, lsp in ipairs(servers) do
  if type(lsp) == 'string' then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  else
    local opts = vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, format_opts(lsp.opts))

    lspconfig[lsp[1]].setup(opts)
  end
end
