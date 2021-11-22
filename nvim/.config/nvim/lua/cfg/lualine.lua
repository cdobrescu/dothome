-------------------- LUA-LINE ---------------------------
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    section_separators = {left = '', right = ''},
    component_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {
      {'mode', fmt = function(str) return str:sub(1,1) end}
    },
    lualine_b = {'branch', 'diff',
      { 'diagnostics',
        sources = {'nvim_lsp'},
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      }
    },
    lualine_c = {'filename'},
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}

