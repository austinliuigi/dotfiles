-- Leap
local leap = require("leap")
leap.opts.max_phase_one_targets = nil
leap.opts.highlight_unlabeled_phase_one_targets = false
leap.opts.max_highlighted_traversal_targets = 10
leap.opts.case_sensitive = false
leap.opts.equivalence_classes = { '\r\n', }
leap.opts.safe_labels = {}
leap.opts.special_keys = {
  repeat_search = '',
  next_phase_one_target = '',
  next_target = '',
  prev_target = '',
  next_group = '<Tab>',
  prev_group = '<S-Tab>',
  multi_accept = '',
  multi_revert = '',
}

vim.keymap.set({'n'}, 's', '<Plug>(leap-forward-to)', { noremap = true })
vim.keymap.set({'n'}, 'S', '<Plug>(leap-backward-to)', { noremap = true })
vim.keymap.set({'x', 'o'}, 's', function() require('leap').leap({ offset = 0, inclusive_op = true }) end, { noremap = true })
vim.keymap.set({'x', 'o'}, 'S', function() require('leap').leap({ offset = 0, inclusive_op = true, backward = true }) end, { noremap = true })
vim.keymap.set({'n', 'x', 'o'}, '<C-s>', '<Plug>(leap-cross-window)', { noremap = true })

vim.api.nvim_create_augroup("LeapHighlights", {clear = true})
vim.api.nvim_create_autocmd({ "Colorscheme" }, {
  group   = "LeapHighlights",
  pattern = {'*'},
  callback = function()
    -- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { link = "Search" })
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = "Comment" })
  end,
})


-- Leap-spooky
require('leap-spooky').setup {
  affixes = {
    -- These will generate mappings for all native text objects, like:
    -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
    -- Special line objects will also be added, by repeating the affixes.
    -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
    -- window.
    -- You can also use 'rest' & 'move' as mnemonics.
    remote   = { window = 'r', cross_window = 'R' },
    magnetic = { window = 'm', cross_window = 'M' },
  },
  -- If this option is set to true, the yanked text will automatically be pasted
  -- at the cursor position if the unnamed register is in use.
  paste_on_remote_yank = false,
}
