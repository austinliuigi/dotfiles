local disabled_built_ins = {
--  'gzip',
--  'man',
 'matchit',
 'matchparen',
--  'shada_plugin',
--  'tarPlugin',
--  'tar',
--  'zipPlugin',
--  'zip',
  'netrwPlugin',
}

for i = 1, #disabled_built_ins do
  vim.g['loaded_' .. disabled_built_ins[i]] = 1
end

require('austin.options')
require('austin.keymaps')
require('austin.plugins')
require('austin.colors')

vim.cmd('colorscheme nord')
