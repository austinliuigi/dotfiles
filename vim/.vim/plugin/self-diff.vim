" This plugin adds two commands that execute a vim diff on a file with
" a past version of itself. 

" Diff current file with last saved state
function! DiffWithLastSave()
    let filetype=&ft
    diffthis
    leftabove vnew | read # | normal! gg"_dd
    exe "setlocal noswapfile readonly bufhidden=delete ft=" . filetype
    diffthis
    autocmd BufDelete <buffer> diffoff!
    " wincmd p
endfunction
command! DiffLastSave call DiffWithLastSave()

" Diff current file with state when opened
let b:changenr_on_load=0
augroup setchangenr
    autocmd!
    autocmd SourcePost,BufReadPost * let b:changenr_on_load=changenr()
augroup END
function! DiffWithOrig()
    let tmpfile=tempname()
    let curchange=changenr()
    exe 'undo ' . b:changenr_on_load
    exe 'w ' . tmpfile
    exe 'undo ' . curchange
    exe 'leftabove vertical diffsplit ' . tmpfile
    setlocal readonly bufhidden=delete
    autocmd BufDelete <buffer> diffoff!
endfunction
command! DiffOrig silent call DiffWithOrig()
