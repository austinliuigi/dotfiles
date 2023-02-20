return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>' },
      { '<leader>fcmd', '<cmd>lua require("telescope.builtin").commands()<CR>' },
      { '<leader>fca', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
      { '<leader>ff', '<cmd>lua require("telescope.builtin").find_files({hidden = true, follow=true})<CR>' },
      { '<leader>fgc', '<cmd>lua require("telescope.builtin").git_commits()<CR>' },
      { '<leader>fgf', '<cmd>lua require("telescope.builtin").git_files()<CR>' },
      { '<leader>fgs', '<cmd>lua require("telescope.builtin").git_status()<CR>' },
      { '<leader>fhi', '<cmd>lua require("telescope.builtin").highlights()<CR>' },
      { '<leader>fhc', '<cmd>lua require("telescope.builtin").command_history()<CR>' },
      { '<leader>fht', '<cmd>lua require("telescope.builtin").help_tags()<CR>' },
      { '<leader>fh/', '<cmd>lua require("telescope.builtin").search_history()<CR>' },
      { '<leader>fm', '<cmd>lua require("telescope.builtin").man_pages()<CR>' },
      { '<leader>fo', '<cmd>lua require("telescope.builtin").vim_options()<CR>' },
      { '<leader>f/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
      { '<leader>f*', '<cmd>lua require("telescope.builtin").builtin()<CR>' },
      { '<C-/>', '<cmd>lua require("telescope.builtin").builtin()<CR>' },
    },
    config = function()
      local vimgrep_arguments = require("telescope.config").values.vimgrep_arguments
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      require('telescope').setup({
        defaults = {
          prompt_prefix = 'ᛋ ',
          selection_caret = '❯ ',
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            n = {
              ['q'] = 'close',
              ['<C-w><C-l>'] = require('telescope.actions').select_vertical
            }
          }
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" }
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          }
        }
      })

      require('telescope').load_extension('fzf')

      vim.api.nvim_create_augroup("TelescopeHighlights", {clear = true})
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        group   = "TelescopeHighlights",
        pattern = {'*'},
        callback = function()
          -- vim.api.nvim_set_hl(0, "TelescopeMatching", {underline = true})
          vim.api.nvim_set_hl(0, "TelescopeMatching", {link = "Type"})
        end,
      })
      vim.api.nvim_exec_autocmds("ColorScheme", {group = "TelescopeHighlights"})
    end
  }
}