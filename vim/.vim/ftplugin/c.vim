" Name: c.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=CFoldLevel(v:lnum)

function! CFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^\s*$' && getline(a:lnum + 1) =~? '\v^(\{|\}|\s)@!'
        return '0'
    elseif getline(a:lnum) =~? '\v^(\{|\}|\s)@!'
        return '>1'
    else
        return '1'
    endif
endfunction

" }}}
