function! ToTopQuarter()
    normal! H
    let top_linenr = line('.')
    if top_linenr != 1
        let top_linenr = top_linenr - &scrolloff
    endif
    normal! M
    let middle_linenr = line('.')
    let jump_count = (middle_linenr - top_linenr)/2
    execute 'normal! ' . jump_count . 'k'
endfunction

function! ToBottomQuarter()
    normal! L
    let bottom_linenr = line('.')
    if bottom_linenr != line('$')
        let bottom_linenr = bottom_linenr + &scrolloff
    endif
    normal! M
    let middle_linenr = line('.')
    let jump_count = (bottom_linenr - middle_linenr)/2
    execute 'normal! ' . jump_count . 'j'
endfunction

nnoremap <silent> <Plug>ToTopQuarter :call ToTopQuarter()<CR>
nnoremap <silent> <Plug>ToBottomQuarter :call ToBottomQuarter()<CR>
