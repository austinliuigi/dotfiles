local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = false
  }
}

-- vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
