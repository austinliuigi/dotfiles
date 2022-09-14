vim.api.nvim_create_augroup("NvimTreeLazyLoad", {clear = true})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group   = "NvimTreeLazyLoad",
  pattern = "*",
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand('%')) == 1 then
      vim.cmd("NvimTreeToggle %")
      vim.api.nvim_clear_autocmds({group = "NvimTreeLazyLoad"})
    end
  end
})

vim.keymap.set("n", "<leader>te", "<cmd>NvimTreeToggle<CR>", {noremap = true, silent = true})
