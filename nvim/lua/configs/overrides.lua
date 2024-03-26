local M = {}

M.treesitter = {
  ensure_installed = {
    'vim',
    'lua',
    'html',
    'css',
    'scss',
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
    'sql',
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
    'eslint-lsp',

    -- rust
    'rust-analyzer',
    'rustfmt',
    'taplo',

    -- python
    'pyright',
  },
}

M.nvimtree = {
  filters = {
    git_ignored = false,
  },

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

  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
}

M.blankline = {
  indent = {
    highlight = {
      'IndentRainbow1',
      'IndentRainbow2',
      'IndentRainbow3',
      'IndentRainbow4',
    },
  },
}

M.gitsigns = {
  current_line_blame = true,
}

local function icon_multiple_filenames(filenames, opts)
  local overrides = {}
  for _, file in ipairs(filenames) do
    overrides[file] = opts
  end
  return overrides
end

local function filenames_list(filename, extensions)
  local filenames = {}
  for _, ext in ipairs(extensions) do
    table.insert(filenames, filename .. '.' .. ext)
  end
  return filenames
end

M.devicons = {
  override_by_filename = vim.tbl_extend(
    'force',
    icon_multiple_filenames({ 'yarn.lock', '.yarnrc.yml', '.yarnrc.yaml' }, {
      icon = '',
      color = '#0288D1',
      name = 'Yarn',
    }),
    icon_multiple_filenames(
      filenames_list('tailwind.config', { 'js', 'cjs', 'ts', 'cts' }),
      {
        icon = '󱏿',
        color = '#4DB6AC',
        name = 'tailwind',
      }
    ),
    icon_multiple_filenames(filenames_list('vite.config', { 'js', 'cjs', 'ts', 'cts' }), {
      icon = '󱐋',
      color = '#FFAB00',
      name = 'ViteJS',
    }),
    icon_multiple_filenames(
      filenames_list('.eslintrc', { 'js', 'cjs', 'yaml', 'yml', 'json' }),
      {
        icon = '',
        color = '#4b32c3',
        cterm_color = '56',
        name = 'Eslintrc',
      }
    )
  ),
}

M.cmp = function(_, opts)
  local format_kinds = opts.formatting.format
  opts.formatting.format = function(entry, item)
    format_kinds(entry, item)
    return require('tailwindcss-colorizer-cmp').formatter(entry, item)
  end
  vim.list_extend(opts.sources, {
    { name = 'emoji' },
  })

  return opts
end

return M
