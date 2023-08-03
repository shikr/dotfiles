vim.opt.runtimepath:prepend(vim.fn.expand '~/.config/nvim/lua/custom/ftplugin')

vim.opt.list = true
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'trail:⬩'
vim.o.mousemoveevent = true

if vim.g.neovide then
  vim.o.guifont = 'FiraCode Nerd Font:h12'
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_fullscreen = true
end

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
