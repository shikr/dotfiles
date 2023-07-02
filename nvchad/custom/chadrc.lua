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

M.lazy_nvim = {
  dev = {
    patterns = { 'nvterm' },
  },
}

M.plugins = 'custom.plugins'

-- check core.mappings for table structure
M.mappings = require 'custom.mappings'

return M
