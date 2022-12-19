local toggle_key = require("austin.keymaps").toggle_key

vim.keymap.set('n', toggle_key..'u', '<cmd>MundoToggle<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '_', '<cmd>MundoToggle<CR>', {noremap = true, silent = true})
