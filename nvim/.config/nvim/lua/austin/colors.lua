local M = {
  transparent = true
}

-- Map of neovim colorscheme names(g:colors_name) to kitty theme names (## name:)
local nvim_to_kitty = {
  ['carbonfox']  = { dark = 'carbonfox',        light = 'carbonfox' },
  ['codedark']   = { dark = 'vscode-dark',      light = 'vscode-dark' },
  ['dawnfox']    = { dark = 'dawnfox',          light = 'dawnfox' },
  ['dayfox']     = { dark = 'dayfox',           light = 'dayfox' },
  ['duskfox']    = { dark = 'duskfox',          light = 'duskfox' },
  ['gruvbox']    = { dark = 'gruvbox-dark',     light = 'gruvbox-light' },
  ['kanagawa']   = { dark = 'kanagawa-dark',    light = 'kanagawa-light' },
  ['material']   = { dark = 'palenight',        light = 'palenight' },
  ['nightfox']   = { dark = 'nightfox',         light = 'nightfox' },
  ['nord']       = { dark = 'nord-dark',        light = 'nord-light' },
  ['nordfox']    = { dark = 'nordfox',          light = 'nordfox' },
  ['onedark']    = { dark = 'onedark',          light = 'onelight' },
  ['rose-pine']  = { dark = 'rosepine',         light = 'rosepine-dawn' },
  ['seoul256']   = { dark = 'seoul256',         light = 'seoul256' },
  ['terafox']    = { dark = 'terafox',          light = 'terafox' },
  ['tokyonight'] = { dark = 'tokyonight-storm', light = 'tokyonight-day' },
  -- ['vscode']     = { dark = 'vscode-dark',      light = 'vscode-light' },
}
-- Map of kitty theme names to neovim colorscheme names
local kitty_to_nvim = { dark = {}, light = {} }
for nvim_color, kitty in pairs(nvim_to_kitty) do
  kitty_to_nvim.dark[kitty.dark] = nvim_color
  kitty_to_nvim.light[kitty.light] = nvim_color
end
-- Current kitty theme; Note: $1 is '##' and $2 is 'name:' and $3 is the kitty theme name
local kitty_theme = os.getenv('TERM') == 'xterm-kitty' and vim.fn.trim(vim.fn.system("awk '/name/ {print substr($0, index($0,$3))}' ~/.config/kitty/current-theme.conf")) or nil



--[[ Config Options ]]

local SetConfigOpts = function()
  local config_dir_path = vim.api.nvim_get_runtime_file("lua/austin/config/colors/", true)[1]
  for colorscheme, _ in pairs(nvim_to_kitty) do
    local config_file_path = config_dir_path .. colorscheme .. ".lua"
    if vim.fn.glob(config_file_path) ~= "" then
      vim.cmd("source " .. config_file_path)
    end
  end
end



--[[ Toggle Transparency ]]

vim.api.nvim_create_user_command("ToggleTransparency", function()
  M.transparent = not M.transparent
  SetConfigOpts()
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
    if nvim_colorscheme ~= kitty_to_nvim[vim.o.background][kitty_theme] and os.getenv('TERM') == 'xterm-kitty' and nvim_to_kitty[nvim_colorscheme] ~= nil then
      kitty_theme = nvim_to_kitty[nvim_colorscheme][vim.o.background]
      os.execute('kitty +kitten themes --reload-in=all ' .. kitty_theme)
    end
  end,
  desc = 'Set kitty theme based on current neovim colorscheme'
})



--[[ Set Initial Colorscheme ]]

-- Set colorscheme to kitty theme if possible, otherwise set to nord
local SetInitialColorscheme = function()
  SetConfigOpts()
  if kitty_to_nvim["light"][kitty_theme] ~= nil then
    vim.o.background = "light"
    vim.cmd('colorscheme ' .. kitty_to_nvim[vim.o.background][kitty_theme])
  elseif kitty_to_nvim["dark"][kitty_theme] ~= nil then
    vim.o.background = "dark"
    vim.cmd('colorscheme ' .. kitty_to_nvim[vim.o.background][kitty_theme])
  else
    vim.cmd('colorscheme kanagawa')
  end
end
-- vim.schedule(SetInitialColorscheme)

vim.api.nvim_create_augroup('InitialColorscheme', {clear = true})
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'InitialColorscheme',
  pattern = {'*'},
  nested = true,
  callback = SetInitialColorscheme,
  desc = "Set initial colorscheme; setting on 'VimEnter' allows for highlights set by 'Colorscheme' autocmd to fire"
})

return M
