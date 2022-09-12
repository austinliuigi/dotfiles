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
    use {
      'junegunn/vim-easy-align',
      config = [[require('austin.config.easy-align')]],
      keys = { 'ga' },
    }

    -- Colors
    use 'lifepillar/vim-gruvbox8'
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use {
      'NvChad/nvim-colorizer.lua',
      config = [[require('austin.config.colorizer')]],
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = [[require('austin.config.comment')]],
      keys = { 'gc', 'gb' },
    }

    -- Completion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' }, -- Needed to load lspconfig
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'rcarriga/cmp-dap', after = 'nvim-cmp' },
        { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        -- { 'dmitmel/cmp-digraphs', after = 'nvim-cmp' },
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
      requires = { 'mfussenegger/nvim-dap' },
      config = [[require('austin.config.dapui')]],
      after = 'nvim-dap',
    }
    use {
      'theHamsta/nvim-dap-virtual-text',
      requires = { 'mfussenegger/nvim-dap' },
      config = [[require('austin.config.dap-virtual-text')]],
      after = 'nvim-dap',
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
      branch = '0.1.x',
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

    -- LSP
    use {
      'williamboman/mason.nvim',
      config = [[require('austin.config.mason')]],
    }
    use {
      'williamboman/mason-lspconfig.nvim',
      config = [[require('austin.config.mason-lspconfig')]],
      after = { 'mason.nvim' },
    }
    use {
      'neovim/nvim-lspconfig',
      after = { 'mason-lspconfig.nvim', 'cmp-nvim-lsp' },
      config = [[require('austin.config.lsp')]],
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('austin.config.null-ls')]],
      after = 'nvim-lspconfig',
    }
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
      requires = 'neovim/nvim-lspconfig',
      config = [[require('austin.config.navic')]],
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      -- setup = [[vim.g.mkdp_filetypes = { "markdown" }]],
      ft = { "markdown" },
    }

    -- Marks
    use {
      'kshenoy/vim-signature',
      config = [[require('austin.config.signature')]],
    }

    -- Motions/Text Objects
    use {
      'chaoren/vim-wordmotion',
      config = [[require('austin.config.wordmotion')]],
    }

    -- Pairs
    use {
      'windwp/nvim-autopairs',
      config = [[require('austin.config.autopairs')]],
      after = 'nvim-cmp'
    }
    use 'andymass/vim-matchup'
    use {
      'machakann/vim-sandwich',
      requires = { 'tpope/vim-repeat' },
      config = [[require('austin.config.sandwich')]],
      keys = { 'gs', {'n','ds'}, {'n','cs'} }
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
    }

    -- Scrolling
    use {
      'psliwka/vim-smoothie',
      commit = '10fd0aa',
      keys = { {'n','<C-d>'}, {'n','<C-u>'}, {'n','<C-f>'}, {'n','<C-b>'} },
    }

    -- Search
    use {
      'junegunn/vim-slash',
      config = vim.keymap.set('n', '<Plug>(slash-after)', '"zz"..slash#blink(3, 65)', {noremap = true, expr = true}),
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
    }

    -- Statusline
    use {
      {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = [[require('austin.config.lualine')]]
      },
      {
        'b0o/incline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[require('austin.config.incline')]]
      }
    }
    -- use {
    --   'b0o/incline.nvim',
    --   requires = { 'kyazdani42/nvim-web-devicons' },
    --   config = [[require('austin.config.incline')]],
    -- }

    -- Terminal
    use {
      'numToStr/FTerm.nvim',
      config = [[require('austin.config.fterm')]],
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = [[require('austin.config.treesitter')]],
      run = ':TSUpdate',
    }

    -- UI
    use {
      'goolord/alpha-nvim',
      config = [[require('austin.config.alpha')]],
    }
    }
    -- use {
    --   'akinsho/bufferline.nvim',
    --   tag = "v2.*",
    --   requires = 'kyazdani42/nvim-web-devicons',
    --   config = [[require('austin.config.bufferline')]],
    -- }

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
    --   config = [[require('austin.config.zoom')]]
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
    }
  }
})
