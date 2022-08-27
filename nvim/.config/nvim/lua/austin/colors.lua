--[[ Useful Variables ]]

-- Global transparency variable (for all colorschemes)
local transparent_bg = true
-- Colorscheme-specific global vim variables for transparency
local transparent_opts = { 'nord_disable_background', 'tokyonight_transparent', 'gruvbox_transp_bg'}
-- Hex colors to dodge kitty transparency bug (#2E3440 -> #2E3441)
local nvim_to_opaquebg = { ['nord'] = '#2E3441', ['tokyonight'] = '#24283C', ['gruvbox8'] = '#282829' }
-- Map of neovim colorscheme names to kitty theme names
local nvim_to_kitty = { ['nord'] = 'Nord', ['tokyonight'] = 'Tokyo Night Storm', ['gruvbox8'] = 'Gruvbox Dark' }
-- Map of kitty theme names to neovim colorscheme names
local kitty_to_nvim = {}
for k, v in pairs(nvim_to_kitty) do
  kitty_to_nvim[v] = k
end
-- Current kitty theme; Note: $1 is '##' and $2 is 'name:' and $3 is the kitty theme name
local kitty_theme = os.getenv('TERM') == 'xterm-kitty' and vim.fn.trim(vim.fn.system("awk '/name/ {print substr($0, index($0,$3))}' ~/.config/kitty/current-theme.conf")) or nil



--[[ Opaque Backgrounds ]]

local OpaqueBackgroundFunc = function(arg)
  local nvim_colorscheme = arg.match
  if transparent_bg == false then
    vim.cmd('silent hi Normal guibg = ' .. nvim_to_opaquebg[nvim_colorscheme])
  end
end

vim.api.nvim_create_augroup('OpaqueBackground', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'OpaqueBackground',
  pattern = {'*'},
  callback = OpaqueBackgroundFunc,
  desc = 'Change background hex color when transparency is disabled (kitty issue)'
})



--[[ Toggle transparency mapping ]]

local SetTransparencyOpts = function()
  for _, v in ipairs(transparent_opts) do
    vim.g[v] = transparent_bg
  end
end

vim.keymap.set('n', '<leader>ttr', function()
  transparent_bg = not transparent_bg
  SetTransparencyOpts()
  vim.cmd('colorscheme ' .. vim.g.colors_name)
end)



--[[ Set Kitty Theme ]]

-- Set kitty theme if colorscheme is in nvim_to_kitty table and if in kitty terminal
-- Look at :h nvim_create_autocmd and scroll down to parameters
local SetKittyThemeFunc = function(arg)
  local nvim_colorscheme = arg.match
  if nvim_colorscheme ~= kitty_to_nvim[kitty_theme] and os.getenv('TERM') == 'xterm-kitty' and nvim_to_kitty[nvim_colorscheme] ~= nil then
    os.execute('kitty +kitten themes --reload-in=all ' .. nvim_to_kitty[nvim_colorscheme])
    kitty_theme = nvim_to_kitty[nvim_colorscheme]
  end
end

-- Call SetKittyThemeFunc after changing colorscheme
vim.api.nvim_create_augroup('SetKittyTheme', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetKittyTheme',
  pattern = {'*'},
  callback = SetKittyThemeFunc,
  desc = 'Set kitty theme based on current neovim colorscheme'
})



--[[ Set Initial Colorscheme ]]

-- Set colorscheme to kitty theme if possible, otherwise set to nord
local InitialColorschemeFunc = function()
  if kitty_to_nvim[kitty_theme] ~= nil then
    vim.cmd('colorscheme ' .. kitty_to_nvim[kitty_theme])
  else
    vim.cmd('colorscheme nord')
  end
end

-- Set Colorscheme-Specific Transparency Opts
SetTransparencyOpts()
-- Call func to set initial colorscheme
InitialColorschemeFunc()

-- vim.api.nvim_create_augroup('SetInitialColorscheme', {clear = true})
-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = 'SetInitialColorscheme',
--   pattern = {'*'},
--   nested = true,
--   -- command = 'colorscheme nord',
--   callback = InitialColorschemeFunc,
--   desc = "Set initial colorscheme; setting it without the autocmd causes undefined behavior when switching colorschemes if nord is initial colorscheme"
-- })
