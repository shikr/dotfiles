local M = {}

M.treesitter = {
  ensure_installed = {
    'vim',
    'lua',
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'markdown',
    'markdown_inline',
    'python',
    'json',
    'jsonc',
    'rust',
    'toml',
    'http',
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = not vim.g.vscode,
  },
  rainbow = {
    enable = true,
    hlgroups = {
      'TSRainbow1',
      'TSRainbow2',
      'TSRainbow3',
      'TSRainbow4',
      'TSRainbow5',
      'TSRainbow6',
    },
    query = {
      'rainbow-parens',
      html = 'rainbow-tags',
      javascript = 'rainbow-tags-react',
      tsx = 'rainbow-tags',
    },
    -- colors = { '#15a8f2', '#e60707', '#dce703', '#2ae604', '#9a06db', '#ee06e0' },
  },
  autotag = {
    enable = not vim.g.vscode,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    'lua-language-server',
    'stylua',

    -- web dev stuff
    'html-lsp',
    'css-lsp',
    'emmet-ls',
    'typescript-language-server',
    'tailwindcss-language-server',
    'json-lsp',
    'prettierd',
    'eslint_d',

    -- rust
    'rust-analyzer',
    'rustfmt',
    'taplo',

    -- python
    'pyright',
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },

      glyphs = {
        folder = {
          default = '',
        },
      },
    },
  },
}

M.blankline = {
  char_highlight_list = {
    'IndentRainbow1',
    'IndentRainbow2',
    'IndentRainbow3',
    'IndentRainbow4',
  },
}

M.gitsigns = {
  current_line_blame = true,
}

M.devicons = {
  override_by_filename = {
    ['yarn.lock'] = {
      icon = '',
      color = '#0288D1',
      name = 'Yarn',
    },
    ['tailwind.config.js'] = {
      icon = '󱏿',
      color = '#4DB6AC',
      name = 'tailwind',
    },
    ['vite.config.js'] = {
      icon = '󱐋',
      color = '#FFAB00',
      name = 'ViteJS',
    },
  },
}

M.cmp = function(_, opts)
  local format_kinds = opts.formatting.format
  opts.formatting.format = function(entry, item)
    format_kinds(entry, item)
    return require('tailwindcss-colorizer-cmp').formatter(entry, item)
  end
  vim.list_extend(opts.sources, {
    { name = 'emoji' },
    { name = 'codeium' },
  })

  return opts
end

return M
