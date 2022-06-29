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

    -- Colorschemes
    use 'folke/tokyonight.nvim'
    use 'shaunsingh/nord.nvim'

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      },
      config = [[require('austin.config.telescope')]]
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = [[require('austin.config.treesitter')]],
      run = ':TSUpdate'
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

    -- Completion & Snippets
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'L3MON4D3/LuaSnip',
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
      },
      config = [[require('austin.config.cmp')]],
      -- event = 'InsertEnter,CmdlineEnter *'
    }

    -- Statusline
    use {
      'b0o/incline.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('austin.config.incline')]]
    }

    -- Motions
    use {
      'chaoren/vim-wordmotion',
      config = [[require('austin.config.wordmotion')]]
    }

    -- Pairs
    use {
      'windwp/nvim-autopairs',
      config = [[require('austin.config.autopairs')]]
    }
    use {
      'machakann/vim-sandwich',
      requires = { 'tpope/vim-repeat' },
      config = [[require('austin.config.sandwich')]]
    }
    use 'andymass/vim-matchup'

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = [[require('austin.config.comment')]]
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = [[require('austin.config.gitsigns')]]
    }

    -- Whitespace
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = [[require('austin.config.indent-blankline')]]
    }

    -- Marks
    use 'kshenoy/vim-signature'

    -- Scrolling
    use {
      'declancm/cinnamon.nvim',
      config = [[require('austin.config.cinnamon')]]
    }

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
