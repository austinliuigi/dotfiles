vim.keymap.set({'n'}, 'gs', '<Plug>(sandwich-add)', { noremap = true })
vim.keymap.set({'n'}, 'gsd', '<Plug>(sandwich-delete)', { noremap = true })
vim.keymap.set({'n'}, 'gsc', '<Plug>(sandwich-replace)', { noremap = true })
vim.keymap.set({'x'}, 'gs', '<Plug>(sandwich-add)', { noremap = true })

vim.cmd('runtime autoload/repeat.vim')
if vim.fn.hasmapto('<Plug>(RepeatDot)') == 1 then
  vim.keymap.set({'n'}, '.', '<Plug>(operator-sandwich-predot)<Plug>(RepeatDot)', { noremap = true })
else
  vim.keymap.set({'n'}, '.', '<Plug>(operator-sandwich-dot)', { noremap = true })
end
