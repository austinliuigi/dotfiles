require('telescope').setup {
  defaults = {
    prompt_prefix = 'ᛋ ',
    selection_caret = '❯ ',
    mappings = {
      n = {
        ['q'] = 'close';
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

-- Mappings
vim.keymap.set({'n'}, '<leader>fac', '<cmd>lua require("telescope.builtin").autocommands()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fc', '<cmd>lua require("telescope.builtin").commands()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>ff', '<cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fgc', '<cmd>lua require("telescope.builtin").git_commits()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fgf', '<cmd>lua require("telescope.builtin").git_files()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fgs', '<cmd>lua require("telescope.builtin").git_status()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fhi', '<cmd>lua require("telescope.builtin").highlights()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fhc', '<cmd>lua require("telescope.builtin").command_history()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fht', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fh/', '<cmd>lua require("telescope.builtin").search_history()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fm', '<cmd>lua require("telescope.builtin").man_pages()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>fo', '<cmd>lua require("telescope.builtin").vim_options()<CR>', { noremap = true, silent = true })
vim.keymap.set({'n'}, '<leader>f/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', { noremap = true, silent = true })
