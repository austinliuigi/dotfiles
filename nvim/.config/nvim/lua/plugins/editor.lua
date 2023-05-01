return {
  {
    'andymass/vim-matchup'
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
      { 's', function() require('leap').leap({ offset = 0, inclusive_op = true }) end, mode = {'x'--[[ , 'o' ]]} },
      { 'S', function() require('leap').leap({ offset = 0, inclusive_op = true, backward = true }) end, mode = {'x'--[[ , 'o' ]]} },
      { 'x', function() require('leap').leap({ offset = -1, inclusive_op = true }) end, mode = {'x'--[[ , 'o' ]]} },
      { 'X', function() require('leap').leap({ offset = 1, inclusive_op = true, backward = true }) end, mode = {'x'--[[ , 'o' ]]} },
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
    keys = {
      { "ga", "<Plug>(LiveEasyAlign)", mode = {"n", "x"}}
    }
  },
  {
    'kylechui/nvim-surround',
    keys = {
      {"gs", mode = {"n", "x"}},
      {"gS", mode = {"n", "x"}},
      {"ds", mode = {"n"}},
      {"cs", mode = {"n"}},
    },
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
        delete = "ds",
        change = "cs",
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
    config = function()
      vim.keymap.set("n", toggle_key.."s", function()
        vim.g.smoothie_enabled = not vim.g.smoothie_enabled
      end, {})
    end
  },
  {
    'austinliuigi/lasso.nvim',
    -- dir = '~/tin/projects/neovim/personal/lasso.nvim/',
    keys = {
      {"y"}
    },
    config = function()
      require("lasso").setup()
    end
  },
  {
    "austinliuigi/silicon.lua",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { '<leader>y', function() require("silicon").visualise_api({to_clip = true}) end, mode = {'x'} },
    },
    opts = {
      theme = "auto",
      output = "SILICON_${year}-${month}-${date}_${time}.png",
      bgColor = "#fff0",
      bgImage = "", -- path to image, must be png
      roundCorner = true,
      windowControls = true,
      lineNumber = true,
      font = "monospace",
      lineOffset = 1, -- from where to start line number
      linePad = 2, -- padding between lines
      padHoriz = 80, -- Horizontal padding
      padVert = 100, -- vertical padding
      shadowBlurRadius = 15,
      shadowColor = "#444444",
      shadowOffsetX = 8,
      shadowOffsetY = 8,
      gobble = false, -- enable lsautogobble like feature
      debug = true, -- enable debug output
    }
  },
  {
    'simnalamburt/vim-mundo',
    keys = {
      { "_", "<cmd>MundoToggle<CR>", mode = {"n"} }
    },
    cmd = "MundoToggle",
    config = function()
      vim.g.mundo_preview_bottom = 1  -- Force preview window to be below windows instead of below graph
      vim.g.mundo_mappings = {
        ['<nowait> <CR>'] = 'preview',
        ['<nowait> o'] = 'preview',
        ['<nowait> J'] = 'move_older_write',
        ['<nowait> K'] = 'move_newer_write',
        ['<nowait> gg'] = 'move_top',
        ['<nowait> G'] = 'move_bottom',
        ['<nowait> P'] = 'play_to',
        ['<nowait> d'] = 'diff',
        ['<nowait> i'] = 'toggle_inline',
        ['<nowait> /'] = 'search',
        ['<nowait> n'] = 'next_match',
        ['<nowait> N'] = 'previous_match',
        ['<nowait> p'] = 'diff_current_buffer',
        ['<nowait> r'] = 'rdiff',
        ['<nowait> ?'] = 'toggle_help',
        ['<nowait> q'] = 'quit',
        ['<nowait> <2-LeftMouse>'] = 'mouse_click',
        ['<nowait> j'] = 'move_older',
        ['<nowait> k'] = 'move_newer',
        ['<nowait> <Down>'] = 'move_older',
        ['<nowait> <Up>'] = 'move_newer'
      }
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")

      local term_bg = os.getenv('TERM') == 'xterm-kitty' and vim.fn.system("awk '$1 ~ /^background$/ {print $2}' ~/.config/kitty/current-theme.conf") or "#000000"
      require("notify").setup {
        background_colour = term_bg
      }
    end
  },
  {
    'willothy/flatten.nvim',
    priority = 1001, -- ensure that it runs first to minimize delay when opening file from terminal
    config = function()
      require("flatten").setup({
        window = {
          open = "tab",
          focus = "first",
        }
      })
    end
  },
}
