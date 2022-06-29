require('incline').setup {
  window = {
    placement = {
      vertical = 'top',
      horizontal = 'right'
    },
    margin = {
      vertical = 0
    }
  },
  render = function(props)
    local filepath = vim.api.nvim_buf_get_name(props.buf)
    local filename = vim.fn.fnamemodify(filepath, ':t')
    local fileext = vim.fn.fnamemodify(filepath, ':e')
    return {
      { require('nvim-web-devicons').get_icon(filename, fileext), group = "Type" },
      props.focused and { ' '..filename, gui = vim.o.modified and 'bold,italic' or 'bold' } or ' '..filename,
      vim.o.modified and { ' *', guifg = '#e0af68', gui = 'italic' } or ''
    }
  end
}
