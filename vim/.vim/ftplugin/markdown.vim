" Name: markdown.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=MdFoldLevel(v:lnum)

function! MdFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        if getline(a:lnum + 1) =~? '\v^\s*#{1,6}(#)@!'
            return string(foldlevel(line(a:lnum)+1) - 1)
        else
            return '='
        endif
    elseif getline(a:lnum) =~? '\v^\s*\######(#)@!'
        return '>6'
    elseif getline(a:lnum) =~? '\v^\s*\#####(#)@!'
        return '>5'
    elseif getline(a:lnum) =~? '\v^\s*\####(#)@!'
        return '>4'
    elseif getline(a:lnum) =~? '\v^\s*\###(#)@!'
        return '>3'
    elseif getline(a:lnum) =~? '\v^\s*\##(#)@!'
        return '>2'
    elseif getline(a:lnum) =~? '\v^\s*\#(#)@!'
        return '>1'
    else
        return '='
    endif
endfunction

" }}}
