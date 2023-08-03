---@type MappingsTable
local M = {}
local bufdelete = require('custom.configs.bufferline').bufdelete

M.general = {
  i = {
    ['<C-s>'] = { '<cmd>w<cr>', 'save file' },
    ['<C-v>'] = { '<ESC>pa', 'Paste' },
  },
  n = {
    [';'] = { ':', 'enter command mode', opts = { nowait = true } },
    ['<C-q>'] = {
      function()
        bufdelete(vim.api.nvim_get_current_buf())
      end,
      'close buffer',
    },
    ['<C-v>'] = { 'p', 'Paste' },
    ['<C-x>'] = { '<cmd>q<cr>', 'close neovim' },
    ['<leader>fp'] = { '<cmd>Telescope projects<cr>', 'projects' },
  },
  v = {
    ['<C-c>'] = { 'y', 'Copy' },
  },
  c = {
    ['<C-v>'] = { '<C-R>+', 'Paste' },
  },
}

if vim.g.vscode then
  local call = require('vscode-neovim').call
  M.vscode = {
    n = {
      [';'] = {
        function()
          call 'workbench.action.gotoLine'
        end,
      },
      ['grn'] = {
        function()
          call 'editor.action.rename'
        end,
      },
      ['gcc'] = {
        function()
          call 'editor.action.commentLine'
        end,
      },
      ['gbc'] = {
        function()
          call 'editor.action.blockComment'
        end,
      },
      ['<leader>ff'] = {
        function()
          call 'workbench.action.quickOpen'
        end,
        'open file',
      },
      ['<leader>fm'] = {
        function()
          call 'editor.action.formatDocument'
        end,
        'Format Document',
      },
      ['<leader>e'] = {
        function()
          call 'workbench.files.action.focusFilesExplorer'
        end,
        'focus file explorer',
      },
      ['<leader>h'] = {
        function()
          call 'workbench.action.createTerminalEditorSide'
        end,
        'new horizontal terminal',
      },
      ['<leader>v'] = {
        function()
          call 'workbench.action.terminal.new'
        end,
        'new vertical terminal',
      },
    },
    x = {
      ['gc'] = {
        function()
          call 'editor.action.commentLine'
        end,
      },
      ['gb'] = {
        function()
          call 'editor.action.blockComment'
        end,
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

M.bufferline = {
  plugin = true,
  n = {
    ['<M-Left>'] = { '<cmd>BufferLineMovePrev<cr>', 'move tab to the left' },
    ['<M-Right>'] = { '<cmd>BufferLineMoveNext<cr>', 'move tab to the right' },
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
