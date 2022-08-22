vim.g.sandwich_no_default_key_mappings = 1
vim.g.operator_sandwich_no_default_key_mappings = 1
vim.g.textobj_sandwich_no_default_key_mappings = 1

vim.keymap.set({'n'}, 'gs', '<Plug>(sandwich-add)', { noremap = true })
vim.keymap.set({'n'}, 'ds', '<Plug>(sandwich-delete)', { noremap = true })
vim.keymap.set({'n'}, 'cs', '<Plug>(sandwich-replace)', { noremap = true })
vim.keymap.set({'v'}, 'gs', '<Plug>(sandwich-add)', { noremap = true })

if vim.fn.hasmapto('<Plug>(RepeatDot)') == 1 then
  vim.keymap.set({'n'}, '.', '<Plug>(operator-sandwich-predot)<Plug>(RepeatDot)', { noremap = true })
else
  vim.keymap.set({'n'}, '.', '<Plug>(operator-sandwich-dot)', { noremap = true })
end
