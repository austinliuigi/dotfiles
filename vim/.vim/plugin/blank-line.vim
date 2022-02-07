" :h b:changedtick

" In order to use vim-repeat, the mapping that you provide as an argument to
" repeat#set("{mapping}") must include that exact call so that whenever you
" execute that mapping, repeat#set("{mapping}") gets called. This is necessary
" because every call updates the repeat_tick variable to the b:changetick
" variable. If this doesn't happen, repeat will work once then stop working.

" If the argument is a literal mapping to a key sequence that isn't mapped to
" anything, that gets executed once but doesn't re-call repeat#set. An argument
" that's a lhs who's rhs includes a call to repeat#set works, even if it
" includes any special keys, such as <Plug> or <space>. One exception to this is
" <leader>. "\<leader>o" and "\<lt>leader>o:" get interpreted literally by
" repeat#set, causing an unpredictable result from the dot command.

function! BlankLineBelow()
    execute 'normal! ' . string(v:count1) . "o\<C-U>\<esc>"
    call repeat#set("\<Plug>BlankLineBelow")
endfunction

" count does not work with 'o' in formatoptions; executing a <C-U> after
" pressing 'O' in normal mode with a count causes only one line to be created above,
" essentially ignoring the count
function! BlankLineAbove() range
    execute 'normal! ' . string(v:count1) . "O\<C-U>\<esc>"
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

" when the mapping to <Plug>BlankLineBelow is supplied with a count, the count prefixes the RHS, therefore the <C-U> is necessary
" to remove the range created when a count is provided (because a count before ':' in normal mode creates a range)
nnoremap <silent> <Plug>BlankLineBelow :<C-U>call BlankLineBelow()<CR>
nnoremap <silent> <Plug>BlankLineAbove :<C-U>call BlankLineAbove()<CR>
nnoremap <silent> <Plug>ClearLineBlackHole :call ClearLineBlackHole()<CR>
nnoremap <silent> <Plug>ClearLineDefaultReg :call ClearLineDefaultReg()<CR>
