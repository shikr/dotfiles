---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require 'highlights'

M.ui = {
  theme = 'onedark',
  theme_toggle = { 'onedark', 'tokyodark' },

  hl_override = highlights.override,
  hl_add = highlights.add,
  tabufline = {
    enabled = false,
  },
}

return M
