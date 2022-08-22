local luasnip = require('luasnip')

luasnip.config.set_config {
  history = true,
  update_events = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged'
}

vim.keymap.set({'i'}, '<S-Tab>', '<cmd>lua require("luasnip").jump(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set({'s'}, '<Tab>', '<cmd>lua require("luasnip").jump(1)<CR>', { noremap = true, silent = true })
vim.keymap.set({'s'}, '<S-Tab>', '<cmd>lua require("luasnip").jump(-1)<CR>', { noremap = true, silent = true })
