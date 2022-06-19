local cmp = require 'cmp'

cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert({
    ['<Left>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
    ['<Right>'] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), { 'i', 'c' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
    ['<S-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<S-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<S-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  }),
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 3 }
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, vim_item)
      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = '[BUF]',
        path = '[PATH]',
        cmdline = '[CMD]',
        nvim_lua = '[API]',
        nvim_lsp = '[LSP]',
        nvim_lsp_signature_help = '[SIG]',
        luasnip = '[SNIP]'
      })[entry.source.name]
      return vim_item
    end
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = true
  }
}

cmp.setup.cmdline(':', {
  completion = {
    keyword_length = 2
  },
  sources = {
    { name = 'path' },
    { name = 'cmdline', max_item_count = 10 }
  }
})

cmp.setup.cmdline('/', {
  completion = {
    keyword_length = 2
  },
  sources = {
    { name = 'buffer', max_item_count = 10 }
  }
})

--vim.cmd([[
--  hi! link CmpItemAbbrMatch Normal
--  hi! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
--  hi! link CmpItemAbbr Comment
--  hi! link CmpItemAbbrDeprecated Error
--  hi! link CmpItemKind Special
--  hi! link CmpItemMenu NonText
--]])
