return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
    end
  },
  {
    'williamboman/mason.nvim',
    opts = function()
      local path = require("mason-core.path")

      return {
        ui = {
          -- Whether to automatically check for new versions when opening the :Mason window.
          check_outdated_packages_on_open = true,

          -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
          border = "double",

          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },

          keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i", -- Install package under cursor
            update_package = "u", -- Reinstall/update package under cursor
            check_package_version = "c", -- Check package under cursor for new version
            update_all_packages = "U", -- Update all installed packages
            check_outdated_packages = "C", -- Check which packages are outdates
            uninstall_package = "X", -- Uninstall package under cursor
            cancel_installation = "<C-c>", -- Cancel package installation
            apply_language_filter = "<C-f>",
          },
        },

        -- The directory in which to install packages.
        install_root_dir = path.concat { vim.fn.stdpath("data"), "mason" },

        pip = {
          -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
          -- and is not recommended.
          --
          -- Example: { "--proxy", "https://proxyserver" }
          install_args = {},
        },

        -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
        -- debugging issues with package installations.
        log_level = vim.log.levels.INFO,

        -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
        -- packages that are requested to be installed will be put in a queue.
        max_concurrent_installers = 4,

        github = {
          -- The template URL to use when downloading assets from GitHub.
          -- The placeholders are the following (in order):
          -- 1. The repository (e.g. "rust-lang/rust-analyzer")
          -- 2. The release version (e.g. "v0.3.0")
          -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
          download_url_template = "https://github.com/%s/releases/download/%s/%s",
        },
      }
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {},
      automatic_installation = true,
    },
  },
}
