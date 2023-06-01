  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = {"*"},
    callback = function()
      if vim.o.buftype == "terminal" then
        vim.cmd("startinsert")
      end
    end
  })
