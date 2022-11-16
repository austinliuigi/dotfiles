--[[ Useful Variables ]]

-- Global transparency variable (for all colorschemes)
local transparent_bg = true
-- Colorscheme-specific transparency settings
local transparent_opts_lua = {
  ["gruvbox"]    = '["transparent_mode"]',
  ["kanagawa"]   = '["transparent"]',
  ["material"]   = '["disable"]["background"]',
  ["nightfox"]   = '["options"]["transparent"]',
  ["onedark"]    = '["transparent"]',
  ["rose-pine"]  = '["disable_background"]',
  ["tokyonight"] = '["transparent"]',
}
local transparent_opts_viml = {
  'nord_disable_background',
  'seoul256_disable_background',
  'codedark_transparent',
}
-- Map of neovim colorscheme names(g:colors_name) to kitty theme names (## name:)
local nvim_to_kitty = {
  ['carbonfox']  = 'carbonfox',
  ['codedark']   = 'vscode-dark',
  ['dawnfox']    = 'dawnfox',
  ['dayfox']     = 'dayfox',
  ['duskfox']    = 'duskfox',
  ['gruvbox']    = 'gruvbox',
  ['kanagawa']   = 'kanagawa',
  ['material']   = 'palenight',
  ['nightfox']   = 'nightfox',
  ['nord']       = 'nord',
  ['nordfox']    = 'nordfox',
  ['onedark']    = 'onedark',
  ['rose-pine']  = 'rosepine',
  ['seoul256']   = 'seoul256',
  ['terafox']    = 'terafox',
  ['tokyonight'] = 'tokyonight-storm',
}
-- Map of kitty theme names to neovim colorscheme names
local kitty_to_nvim = {}
for k, v in pairs(nvim_to_kitty) do
  kitty_to_nvim[v] = k
end
-- Current kitty theme; Note: $1 is '##' and $2 is 'name:' and $3 is the kitty theme name
local kitty_theme = os.getenv('TERM') == 'xterm-kitty' and vim.fn.trim(vim.fn.system("awk '/name/ {print substr($0, index($0,$3))}' ~/.config/kitty/current-theme.conf")) or nil



--[[ Toggle Transparency ]]

local SetTransparencyOpts = function()
  -- Plugins that use lua setup
  for k, v in pairs(transparent_opts_lua) do
    vim.fn.execute("lua require('austin.config.colors." .. k .. "')" .. v .. " = " .. tostring(transparent_bg))
    require(k).setup(require("austin.config.colors." .. k))
  end
  -- Plugins that use vim variable options
  for _, v in pairs(transparent_opts_viml) do
    vim.g[v] = transparent_bg
  end
end

vim.api.nvim_create_user_command("ToggleTransparency", function()
  transparent_bg = not transparent_bg
  SetTransparencyOpts()
  vim.cmd('colorscheme ' .. vim.g.colors_name)
end, { nargs = 0 })

vim.keymap.set('n', '<leader>ttr', '<cmd>ToggleTransparency<CR>')



--[[ Set Kitty Theme ]]

-- Set kitty theme if colorscheme is in nvim_to_kitty table and if in kitty terminal
-- Look at :h nvim_create_autocmd and scroll down to parameters
vim.api.nvim_create_augroup('SetKittyTheme', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetKittyTheme',
  pattern = {'*'},
  callback = function(arg)
    local nvim_colorscheme = arg.match
    if nvim_colorscheme ~= kitty_to_nvim[kitty_theme] and os.getenv('TERM') == 'xterm-kitty' and nvim_to_kitty[nvim_colorscheme] ~= nil then
      kitty_theme = nvim_to_kitty[nvim_colorscheme]
      os.execute('kitty +kitten themes --reload-in=all ' .. kitty_theme)
    end
  end,
  desc = 'Set kitty theme based on current neovim colorscheme'
})



--[[ Set Initial Colorscheme ]]

-- Set colorscheme to kitty theme if possible, otherwise set to nord
local SetInitialColorscheme = function()
  SetTransparencyOpts()
  if kitty_to_nvim[kitty_theme] ~= nil then
    vim.cmd('colorscheme ' .. kitty_to_nvim[kitty_theme])
  else
    vim.cmd('colorscheme kanagawa')
  end
end
-- SetInitialColorscheme()

vim.api.nvim_create_augroup('InitialColorscheme', {clear = true})
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'InitialColorscheme',
  pattern = {'*'},
  nested = true,
  callback = SetInitialColorscheme,
  desc = "Set initial colorscheme; setting on 'VimEnter' allows for highlights set by 'Colorscheme' autocmd to fire"
})
