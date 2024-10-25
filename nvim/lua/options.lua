require "nvchad.options"

-- add yours here!

local o, opt = vim.o, vim.opt

opt.list = true
opt.listchars:append 'space:⋅'
opt.listchars:append 'trail:⬩'

o.wrap = true
o.mousemoveevent = true
o.foldcolumn = '1'
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

if vim.g.neovide then
  o.guifont = 'FiraCode Nerd Font:h12'
  vim.g.neovide_cursor_vfx_mode = 'railgun'

  if vim.env.HOME ~= nil then
    vim.fn.chdir(vim.env.HOME)
  end
end
-- o.cursorlineopt ='both' -- to enable cursorline!
