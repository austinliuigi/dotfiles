require('colorizer').setup(
  -- Add filetypes as first parameter
  -- { '*' },
  -- Use default_options as second parameter
  { mode = 'background' }
)

vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<CR>", {noremap = true, silent = true})
