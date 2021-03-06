local keymap = vim.keymap.set

-- Leader key {{{

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>", "<nop>", {noremap = true})

-- }}}
-- Motion mappings {{{

keymap("n", "k", "v:count ? 'k' : 'gk'", {noremap = true, expr = true})

keymap("n", "j", "v:count ? 'j' : 'gj'", {noremap = true, expr = true})

-- }}}
-- Register mappings {{{

keymap({ "n", "v" }, "<leader>c", 'c', {noremap = true})

keymap({ "n", "v" }, "<leader>C", 'C', {noremap = true})

keymap({ "n", "v" }, "<leader>d", 'd', {noremap = true})

keymap({ "n", "v" }, "<leader>D", 'D', {noremap = true})

keymap({ "n", "v" }, "<leader>s", 's', {noremap = true})

keymap({ "n", "v" }, "<leader>S", 'S', {noremap = true})

keymap({ "n", "v" }, "<leader>x", 'x', {noremap = true})

keymap({ "n", "v" }, "<leader>X", 'X', {noremap = true})

keymap({ "n", "v" }, "c", '"_c', {noremap = true})

keymap({ "n", "v" }, "C", '"_C', {noremap = true})

keymap({ "n", "v" }, "d", '"_d', {noremap = true})

keymap({ "n", "v" }, "D", '"_D', {noremap = true})

keymap({ "n", "v" }, "s", '"_s', {noremap = true})

keymap({ "n", "v" }, "S", '"_S', {noremap = true})

keymap({ "n", "v" }, "x", '"_x', {noremap = true})

keymap({ "n", "v" }, "X", '"_X', {noremap = true})

-- }}}
-- Buffer list mappins {{{

keymap("n", "]b", "<cmd>bn<CR>", {noremap = true, silent = true})

keymap("n", "[b", "<cmd>bp<CR>", {noremap = true, silent = true})

keymap("n", "\\b", "<cmd>bp<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>b", ":ls<CR>:b<Space>", {noremap = true, silent = true})

-- }}}
-- Argument list mappins {{{

keymap("n", "]a", "<cmd>n<CR>", {noremap = true, silent = true})

keymap("n", "[a", "<cmd>N<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>a", "<cmd>args<CR>", {noremap = true, silent = true})

-- }}}
-- Quickfix list mappins {{{

keymap("n", "]c", "<cmd>cn<CR>", {noremap = true, silent = true})

keymap("n", "[c", "<cmd>cp<CR>", {noremap = true, silent = true})

-- }}}
-- Window mappings {{{

-- }}}
-- Tab mappings {{{

keymap("n", "<C-t><C-l>", "<cmd>tabnext<CR>", {noremap = true, silent = true})

keymap("n", "<C-t><C-h>", "<cmd>tabprev<CR>", {noremap = true, silent = true})

keymap("i", "<C-t><C-l>", "<cmd>tabnext<CR>", {noremap = true, silent = true})

keymap("i", "<C-t><C-h>", "<cmd>tabprev<CR>", {noremap = true, silent = true})

keymap("n", "<C-t>L", "<cmd>+tabmove<CR>", {noremap = true, silent = true})

keymap("n", "<C-t>H", "<cmd>-tabmove<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>t", ":tabs<CR>:tabn<Space>", {noremap = true, silent = true})

-- }}}
-- Toggle mappings {{{

keymap("n", "<leader>tc", "<cmd>HexokinaseToggle<CR>", {noremap = true, silent = true})

keymap("n", "<leader>th", "v:hlsearch ? '<cmd>nohl<CR>' : '<cmd>set hlsearch<CR>'", {noremap = true, silent = true, expr = true})

keymap("n", "<leader>tl", "<cmd>ToggleSpaceChar<CR>", {noremap = true, silent = true})

keymap("n", "<leader>tn", "<cmd>set relativenumber!<CR>", {noremap = true, silent = true})

keymap("n", "<leader>tw", "<cmd>set wrap!<CR>", {noremap = true, silent = true})

-- }}}
-- Normal mode mappings {{{

keymap("n", "!", "<cmd>so %<CR>", {noremap = true, silent = true})

keymap("n", "<BS>", "<cmd>nohl<CR>", {noremap = true, silent = true})

keymap("n", "<leader>p", "<cmd>put<CR>", {noremap = true, silent = true})

keymap("n", "<leader>P", "<cmd>put!<CR>", {noremap = true, silent = true})

keymap("n", "<leader>v", "empty(&virtualedit) ? '<cmd>set virtualedit+=all<CR>' : '<cmd>set virtualedit-=all<CR>'", {noremap = true, silent = true, expr = true})

keymap("n", "zC", "zCvzC", {noremap = true})

-- }}}
-- Insert mode mappings {{{

keymap("i", "<Left>", "pumvisible() ? '<C-e>' : '<Left>'", {noremap = true, expr = true})

keymap("i", "<Right>", "pumvisible() ? '<C-y>' : '<Right>'", {noremap = true, expr = true})

keymap("i", "<CR>", "pumvisible() ? '<C-e><CR>' : '<CR>'", {noremap = true, expr = true})

-- }}}
-- Visual mode mappings {{{

keymap("v", "<", "<gv", {noremap = true})

keymap("v", ">", ">gv", {noremap = true})

-- }}}
-- Custom text objects {{{

-- File text object
keymap("v", "af", ":<C-u>normal! ggVG<CR>", {noremap = true, silent = true})

keymap("o", "af", "<cmd>normal Vaf<CR>", {noremap = false})

keymap("v", "if", ":<C-u>call MoveToLastNonBlankLine()|call MoveToFirstNonBlankLine()|normal! V''<CR>", {noremap = true, silent = true})

keymap("o", "if", "<cmd>normal Vif<CR>", {noremap = false})

-- Line text object
keymap ("v", "al", ":<C-u>normal! 0v$h<CR>", {noremap = true, silent = true})

keymap("o", "al", "<cmd>normal Val<CR>", {noremap = false})

keymap ("v", "il", ":<C-u>normal! ^vg_<CR>", {noremap = true, silent = true})

keymap("o", "il", "<cmd>normal Vil<CR>", {noremap = false})

-- Fold text object
keymap("v", "az", ":<C-u>normal! [zV]z<CR>", {noremap = true, silent = true})

keymap("o", "az", "<cmd>normal Vaz<CR>", {noremap = false})

keymap("v", "iz", ":<C-u>normal! [zjV]zk<CR>", {noremap = true, silent = true})

keymap("o", "iz", "<cmd>normal Viz<CR>", {noremap = false})

-- }}}

-- Mapping Functions {{{ 

vim.cmd [[
  function! ToggleSpaceChar()
      if stridx(&listchars, "space") <= 0
          set listchars+=space:???
      else
          set listchars-=space:???
      endif
  endfunction
  command! ToggleSpaceChar call ToggleSpaceChar()

  function! ToggleConcealLevel()
      let &l:concealevel = &l:concealevel ? 0 : 2
  endfunction
  command! ToggleConcealLevel call ToggleConcealLevel()

  function! MoveToFirstNonBlankLine()
      normal! gg
      if empty(substitute(getline(line('.')), '\s', '', "g"))
          call search('^\s*\S\+')
      endif
  endfunction

  function! MoveToLastNonBlankLine()
      normal! G
      if empty(substitute(getline(line('.')), '\s', '', "g"))
          call search('^\s*\S\+', 'b')
      endif
  endfunction
]]

-- }}}
-- vim: foldmethod=marker
