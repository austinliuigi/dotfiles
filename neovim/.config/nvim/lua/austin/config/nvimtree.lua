require('nvim-tree').setup {
  -- auto_close = true,
  hijack_cursor = false,
  ignore_ft_on_setup = { "alpha" },
  sort_by = "case_sensitive",
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none"
  },
  view = {
    adaptive_size = true,
    relativenumber = true,
    height = 30,
    width = 30,
    mappings = {
      list = {
        { key = 'c',     action = 'create' },
        { key = 'f',     action = 'search_node' },
        { key = 'h',     action = 'close_node' },
        { key = 'l',     action = 'edit' },
        { key = 'y',     action = 'copy_path' },
        { key = 'Y',     action = 'copy_absolute_path' },
        { key = '<C-y>', action = 'copy' },
        { key = '?',     action = 'toggle_help' }
      },
    },
  },
}

vim.keymap.set("n", "<leader>te", "<cmd>NvimTreeToggle<CR>", {noremap = true, silent = true})
