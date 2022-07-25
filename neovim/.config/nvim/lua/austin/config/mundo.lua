-- vim.g.mundo_width = 75            -- Set width of graph and preview (default 45)
-- vim.g.mundo_preview_height = 15   -- Set height of preview window (default 15)
vim.g.mundo_preview_bottom = 1    -- Force preview window to be below windows instead of below graph
-- vim.g.mundo_inline_undo = 1       -- Enable one line diff in graph
-- vim.g.mundo_return_on_revert = 0  -- Keep focus in graph after selecting old undo state
-- vim.g.mundo_playback_delay = 750  -- Set time between each change when running 'play to'
vim.g.mundo_mappings = {
  ['<nowait> <CR>'] = 'preview',
  ['<nowait> o'] = 'preview',
  ['<nowait> J'] = 'move_older_write',
  ['<nowait> K'] = 'move_newer_write',
  ['<nowait> gg'] = 'move_top',
  ['<nowait> G'] = 'move_bottom',
  ['<nowait> P'] = 'play_to',
  ['<nowait> d'] = 'diff',
  ['<nowait> i'] = 'toggle_inline',
  ['<nowait> /'] = 'search',
  ['<nowait> n'] = 'next_match',
  ['<nowait> N'] = 'previous_match',
  ['<nowait> p'] = 'diff_current_buffer',
  ['<nowait> r'] = 'rdiff',
  ['<nowait> ?'] = 'toggle_help',
  ['<nowait> q'] = 'quit',
  ['<nowait> <2-LeftMouse>'] = 'mouse_click',
  ['<nowait> j'] = 'move_older',
  ['<nowait> k'] = 'move_newer',
  ['<nowait> <Down>'] = 'move_older',
  ['<nowait> <Up>'] = 'move_newer'
}

vim.keymap.set('n', '<leader>tu', '<cmd>MundoToggle<CR>', {noremap = true, silent = true})
