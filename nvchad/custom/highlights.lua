-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = 'green', bold = true },
  IndentRainbow1 = { fg = '#ffff40', nocombine = true },
  IndentRainbow2 = { fg = '#7fff7f', nocombine = true },
  IndentRainbow3 = { fg = '#ff7fff', nocombine = true },
  IndentRainbow4 = { fg = '#4fecec', nocombine = true },
  RainbowDelimiter1 = { fg = '#15a8f2', nocombine = true },
  RainbowDelimiter2 = { fg = '#e60707', nocombine = true },
  RainbowDelimiter3 = { fg = '#dce703', nocombine = true },
  RainbowDelimiter4 = { fg = '#2ae604', nocombine = true },
  RainbowDelimiter5 = { fg = '#9a06db', nocombine = true },
  RainbowDelimiter6 = { fg = '#ee06e0', nocombine = true },
  FoldColumn = { link = 'Normal' },
}

return M
