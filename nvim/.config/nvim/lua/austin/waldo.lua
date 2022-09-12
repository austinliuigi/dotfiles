local ns = vim.api.nvim_create_namespace('evenoddlines')

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function()
  end,
  on_line = function(_, winid, buf, row)
    -- If window is not floating and has number or relativenumber
    if not vim.api.nvim_win_get_config(winid).zindex and (vim.api.nvim_win_get_option(winid, "relativenumber") or vim.api.nvim_win_get_option(winid, "number")) then
      -- Add highlight to even lines
      if row % 2 == 1 then -- Note: row is 0-based, so line 1 is row 0
        vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
          end_row = row + 1,
          hl_group = 'LineEven',
          hl_eol = true,
          ephemeral = true
        })
      end
    end
  end
})

-- Set lineeven highlight after changing colorschemes
vim.api.nvim_create_augroup("AlternatingHighlights", {clear = true})
vim.api.nvim_create_autocmd("ColorScheme", {
  group   = "AlternatingHighlights",
  pattern = {'*'},
  callback = function()
    if vim.g.colors_name == "gruvbox8" then
      vim.api.nvim_set_hl(0, "LineEven", { bg = "#313131" })
    elseif vim.g.colors_name == "nord" then
      vim.api.nvim_set_hl(0, "LineEven", { bg = "#373F4E" })
    end
  end
})
