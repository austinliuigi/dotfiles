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

    -- Align
    use {
      'junegunn/vim-easy-align',
      config = [[require('austin.config.easy-align')]]
    }

    -- Colors
    use 'lifepillar/vim-gruvbox8'
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use {
      'xiyaowong/nvim-colorizer.lua',
      config = [[require('austin.config.colorizer')]]
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = [[require('austin.config.comment')]]
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

    -- Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('austin.config.nvimtree')]]
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = [[require('austin.config.gitsigns')]]
    }

    -- Highlighting
    use {
      'junegunn/vim-slash',
      config = vim.keymap.set('n', '<Plug>(slash-after)', '"zz"..slash#blink(3, 65)', {noremap = true, expr = true})
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
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" }
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
      config = [[require('austin.config.autopairs')]]
    }
    use 'andymass/vim-matchup'
    use {
      'machakann/vim-sandwich',
      requires = { 'tpope/vim-repeat' },
      config = [[require('austin.config.sandwich')]]
    }
    use 'p00f/nvim-ts-rainbow'

    -- Scrolling
    use {
      'psliwka/vim-smoothie',
      commit = '10fd0aa'
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

    -- Undo
    use {
      'simnalamburt/vim-mundo',
      config = [[require('austin.config.mundo')]]
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
