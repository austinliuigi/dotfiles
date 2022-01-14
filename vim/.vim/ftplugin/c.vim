" Name: c.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Folding {{{

setlocal foldexpr=CFoldLevel(v:lnum)

function! CFoldLevel(lnum)
    " If line starts with '#' (for include)
    if getline(a:lnum) =~? '\v^\#'
        return '0'
        " If line does not start with '}' or whitespace and ends with semicolon (global variable declaration)
    elseif getline(a:lnum) =~? '\v^(\}|\s)@!.*\;'
        return '0'
    " If line does not start with '{' or '}' or whitespace or eol (function signature)
    elseif getline(a:lnum) =~? '\v^(\{|\}|\s|$)@!'
        return '>1'
    " If line is blank
    elseif getline(a:lnum) =~? '\v^\s*$'
        " If first line in file
        if a:lnum == 1
            return '0'
        " If next line does not start with '{' or '}' or whitespace or '#' or eol and does not end in semicolon (function signature)
        elseif getline(a:lnum + 1) =~? '\v^(\{|\}|\s|\#|$)@!.*(\;)@<!$'
            return '0'
        " If prev line does not start with '{' or '}' or whitespace or '#' or eol and does not end in semicolon (function signature)
        elseif getline(a:lnum - 1) =~? '\v^(\{|\}|\s|\#|$)@!.*(\;)@<!$'
            return '1'
        " If prev line starts with '}' (end of function)
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
