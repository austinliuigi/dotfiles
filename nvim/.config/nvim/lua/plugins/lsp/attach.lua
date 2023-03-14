local diagnostic_config = require("plugins.lsp.diagnostics")

function toggle_diagnostics()
  local prev_underline = diagnostic_config.underline
  local prev_text = diagnostic_config.virtual_text
  local prev_lines = diagnostic_config.virtual_lines

  diagnostic_config.underline = not (prev_underline or prev_text or prev_lines)
  diagnostic_config.virtual_text = prev_underline
  diagnostic_config.virtual_lines = prev_text

  vim.diagnostic.config(diagnostic_config)
end

function on_attach(client, bufnr)
  local bufopts = { remap = false, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', toggle_key..'d', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', toggle_key..'D', toggle_diagnostics, bufopts)

  -- require("nvim-navic").attach(client, bufnr)
end

return on_attach
