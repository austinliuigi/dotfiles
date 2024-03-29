return {
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup(
        -- Add filetypes as first parameter
        -- { '*' },
        -- Use default_options as second parameter
        { mode = 'background' }
      )
      vim.keymap.set("n", toggle_key.."C", "<cmd>ColorizerToggle<CR>", {noremap = true, silent = true})
    end
  },
}
