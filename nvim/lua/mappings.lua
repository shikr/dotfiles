require 'nvchad.mappings'
local bufdelete = require('configs.bufferline').bufdelete
local copilot = require 'copilot.suggestion'

-- add yours here

local map = vim.keymap.set

map({ 'n', 'i' }, '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
map('i', '<C-v>', '<ESC>pa', { desc = 'Paste' })
map('n', ';', ':', { desc = 'CMD enter command mode' })
map('n', '<C-q>', function()
  bufdelete(vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
end, { desc = 'Close current buffer' })
map('n', '<C-v>', 'p', { desc = 'Paste' })
map('n', '<C-x>', '<cmd>q<cr>', { desc = 'Close neovim' })
map('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = 'Find project' })
map('v', '<C-c>', 'y', { desc = 'Copy to clipboard' })
map('c', '<C-c>', '<C-R>+', { desc = 'Paste' })
map('n', '<leader>fd', function()
  vim.cmd 'Triptych'
end)
map('i', '<tab>', function()
  if not copilot.is_visible() then
    return '<Tab>'
  end
  copilot.accept()
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

-- Terminal
map({ 'n', 't' }, '<A-i>', function()
  require('nvchad.term').toggle { pos = 'float', id = 'float' }
end, { desc = 'Toggle floating terminal' })
map({ 'n', 't' }, '<A-h>', function()
  require('nvchad.term').toggle { pos = 'sp', id = 'sp' }
end, { desc = 'Toggle split terminal' })
map({ 'n', 't' }, '<A-v>', function()
  require('nvchad.term').toggle { pos = 'vsp', id = 'vsp' }
end, { desc = 'Toggle vsplit terminal' })

if vim.g.vscode then
  local call = require('vscode-neovim').call
  map('n', ';', function()
    call 'workbench.action.gotoLine'
  end)
  map('n', 'grn', function()
    call 'editor.action.rename'
  end)
  map('n', 'gcc', function()
    call 'editor.action.commentLine'
  end)
  map('n', 'gbc', function()
    call 'editor.action.blockComment'
  end)
  map('n', 'ga', function()
    call 'editor.action.quickFix'
  end)
  map('n', '<leader>ff', function()
    call 'workbench.action.quickOpen'
  end)
  map('n', '<leader>fm', function()
    call 'editor.action.formatDocument'
  end)
  map('n', '<leader>e', function()
    call 'workbench.files.action.focusFilesExplorer'
  end)
  map('n', '<leader>h', function()
    call 'workbench.action.terminal.new'
  end)
  map('n', '<leader>v', function()
    call 'workbench.action.createTerminalEditorSide'
  end)
  map('x', 'gc', function()
    call 'editor.action.commentLine'
  end)
  map('x', 'gb', function()
    call 'editor.action.blockComment'
  end)
end
