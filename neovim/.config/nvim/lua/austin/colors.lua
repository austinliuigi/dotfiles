-- Kitty Theme
vim.api.nvim_create_augroup('KittyTheme', {clear = true})



-- Gruvbox
vim.g.gruvbox_transp_bg = true

vim.api.nvim_create_autocmd('ColorScheme', {
  command = 'if (expand("<amatch>") ==# "gruvbox8") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Gruvbox Dark" | endif',
  group = 'KittyTheme',
  pattern = {'*'},
})

-- Nord
vim.g.nord_disable_background = true
vim.g.nord_borders = true

vim.api.nvim_create_augroup('NordBackground', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  command = 'if (expand("<amatch>") ==# "nord") && !g:nord_disable_background | silent hi Normal guibg=#2E3441 | endif',
  group = 'NordBackground',
  pattern = {'*'},
})

vim.api.nvim_create_autocmd('ColorScheme', {
  command = 'if (expand("<amatch>") ==# "nord") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Nord" | endif',
  group = 'KittyTheme',
  pattern = {'*'},
})

-- Tokyonight
vim.g.tokyonight_transparent = true

vim.api.nvim_create_autocmd('ColorScheme', {
  command = 'if (expand("<amatch>") ==# "tokyonight") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Tokyo Night Storm" | endif',
  group = 'KittyTheme',
  pattern = {'*'},
})

-- Toggle transparency mapping
vim.keymap.set('n', '<leader>ttr', function()
  if vim.g.colors_name == 'nord' then
    vim.g.nord_disable_background = not vim.g.nord_disable_background
    vim.cmd('colorscheme nord')
  elseif vim.g.colors_name == 'tokyonight' then
    vim.g.tokyonight_transparent = not vim.g.tokyonight_transparent
    vim.cmd('colorscheme tokyonight')
  elseif vim.g.colors_name == 'gruvbox8' then
    vim.g.gruvbox_transp_bg = not vim.g.gruvbox_transp_bg
    vim.cmd('colorscheme gruvbox8')
  end
end)
