local fn = vim.fn

-- Install packer if not already installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.glob(install_path) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load packer
vim.cmd("packadd packer.nvim")

return require('packer').startup({
  --[[ Plugins ]]
  function(use)
    -- Packer
    use { 'wbthomason/packer.nvim', opt = true }

    -- Impatient
    use 'lewis6991/impatient.nvim'

    -- Align
    -- use {
    --   'echasnovski/mini.align',
    --   config = [[require('austin.config.mini-align')]],
    -- }
    use {
      'junegunn/vim-easy-align',
      config = [[require('austin.config.easy-align')]],
      keys = { {'n', 'ga'}, {'x', 'ga'} },
    }

    -- Colors
    use {
        'ellisonleao/gruvbox.nvim',
        'shaunsingh/seoul256.nvim',
        { 'rose-pine/neovim', as = "rose-pine", },
        'EdenEast/nightfox.nvim',
        'rebelot/kanagawa.nvim',
        'shaunsingh/nord.nvim',
        'navarasu/onedark.nvim',
        'folke/tokyonight.nvim',
        'marko-cerovac/material.nvim',
        'Mofiqul/vscode.nvim',
        'tomasiser/vim-code-dark',
    }
    use {
      'NvChad/nvim-colorizer.lua',
      config = [[require('austin.config.colorizer')]],
    }
    use {
      'levouh/tint.nvim',
      config = [[require('austin.config.tint')]],
    }
    use {
      'uga-rosa/ccc.nvim',
      config = [[require('austin.config.ccc')]],
      cmd = "CccPick",
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = [[require('austin.config.comment')]],
      module = 'Comment',
      keys = { {'n', 'gc'}, {'n', 'gb'}, {'x', 'gc'}, {'x', 'gb'} },
    }

    -- Completion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        -- { 'amarakon/nvim-cmp-buffer-lines', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
        { 'rcarriga/cmp-dap', after = 'nvim-cmp' },
        -- { 'dmitmel/cmp-digraphs', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' }, -- Needed to load lspconfig
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      },
      config = [[require('austin.config.cmp')]],
      event = { 'InsertEnter', 'CmdlineEnter' },
    }

    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      setup = [[require('austin.setup.dap')]],
      config = [[require('austin.config.dap')]],
      module = 'dap',
    }
    use {
      'rcarriga/nvim-dap-ui',
      after = 'nvim-dap',
      requires = { 'mfussenegger/nvim-dap' },
      config = [[require('austin.config.dapui')]],
    }
    use {
      'theHamsta/nvim-dap-virtual-text',
      after = 'nvim-dap',
      requires = { 'mfussenegger/nvim-dap' },
      config = [[require('austin.config.dap-virtual-text')]],
    }

    -- Exploration
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      setup = [[require('austin.setup.nvim-tree')]],
      config = [[require('austin.config.nvim-tree')]],
      cmd = "NvimTreeToggle",
    }
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.*',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      },
      setup = [[require('austin.setup.telescope')]],
      config = [[require('austin.config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    }
    use {
      'echasnovski/mini.map',
      config = [[require("austin.config.mini-map")]]
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = [[require('austin.config.gitsigns')]],
    }
    use {
      'TimUntersberger/neogit',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'sindrets/diffview.nvim' },
      },
      config = [[require('austin.config.neogit')]],
      cmd = 'Neogit',
    }
    use {
      'sindrets/diffview.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
      },
      config = [[require('austin.config.diffview')]],
      cmd = { 'DiffviewOpen' }
    }
    -- use {
    --   'tpope/vim-fugitive',
    --   cmd = 'Git',
    -- }
    -- use {
    --   'rbong/vim-flog',
    --   requires = {
    --     { 'tpope/vim-fugitive' },
    --   },
    --   cmd = 'Flog',
    -- }
    use {
      'rhysd/committia.vim',
      config = [[require('austin.config.committia')]],
      -- ft = 'gitcommit',
    }

    -- Icons
    use {
      'kyazdani42/nvim-web-devicons',
      config = [[require('austin.config.devicons')]],
    }

    -- Images
    use {
      "narutoxy/silicon.lua",
      -- "~/.local/projects/neovim/forks/silicon.lua/",
      requires = { "nvim-lua/plenary.nvim" },
      config = [[require('austin.config.silicon')]],
    }

    -- LaTeX
    use {
      'jbyuki/nabla.nvim',
      config = [[require('austin.config.nabla')]],
    }

    -- LSP
    use {
      'williamboman/mason.nvim',
      config = [[require('austin.config.mason')]],
    }
    use {
      'williamboman/mason-lspconfig.nvim',
      after = { 'mason.nvim' },
      config = [[require('austin.config.mason-lspconfig')]],
    }
    use {
      'neovim/nvim-lspconfig',
      -- tag = "v0.1.*",
      after = { 'mason-lspconfig.nvim', 'cmp-nvim-lsp' },
      config = [[require('austin.config.lsp')]],
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      after = 'nvim-lspconfig',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('austin.config.null-ls')]],
    }
    use({
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      config = function()
        require("lsp_lines").setup()
      end,
    })
    use {
      'kosayoda/nvim-lightbulb',
      requires = {
        {
          'antoinemadec/FixCursorHold.nvim',
          config = [[vim.g.cursorhold_updatetime = 100]]
        },
      },
      config = [[require('austin.config.lightbulb')]],
    }
    use {
      'RRethy/vim-illuminate',
      config = [[require('austin.config.illuminate')]],
    }
    use {
      'SmiteshP/nvim-navic',
      requires = { 'neovim/nvim-lspconfig' },
      config = [[require('austin.config.navic')]],
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      -- setup = [[vim.g.mkdp_filetypes = { "markdown" }]],
      ft = { "markdown" },
      run = "cd app && npm install",
    }

    -- Marks
    use {
      'kshenoy/vim-signature',
      config = [[require('austin.config.signature')]],
    }

    -- Motions/Text Objects/Operators
    use {
      'ggandor/leap.nvim',
      requires = { 'ggandor/leap-spooky.nvim' },
      config = [[require('austin.config.leap')]],
    }
    use {
      'chaoren/vim-wordmotion',
      config = [[require('austin.config.wordmotion')]],
    }
    use {
      'austinliuigi/staticyank.vim'
    }

    -- Org
    use {
      "nvim-neorg/neorg",
      tag = '*',
      after = "nvim-treesitter",
      requires = { "nvim-lua/plenary.nvim" },
      config = [[require('austin.config.neorg')]],
      ft = "norg",
      cmd = "Neorg",
      run = ':if exists(":Neorg") | execute "Neorg sync-parsers" | endif',
    }

    -- Pairs
    use 'andymass/vim-matchup'
    use {
      'windwp/nvim-autopairs',
      after = 'nvim-cmp', -- config includes nvim-cmp options for function parentheses completion
      config = [[require('austin.config.autopairs')]],
    }
    use {
      'windwp/nvim-ts-autotag',
      config = [[require('nvim-ts-autotag').setup()]],
      event = 'InsertEnter',
    }
    use {
      'machakann/vim-sandwich',
      requires = { 'tpope/vim-repeat' },
      setup = [[require('austin.setup.sandwich')]],
      config = [[require('austin.config.sandwich')]],
      keys = { {'n', 'gs'}, {'n','ds'}, {'n','cs'}, {'x', 'gs'} },
    }
    -- use 'p00f/nvim-ts-rainbow'

    -- Performance
    -- use {
    --   'tweekmonster/startuptime.vim',
    --   cmd = 'StartupTime',
    -- }
    use {
      'dstein64/vim-startuptime',
      config = [[vim.g.startuptime_tries = 10]],
      cmd = 'StartupTime',
    }

    -- Registers
    use {
      'tversteeg/registers.nvim',
      config = [[require('austin.config.registers')]],
      keys = { {'n','"'}, {'x','"'},{'i','<C-r>'} }
    }

    -- REPL
    use {
      'hkupty/iron.nvim',
      config = [[require('austin.config.iron')]],
      cmd = 'IronRepl',
    }
    use {
      'untitled-ai/jupyter_ascending.vim',
      config = [[require('austin.config.jupyter_ascending')]],
    }

    -- Scrolling
    use {
      'psliwka/vim-smoothie',
      config = [[require("austin.config.smoothie")]],
      commit = '10fd0aa',
      keys = { {'n','<C-d>'}, {'n','<C-u>'}, {'n','<C-f>'}, {'n','<C-b>'} },
    }

    -- Search
    use {
      'junegunn/vim-slash',
      config = [[require('austin.config.slash')]],
    }

    -- Sessions
    use {
      'ethanholz/nvim-lastplace',
      config = [[require('austin.config.lastplace')]],
    }

    -- Snippets
    use {
      'L3MON4D3/LuaSnip',
      tag = "v1.*",
      event = 'InsertEnter',
      config = [[require('austin.config.luasnip')]],
      cmd = "LuaSnipEdit",
    }

    -- Statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[require('austin.config.lualine')]],
    }
    use {
      'austinliuigi/tinbar.nvim',
      config = [[require('austin.config.tinbar')]],
    }

    -- Sugar
    use {
      'tpope/vim-eunuch',
      cmd = { "Remove", "Delete", "Copy", "Duplicate", "Move", "Rename", "Chmod", "Mkdir", "Cfind", "Lfind", "Clocate", "Llocate", "Wall", },
    }

    -- Terminal
    use {
      'numToStr/FTerm.nvim',
      config = [[require('austin.config.fterm')]],
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = [[require('austin.config.treesitter')]],
      run = 'require("nvim-treesitter.install").update({ with_sync = true })',
    }
    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = "nvim-treesitter/nvim-treesitter",
      after = "nvim-treesitter",
      config = [[require('austin.config.treesitter-textobjects')]],
    }
    use {
      'nvim-treesitter/playground',
      requires = "nvim-treesitter/nvim-treesitter",
      config = [[require('austin.config.treesitter-playground')]],
    }

    -- UI
    use {
      'goolord/alpha-nvim',
      config = [[require('austin.config.alpha')]],
    }
    use {
      'folke/noice.nvim',
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = [[require('austin.config.noice')]],
    }
    use({
      'https://gitlab.com/yorickpeterse/nvim-pqf.git',
      config = function()
        require('pqf').setup()
      end,
    })
    use {
      'lukas-reineke/headlines.nvim',
      requires = "nvim-treesitter/nvim-treesitter",
      after = "nvim-treesitter",
      config = [[require('austin.config.headlines')]],
    }
    use {
      'lukas-reineke/virt-column.nvim',
      config = function()
        require('virt-column').setup({char = "┃", virtcolumn = "+1"})
      end,
    }

    -- Undo
    use {
      'simnalamburt/vim-mundo',
      setup = [[require('austin.setup.mundo')]],
      config = [[require('austin.config.mundo')]],
      cmd = 'MundoToggle',
    }

    -- Whitespace
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = [[require('austin.config.indent-blankline')]],
    }

    -- Zoom
    -- use {
    --   'dhruvasagar/vim-zoom',
    --   config = [[require('austin.config.zoom')]],
    -- }

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  --[[ Config ]]
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    max_jobs = 50,
  }
})
