---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require 'custom.highlights'

M.ui = {
  theme = 'onedark',
  theme_toggle = { 'onedark', 'tokyodark' },

  hl_override = highlights.override,
  hl_add = highlights.add,
  tabufline = {
    enabled = false,
  },
  nvdash = {
    enabled = false,
  },
}

local projects_dir

if vim.fn.executable 'xdg-user-dir' then
  projects_dir = vim.trim(vim.fn.system 'xdg-user-dir DOCUMENTS') .. '/projects'
else
  projects_dir = '~/projects'
end

M.lazy_nvim = {
  dev = {
    path = projects_dir,
    patterns = { 'nvterm' },
  },
}

M.plugins = 'custom.plugins'

-- check core.mappings for table structure
M.mappings = require 'custom.mappings'

return M
