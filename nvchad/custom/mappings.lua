---@type MappingsTable
local M = {}

M.general = {
  i = {
    ['<C-s>'] = { '<cmd>w<cr>', 'save file' },
  },
  n = {
    [';'] = { ':', 'enter command mode', opts = { nowait = true } },
    ['<C-q>'] = {
      '<cmd>bdelete!<cr>',
      'close buffer',
    },
    ['<C-x>'] = { '<cmd>q<cr>', 'close neovim' },
    ['<leader>fp'] = { '<cmd>Telescope projects<cr>', 'projects' },
  },
}

if vim.g.vscode then
  M.vscode = {
    n = {
      ['<leader>ff'] = {
        function()
          require('vscode-neovim').call 'workbench.action.quickOpen'
        end,
        'open file',
      },
      ['<leader>e'] = {
        function()
          require('vscode-neovim').call 'workbench.files.action.focusFilesExplorer'
        end,
        'focus file explorer',
      },
    },
  }
end

M.cybu = {
  plugin = true,
  n = {
    ['<C-tab>'] = { '<plug>(CybuLastusedNext)', 'go to next' },
    ['<C-S-tab>'] = { '<plug>(CybuLastusedPrev)', 'go to prev' },
  },
}

M.comment = {
  plugin = true,
  n = {
    ['gcc'] = {
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      'toggle comment',
    },
  },
  v = {
    ['gc'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      'toggle comment',
    },
  },
}

M.moveline = {
  plugin = true,
  n = {
    ['<M-up>'] = {
      function()
        require('moveline').up()
      end,
      'move line up',
    },
    ['<M-down>'] = {
      function()
        require('moveline').down()
      end,
      'move line down',
    },
  },
  v = {
    ['<M-up>'] = {
      function()
        require('moveline').block_up()
      end,
      'move line up',
    },
    ['<M-down>'] = {
      function()
        require('moveline').block_down()
      end,
      'move line down',
    },
  },
}

M.colorpicker = {
  plugin = true,
  n = {
    ['<leader>cl'] = { '<cmd>PickColor<cr>', 'Pick a color' },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    ['ga'] = { '<cmd>Lspsaga code_action<cr>', 'lsp code action' },
    ['grn'] = { '<cmd>Lspsaga rename<cr>', 'lsp rename' },
    ['gp'] = { '<cmd>Lspsaga peek_definition<cr>', 'lsp peek definition' },
    ['gd'] = { '<cmd>Lspsaga goto_definition<cr>', 'lsp go to definition' },
    ['gh'] = { '<cmd>Lspsaga hover_doc<cr>', 'lsp hover doc' },
    ['gl'] = { '<cmd>Lspsaga show_cursor_diagnostics<cr>', 'lsp diagnostics' },
  },
}

M.disabled = {
  n = {
    ['<tab>'] = '',
    ['<s-tab>'] = '',
  },
}

-- more keybinds!

return M
