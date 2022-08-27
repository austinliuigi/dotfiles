require("indent_blankline").setup {
  show_current_context = true, -- color line cursor is in differently
  show_current_context_start = false, -- underline beginning of context
  show_end_of_line = true, -- show eol char
}

vim.api.nvim_create_augroup('IndentBlanklineCustomHighlight', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'IndentBlanklineCustomHighlight',
  pattern = {'*'},
  command = 'hi! link IndentBlanklineContextChar Type',
})
