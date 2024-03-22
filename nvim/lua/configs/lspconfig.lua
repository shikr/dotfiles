local default_on_attach = require('nvchad.configs.lspconfig').on_attach
local capabilities = require('nvchad.configs.lspconfig').capabilities
local on_init = require('nvchad.configs.lspconfig').on_init

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
    return opts(on_attach, capabilities)
  end

  return opts
end

local function load_servers(servers)
  for _, lsp in ipairs(servers) do
    if type(lsp) == 'string' then
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = on_init,
      }
    else
      local opts = vim.tbl_deep_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = on_init,
      }, format_opts(lsp.opts))

      lspconfig[lsp[1]].setup(opts)
    end
  end
end

return {
  capabilities = capabilities,
  on_attach = on_attach,
  load_servers = load_servers,
}
