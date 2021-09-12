" Name: cpp.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=CppFoldLevel(v:lnum)

function! CppFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^\#'
        return '0'
    elseif getline(a:lnum) =~? '\v^(\}|\s)@!.*\;'
        return '0'
    elseif getline(a:lnum) =~? '\v^(\{|\}|\s|$)@!'
        return '>1'
    elseif getline(a:lnum) =~? '\v^\s*$'
        if a:lnum == 1
            return '0'
        elseif getline(a:lnum + 1) =~? '\v^(\{|\}|\s|\#|$)@!.*(\;)@<!$'
            return '0'
        elseif getline(a:lnum - 1) =~? '\v^(\{|\}|\s|\#|$)@!.*(\;)@<!$'
            return '1'
        elseif getline(a:lnum -1) =~? '\v^\}'
            return '0'
        else
            return '='
        endif
    else
        return '1'
    endif
endfunction

" }}}
