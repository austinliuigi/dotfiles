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
      keys = { 'ga' }
    }

    -- Colors
    use 'lifepillar/vim-gruvbox8'
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use {
      'NvChad/nvim-colorizer.lua',
      config = [[require('austin.config.colorizer')]]
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = [[require('austin.config.comment')]],
      keys = { 'gc', 'gb' }
    }

    -- Completion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
      },
      config = [[require('austin.config.cmp')]],
      -- after = 'LuaSnip',
      event = { 'InsertEnter', 'CmdlineEnter' }
    }

    -- Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('austin.config.nvimtree')]]
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

    -- Highlighting
    -- Icons
    use {
      'junegunn/vim-slash',
      config = vim.keymap.set('n', '<Plug>(slash-after)', '"zz"..slash#blink(3, 65)', {noremap = true, expr = true})
      'kyazdani42/nvim-web-devicons',
      config = [[require('austin.config.devicons')]],
    }

    -- LSP & Linting
    use {
      'williamboman/nvim-lsp-installer',
      {
        'RRethy/vim-illuminate',
        config = [[require('austin.config.illuminate')]]
      },
      {
        'neovim/nvim-lspconfig',
        after = { 'nvim-lsp-installer', 'cmp-nvim-lsp' },
        config = [[require('austin.config.lsp')]]
      },
      -- {
      --   'kosayoda/nvim-lightbulb',
      --   requires = 'antoinemadec/FixCursorHold.nvim',
      --   config = [[require('austin.config.lightbulb']]
      -- },
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = [[vim.g.mkdp_filetypes = { "markdown" }]],
      ft = { "markdown" },
    }

    -- Marks
    use {
      'kshenoy/vim-signature',
      config = [[require('austin.config.signature')]]
    }

    -- Motions
    use {
      'chaoren/vim-wordmotion',
      config = [[require('austin.config.wordmotion')]]
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

    -- Profiling
    use {
      'dstein64/vim-startuptime',
      config = [[vim.g.startuptime_tries = 10]],
      cmd = 'StartupTime'
    }

    -- Scrolling
    use {
      'psliwka/vim-smoothie',
      commit = '10fd0aa',
      keys = { {'n','<C-d>'}, {'n','<C-u>'}, {'n','<C-f>'}, {'n','<C-b>'} }
    -- Sessions
    use {
      'ethanholz/nvim-lastplace',
      config = [[require('austin.config.lastplace')]],
    }

    -- Snippets
    use {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter'
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

    -- Telescope
    -- Terminal
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      },
      config = [[require('austin.config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
      keys = { '<Space>f' }
      'numToStr/FTerm.nvim',
      config = [[require('austin.config.fterm')]],
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = [[require('austin.config.treesitter')]],
      run = ':TSUpdate'
    -- UI
    use {
      'goolord/alpha-nvim',
      config = [[require('austin.config.alpha')]],
    }
    }

    -- Undo
    use {
      'simnalamburt/vim-mundo',
      config = [[require('austin.config.mundo')]],
      cmd = 'MundoToggle'
    }

    -- Whitespace
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = [[require('austin.config.indent-blankline')]]
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
