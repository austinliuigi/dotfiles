" Name: markdown.vim
" Author: Austin Liu
" Date Created: September 3, 2021
" Date Modified: September 3, 2021
"
" Whitespace {{{

setlocal softtabstop=2

" }}}

" Folding {{{

setlocal foldexpr=MdFoldLevel(v:lnum)

function! MdFoldLevel(lnum)
    " If line is blank
    if getline(a:lnum) =~? '\v^\s*$'
        " If next line is a level 6 subheading
        if getline(a:lnum + 1) =~? '\v^\s*\######(#)@!'
            return '5'
        " If next line is a level 5 subheading
        elseif getline(a:lnum + 1) =~? '\v^\s*\#####(#)@!'
            return '4'
        " If next line is a level 4 subheading
        elseif getline(a:lnum + 1) =~? '\v^\s*\####(#)@!'
            return '3'
        " If next line is a level 3 subheading
        elseif getline(a:lnum + 1) =~? '\v^\s*\###(#)@!'
            return '2'
        " If next line is a level 2 subheading
        elseif getline(a:lnum + 1) =~? '\v^\s*\##(#)@!'
            return '1'
        " If next line is a level 1 subheading
        elseif getline(a:lnum + 1) =~? '\v^\s*\#(#)@!'
            return '0'
        else
            " Set foldlevel to that of the prev line
            return '='
        endif
    " If line is a level 6 subheading
    elseif getline(a:lnum) =~? '\v^\s*\######(#)@!'
        return '>6'
    " If line is a level 5 subheading
    elseif getline(a:lnum) =~? '\v^\s*\#####(#)@!'
        return '>5'
    " If line is a level 4 subheading
    elseif getline(a:lnum) =~? '\v^\s*\####(#)@!'
        return '>4'
    " If line is a level 3 subheading
    elseif getline(a:lnum) =~? '\v^\s*\###(#)@!'
        return '>3'
    " If line is a level 2 subheading
    elseif getline(a:lnum) =~? '\v^\s*\##(#)@!'
        return '>2'
    " If line is a level 1 subheading
    elseif getline(a:lnum) =~? '\v^\s*\#(#)@!'
        return '>1'
    else
        return '='
    endif
endfunction

" }}}

" Concealing {{{

" Conceal characters by default in gui
if has("gui_running")
    setlocal conceallevel=2
endif

" Set conceal characters for those that need escaping

" Remove backslash from an escaped star
syntax match star '\v\\\*' conceal cchar=*

" Remove backslash from an escaped underscore
syntax match underscore '\v\\_' conceal cchar=_

" Remove backslash from an escaped backslash
syntax match backslash '\v\\\\' conceal cchar=\

" }}}
