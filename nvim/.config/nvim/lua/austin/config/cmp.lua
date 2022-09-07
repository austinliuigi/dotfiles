local cmp = require('cmp')

cmp.setup {
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end,
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert({
    ['<S-Left>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
    ['<S-Right>'] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), { 'i', 'c' }),
    -- ['<Esc>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
    -- ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), { 'i', 'c' }),
    ['<S-Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
    ['<S-Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
    ['<C-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<S-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'buffer', keyword_length = 2, max_item_count = 4},
    -- { name = 'digraphs' },
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
        luasnip = '[SNIP]',
        nvim_lsp_signature_help = '[SIG]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[API]',
        path = '[PATH]',
        calc = '[CALC]',
        buffer = '[BUF]',
        dap = '[DAP]',
        cmdline_history = '[HIST]',
        cmdline = '[CMD]',
      })[entry.source.name]
      return vim_item
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true
  }
}

cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
  sources = {
    { name = "dap", trigger_characters = { "." }  },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
  },
})

cmp.setup.cmdline(':', {
  -- completion = {
  --   keyword_length = 2
  -- },
  sources = {
    { name = 'path' },
    { name = 'cmdline', max_item_count = 5 },
    { name = 'cmdline_history', max_item_count = 2, keyword_length = 5 },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
  },
  window = {
    completion = cmp.config.window.bordered()
  }
})

for _, cmd_type in ipairs({'/', '?'}) do
  cmp.setup.cmdline(cmd_type, {
    -- completion = {
    --   keyword_length = 2
    -- },
    sources = {
      { name = 'buffer', max_item_count = 5 },
      { name = 'cmdline_history', max_item_count = 2, keyword_length = 5 },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
    },
    window = {
      completion = cmp.config.window.bordered()
    }
  })
end

vim.api.nvim_exec_autocmds("User", { pattern = "CmpConfigLoaded" })
