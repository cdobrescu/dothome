print('running cmp setup')

require "cmp_nvim_lsp"
require "cmp_buffer"
require "cmp_path"

-- see https://gist.github.com/horseinthesky/26d813d2974b27b5d142bb8a412d2ba3
local cmp = require'cmp'
cmp.setup({
   formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        calc = "[Calc]",
        emoji = "[Emoji]",
        ultisnips = "[UltiSnips]",
        cmp_tabnine = "[TabNine]",
      })[entry.source.name]

      return vim_item

    end,
  },
  mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
