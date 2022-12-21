local disabled_built_ins = {
  'gzip',
  -- 'man',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'shada_plugin',
  'tarPlugin',
  'zipPlugin',
}
for i = 1, #disabled_built_ins do
  vim.g['loaded_' .. disabled_built_ins[i]] = 1
end

require('austin.utils')
require('austin.options')
require('austin.keymaps')
require('austin.text-objects')
-- require('austin.waldo')
require('austin.plugins')
if not packer_bootstrap then
  require('austin.colors')
end
