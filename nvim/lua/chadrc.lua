---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require 'highlights'

M.base46 = {
  theme = 'onedark',
  theme_toggle = { 'onedark', 'tokyodark' },
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.ui = {
  tabufline = {
    enabled = false,
  },
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },
}

M.lsp = {
  signature = false,
}

return M
