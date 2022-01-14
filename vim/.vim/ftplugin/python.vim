" Name: python.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=PythonFoldLevel(v:lnum)

function! PythonFoldLevel(lnum)
    " If line is blank and next line immediately starts with non-whitespace
    if getline(a:lnum) =~? '\v^\s*$' && getline(a:lnum + 1) =~? '\v^\S'
        return '0'
    " If line immediately starts with non-whitespace
    elseif getline(a:lnum) =~? '\v^\S'
        return '>1'
    else
        return '1'
    endif
endfunction

" }}}
