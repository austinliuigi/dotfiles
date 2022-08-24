vim.g.Illuminate_delay = 0
vim.g.Illuminate_ftblacklist = { '' }

vim.fn['illuminate#disable_illumination'](0)
vim.keymap.set("n", "<leader>til", "<cmd>IlluminationToggle<CR>", {noremap = true, silent = true})
