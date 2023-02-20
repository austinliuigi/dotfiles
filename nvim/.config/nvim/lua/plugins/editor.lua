return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {
      load = {
        ["core.defaults"] = {
          config = {}
        },

        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = "\\",
            }
        },

        ["core.norg.concealer"] = {
          config = { -- Note that this table is optional and doesn't need to be provided
            icon_preset = "diamond",
            -- icons = nil,
            -- dim_code_blocks = nil,
            content_only = true,
            adaptive = true,
            width = "fullwidth",
            -- padding = nil,
            conceal = true,
          }
        },

        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },

        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              gtd = "~/.local/gtd",
            },
          },
        },

        ["core.export"] = {
          config = {
            export_dir = "<export-dir>/<language>-export"
          }
        },

        ["core.export.markdown"] = {
          config = {
            extensions = "all"
          }
        }

        -- ["core.gtd.base"] = {
        --   config = {
        --     workspace = "gtd",
        --   },
        -- },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      -- See :help oil-columns
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
      -- Restore window options to previous values when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = false,
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        -- ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        -- ["<C-p>"] = "actions.preview",
        -- ["<C-c>"] = "actions.close",
        -- ["<C-l>"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        -- ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
    }
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', '<Plug>(leap-forward-to)', mode = {'n'} },
      { 'S', '<Plug>(leap-backward-to)', mode = {'n'} },
      { 's', function() require('leap').leap({ offset = 0, inclusive_op = true }) end, mode = {'x', 'o'} },
      { 'S', function() require('leap').leap({ offset = 0, inclusive_op = true, backward = true }) end, mode = {'x', 'o'} },
      { 'x', function() require('leap').leap({ offset = -1, inclusive_op = true }) end, mode = {'x', 'o'} },
      { 'X', function() require('leap').leap({ offset = 1, inclusive_op = true, backward = true }) end, mode = {'x', 'o'} },
    },
    config = function()
      local leap = require("leap")
      leap.opts.max_phase_one_targets = nil
      leap.opts.highlight_unlabeled_phase_one_targets = false
      leap.opts.max_highlighted_traversal_targets = 10
      leap.opts.case_sensitive = false
      leap.opts.equivalence_classes = {
        '\r\n',
        '`~', '1!', '2@', '3#', '4$', '5%', '6^', '7&', '8*', '9(', '0)', '-_', '=+',
        '[{', ']}', '\\|', ';:', '\'"', ',<', '.>', '/?',
      }
      leap.opts.safe_labels = {}
      leap.opts.special_keys = {
        repeat_search = '<C-CR>',
        next_phase_one_target = '<C-n>', -- go to next target in phase 1 (after pressing <char1>)
        next_target = '<C-n>', -- go to next target in phase 2 (after pressing <char2>)
        prev_target = '<C-p>', -- reverse last "next_phase_one_target or next target" jump
        next_group = '<Tab>',
        prev_group = '<S-Tab>',
        multi_accept = '',
        multi_revert = '',
      }

      vim.api.nvim_create_augroup("LeapHighlights", {clear = true})
      vim.api.nvim_create_autocmd({ "Colorscheme" }, {
        group   = "LeapHighlights",
        pattern = {'*'},
        callback = function()
          -- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { link = "Search" })
          vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = "Comment" })
        end,
      })
      vim.api.nvim_exec_autocmds("Colorscheme", {group = "LeapHighlights"})
    end
  },
  {
    'ggandor/leap-spooky.nvim',
    event = "VeryLazy",
    dependencies = {
      'ggandor/leap.nvim',
    },
    opts = {
      affixes = {
        remote   = { window = 'r', cross_window = 'R' },
        magnetic = { window = 'm', cross_window = 'M' },
      },
      paste_on_remote_yank = false,
    }
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set('n', 'ga', '<Plug>(LiveEasyAlign)', {noremap = true})
      vim.keymap.set('x', 'ga', '<Plug>(LiveEasyAlign)', {noremap = true})
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { "gc", mode = {"n", "x"}},
      { "gb", mode = {"n", "x"}},
      { "gC", ":<C-b>keeppatterns <C-e>g/./lua require('Comment.api').toggle.linewise.current()<CR>", mode = {"x"} }
    },
    config = function()
      require("Comment").setup({
        padding = true, ---Add a space b/w comment and the line
        sticky = true, ---Whether the cursor should stay at its position
        ignore = nil, ---Lines to be ignored while (un)comment
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
            line = 'gcc',
            block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            line = 'gc',
            block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
            above = 'gcO',
            below = 'gco',
            eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            ---Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), ---Function to call before (un)comment
        post_hook = nil, ---Function to call after (un)comment
      })
    end
  },
  {
    'kylechui/nvim-surround',
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "gs",
        normal_cur = false,
        normal_line = "gS",
        normal_cur_line = "gss",
        visual = "gs",
        visual_line = "gS",
        delete = "dz",
        change = "cz",
    },
      surrounds = {},
      aliases = {},
      highlight = {
        duration = 0
      },
      move_cursor = false,
    },
  },
  {
    'chaoren/vim-wordmotion',
    init = function()
      vim.g.wordmotion_prefix = '<Space>'
    end
  },
  {
    'psliwka/vim-smoothie',
  },
  {
    'austinliuigi/lasso.nvim',
    -- dir = '~/tin/projects/neovim/personal/lasso.nvim/',
    config = function()
      require("lasso").setup()
    end
  },
}
