local keymap = vim.keymap.set

-- Leader key {{{

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>", "<nop>", {noremap = true})

-- }}}
-- Motion mappings {{{

keymap({ "n", "x" }, "k", "v:count ? 'k' : 'gk'", {noremap = true, expr = true})

keymap({ "n", "x" }, "j", "v:count ? 'j' : 'gj'", {noremap = true, expr = true})

-- }}}
-- Register mappings {{{

keymap({ "n", "x" }, "<leader>c", 'c', {noremap = true})

keymap({ "n", "x" }, "<leader>C", 'C', {noremap = true})

keymap({ "n", "x" }, "<leader>d", 'd', {noremap = true})

keymap({ "n", "x" }, "<leader>D", 'D', {noremap = true})

keymap({ "n", "x" }, "<leader>s", 's', {noremap = true})

keymap({ "n", "x" }, "<leader>S", 'S', {noremap = true})

keymap({ "n", "x" }, "<leader>x", 'x', {noremap = true})

keymap({ "n", "x" }, "<leader>X", 'X', {noremap = true})

keymap({ "n", "x" }, "c", '"_c', {noremap = true})

keymap({ "n", "x" }, "C", '"_C', {noremap = true})

keymap({ "n", "x" }, "d", '"_d', {noremap = true})

keymap({ "n", "x" }, "D", '"_D', {noremap = true})

keymap({ "n", "x" }, "s", '"_s', {noremap = true})

keymap({ "n", "x" }, "S", '"_S', {noremap = true})

keymap({ "n", "x" }, "x", '"_x', {noremap = true})

keymap({ "n", "x" }, "X", '"_X', {noremap = true})

keymap({ "n" }, "<leader>V", "V<leader>", {remap = true})

-- }}}
-- Buffer list mappings {{{

keymap("n", "]b", "<cmd>bn<CR>", {noremap = true, silent = true})

keymap("n", "[b", "<cmd>bp<CR>", {noremap = true, silent = true})

keymap("n", "\\b", "<cmd>bp<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>b", ":ls<CR>:b<Space>", {noremap = true, silent = true})

-- }}}
-- Argument list mappings {{{

keymap("n", "]a", "<cmd>n<CR>", {noremap = true, silent = true})

keymap("n", "[a", "<cmd>N<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>a", "<cmd>args<CR>", {noremap = true, silent = true})

-- }}}
-- Quickfix list mappings {{{

keymap("n", "]c", "<cmd>cn<CR>", {noremap = true, silent = true})

keymap("n", "[c", "<cmd>cp<CR>", {noremap = true, silent = true})

-- }}}
-- Window mappings {{{

keymap({"n", "i", "t"}, "<C-h>", "<cmd>wincmd h<CR>", {noremap = true})

keymap({"n", "i", "t"}, "<C-j>", "<cmd>wincmd j<CR>", {noremap = true})

keymap({"n", "i", "t"}, "<C-k>", "<cmd>wincmd k<CR>", {noremap = true})

keymap({"n", "i", "t"}, "<C-l>", "<cmd>wincmd l<CR>", {noremap = true})

-- }}}
-- Tab mappings {{{

keymap({"n", "i", "t"}, "<A-h>", "<cmd>tabprev<CR>", {noremap = true, silent = true})

keymap({"n", "i", "t"}, "<A-l>", "<cmd>tabnext<CR>", {noremap = true, silent = true})

keymap("n", "<C-t>L", "<cmd>+tabmove<CR>", {noremap = true, silent = true})

keymap("n", "<C-t>H", "<cmd>-tabmove<CR>", {noremap = true, silent = true})

keymap("n", "<leader><leader>t", ":tabs<CR>:tabn<Space>", {noremap = true, silent = true})

-- }}}
-- Toggle mappings {{{

keymap("n", "<leader>tc", "<cmd>HexokinaseToggle<CR>", {noremap = true, silent = true})

keymap("n", "<leader>th", "v:hlsearch ? '<cmd>nohl<CR>' : '<cmd>set hlsearch<CR>'", {noremap = true, silent = true, expr = true, replace_keycodes = false})

keymap("n", "<leader>tl", "<cmd>ToggleSpaceChar<CR>", {noremap = true, silent = true})

keymap("n", "<leader>tn", "<cmd>set relativenumber!<CR>", {noremap = true, silent = true})

keymap("n", "<leader>tv", "empty(&virtualedit) ? '<cmd>set virtualedit+=all<CR>' : '<cmd>set virtualedit-=all<CR>'", {noremap = true, silent = true, expr = true, replace_keycodes = false})

keymap("n", "<leader>tw", "<cmd>set wrap!<CR>", {noremap = true, silent = true})

-- }}}
-- Normal mode mappings {{{

keymap("n", "<leader>!", "<cmd>so %<CR><cmd>echohl GitSignsAdd | echo 'Sourced :)' | echohl None<CR>", {noremap = true, silent = false})

keymap("n", "<esc>", "<cmd>nohl<CR>", {noremap = true, silent = true})

keymap("n", "<leader>p", "<cmd>put<CR>", {noremap = true, silent = true})

keymap("n", "<leader>P", "<cmd>put!<CR>", {noremap = true, silent = true})

keymap("n", "zC", "zCvzC", {noremap = true})

-- }}}
-- Insert mode mappings {{{

keymap("i", "<S-Left>", "pumvisible() ? '<C-e>' : '<S-Left>'", {noremap = true, expr = true,  replace_keycodes = false})

keymap("i", "<S-Right>", "pumvisible() ? '<C-y>' : '<S-Right>'", {noremap = true, expr = true,  replace_keycodes = false})

keymap("i", "<CR>", "pumvisible() ? '<C-e><CR>' : '<CR>'", {noremap = true, expr = true,  replace_keycodes = false})

-- }}}
-- Visual mode mappings {{{

keymap("x", "<", "<gv", {noremap = true})

keymap("x", ">", ">gv", {noremap = true})

-- }}}
-- Terminal mode mappings {{{

keymap("t", "<S-Esc>", "<C-\\><C-n>", {noremap = true})

-- }}}
-- Custom text objects {{{

-- File text object
keymap("x", "af", ":<C-u>normal! ggVG<CR>", {noremap = true, silent = true})

keymap("o", "af", "<cmd>normal Vaf<CR>", {noremap = false})

keymap("x", "if", ":<C-u>call MoveToLastNonBlankLine()|call MoveToFirstNonBlankLine()|normal! V''<CR>", {noremap = true, silent = true})

keymap("o", "if", "<cmd>normal Vif<CR>", {noremap = false})

-- Line text object
keymap ("x", "al", ":<C-u>normal! 0v$h<CR>", {noremap = true, silent = true})

keymap("o", "al", "<cmd>normal Val<CR>", {noremap = false})

keymap ("x", "il", ":<C-u>normal! ^vg_<CR>", {noremap = true, silent = true})

keymap("o", "il", "<cmd>normal Vil<CR>", {noremap = false})

-- Fold text object
keymap("x", "az", ":<C-u>normal! [zV]z<CR>", {noremap = true, silent = true})

keymap("o", "az", "<cmd>normal Vaz<CR>", {noremap = false})

keymap("x", "iz", ":<C-u>normal! [zjV]zk<CR>", {noremap = true, silent = true})

keymap("o", "iz", "<cmd>normal Viz<CR>", {noremap = false})

-- }}}
-- Misc {{{

-- Unbind <CR> in command line window
vim.api.nvim_create_augroup('CmdWin', {clear = true})
vim.api.nvim_create_autocmd('CmdwinEnter', {
  command = 'nnoremap <buffer> <CR> <CR>',
  group = 'CmdWin',
  pattern = {'*'}
})

if vim.fn.has("mac") == 1 then
  vim.keymap.set({"n"}, "gx", function()
    vim.fn.jobstart({"open", vim.fn.expand("<cfile>")}, {detach = true})
  end)
  -- TODO: implement when get_visual_selection is implemented (https://github.com/neovim/neovim/pull/13896)
  -- vim.keymap.set({"x"}, "gx", function()
    -- vim.fn.jobstart({"open", get_visual_selection(),}, {detach = true})
  -- end)
elseif vim.fn.has("unix") == 1 then
  vim.keymap.set({"n"}, "gx", function()
    vim.fn.jobstart({"xdg-open", vim.fn.expand("<cfile>")}, {detach = true})
  end)
  -- TODO: implement when get_visual_selection is implemented (https://github.com/neovim/neovim/pull/13896)
  -- vim.keymap.set({"x"}, "gx", function()
    -- vim.fn.jobstart({"xdg-open", get_visual_selection(),}, {detach = true})
  -- end)
else
  vim.keymap.set({"n", "x"}, "gx", function()
    print("Error: gx is not supported on this OS!")
  end)
end

-- }}}

-- Mapping Functions {{{ 

vim.cmd [[
  function! ToggleSpaceChar()
      if stridx(&listchars, "space") <= 0
          set listchars+=space:⋅
      else
          set listchars-=space:⋅
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
