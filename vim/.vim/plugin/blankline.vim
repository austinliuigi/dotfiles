" :h b:changedtick
"
" In order to use vim-repeat, the mapping that you provide as an argument to
" repeat#set("{mapping}") must include that exact call so that whenever you
" execute that mapping, repeat#set("{mapping}") gets called. This is necessary
" because with every call updates the repeat_tick variable to the b:changetick
" variable. If this doesn't happen, repeat will work once then stop working.
"
" This essentially requires the mapping in the function call to be a <Plug>
" mapping. If it is a literal mapping to a key sequence, that gets executed
" once but doesn't re-call repeat#set. An argument that's a lhs who's rhs
" includes a call to repeat#set may work if the lhs is purely literal (doesn't
" include any special keys). "\<leader>o" and "\<lt>leader>o:" get interpreted
" literall by repeat#set, causing an unpredictable result from the dot
" command. I have not tried with other special keys since  using the <Plug>
" method works perfectly.

function! BlankLineBelow()
    execute 'normal! ' . "o\<esc>0\"_D"
    call repeat#set("\<Plug>BlankLineBelow")
endfunction
" nmap <leader>o <Plug>BlankLineBelow

function! BlankLineAbove()
    execute 'normal! ' . "O\<esc>0\"_D"
    call repeat#set("\<Plug>BlankLineAbove")
endfunction

function! ClearLineBlackHole()
    execute 'normal! ' . "0\"_D"
    call repeat#set("\<Plug>ClearLineBlackHole")
endfunction

function! ClearLineDefaultReg()
    execute 'normal! ' . "0D"
    call repeat#set("\<Plug>ClearLineDefaultReg")
endfunction

nnoremap <silent> <Plug>BlankLineBelow :call BlankLineBelow()<CR>
nnoremap <silent> <Plug>BlankLineAbove :call BlankLineAbove()<CR>
nnoremap <silent> <Plug>ClearLineBlackHole :call ClearLineBlackHole()<CR>
nnoremap <silent> <Plug>ClearLineDefaultReg :call ClearLineDefaultReg()<CR>
