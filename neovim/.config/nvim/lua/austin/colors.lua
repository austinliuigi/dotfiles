-- Kitty Theme
vim.api.nvim_create_augroup('SetKittyTheme', {clear = true})

-- Gruvbox
vim.g.gruvbox_transp_bg = true

vim.api.nvim_create_augroup('GruvboxBackground', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'GruvboxBackground',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "gruvbox8") && !g:gruvbox_transp_bg | silent hi Normal guibg=#282829 | endif',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetKittyTheme',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "gruvbox8") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Gruvbox Dark" | endif',
})

-- Nord
vim.g.nord_disable_background = true
vim.g.nord_borders = true

vim.api.nvim_create_augroup('NordBackground', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'NordBackground',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "nord") && !g:nord_disable_background | silent hi Normal guibg=#2E3441 | endif',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetKittyTheme',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "nord") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Nord" | endif',
})

-- Tokyonight
vim.g.tokyonight_transparent = true

vim.api.nvim_create_augroup('TokyoNightBackground', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'TokyoNightBackground',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "tokyonight") && !g:tokyonight_transparent | silent hi Normal guibg=#24283C | endif',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetKittyTheme',
  pattern = {'*'},
  command = 'if (expand("<amatch>") ==# "tokyonight") && ($TERM ==# "xterm-kitty") | execute "silent !kitty +kitten themes --reload-in=all Tokyo Night Storm" | endif',
})

--[[ Global SignColumn Highlight ]]
vim.api.nvim_create_augroup('SignColumnHL', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SignColumnHL',
  pattern = {'*'},
  command = 'hi! link SignColumn Normal',
})

--[[ Toggle transparency mapping ]]
vim.keymap.set('n', '<leader>ttr', function()
  if vim.g.colors_name == 'nord' then
    vim.g.nord_disable_background = not vim.g.nord_disable_background
    -- vim.cmd('colorscheme nord')
  elseif vim.g.colors_name == 'tokyonight' then
    vim.g.tokyonight_transparent = not vim.g.tokyonight_transparent
    -- vim.cmd('colorscheme tokyonight')
  elseif vim.g.colors_name == 'gruvbox8' then
    vim.g.gruvbox_transp_bg = not vim.g.gruvbox_transp_bg
    -- vim.cmd('colorscheme gruvbox8')
  end
  vim.cmd('colorscheme ' .. vim.g.colors_name)
end)

--[[ Initial Colorscheme ]]
local kitty_theme = os.getenv('TERM') == 'xterm-kitty' and vim.fn.trim(vim.fn.system("awk '/name/ {print substr($0, index($0,$3))}' ~/.config/kitty/current-theme.conf")) or nil
-- print(kitty_theme)
local kitty_to_nvim = { ['Nord'] = 'nord', ['Tokyo Night Storm' ]= 'tokyonight', ['Gruvbox Dark' ]= 'gruvbox8' }
-- print(kitty_to_nvim[kitty_theme])

local function InitialColorschemeFunc()
  if kitty_theme ~= nil then
    vim.cmd('colorscheme ' .. kitty_to_nvim[kitty_theme])
  else
    vim.cmd('nord')
  end
end

vim.api.nvim_create_augroup('InitialColorscheme', {clear = true})
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'InitialColorscheme',
  pattern = {'*'},
  nested = true,
  -- command = 'colorscheme nord',
  callback = InitialColorschemeFunc,
  desc = "Set initial colorscheme; setting it without the autocmd causes undefined behavior when switching colorschemes if nord is initial colorscheme"
})
