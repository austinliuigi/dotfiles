" Name: python.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=PythonFoldLevel(v:lnum)

function! PythonFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^\s*$' && getline(a:lnum + 1) =~? '\v^\S'
        return '0'
    elseif getline(a:lnum) =~? '\v^\S'
        return '>1'
    else
        return '1'
    endif
endfunction

" }}}
