vim.g.jupyter_ascending_default_mappings = false

vim.keymap.set({'n'}, "<Leader><Leader>x", "<cmd>call jupyter_ascending#execute()<CR>", {remap = true})
vim.keymap.set({'n'}, "<Leader><Leader>X", "<cmd>call jupyter_ascending#execute_all()<CR>", {remap = true})
