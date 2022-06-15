" This plugin adds two commands that execute a vim diff on a file with
" a past version of itself. 

" Diff current file with last saved state
function! DiffWithLastSave()
    let tmpfile=tempname()
    let filetype=&ft
    diffthis
    leftabove vnew | read # | normal! gg"_dd
    exe 'w ' . tmpfile
    exe "setlocal noswapfile readonly bufhidden=delete ft=" . filetype
    diffthis
    nnoremap <buffer> q :q<CR>
    autocmd BufDelete <buffer> diffoff!
    " wincmd p
endfunction
command! DiffWithLastSave call DiffWithLastSave()

" Diff current file with state when opened
let b:changenr_on_load=0
augroup setchangenr
    autocmd!
    autocmd SourcePost,BufReadPost * let b:changenr_on_load=changenr()
augroup END
function! DiffWithOpened()
    let tmpfile=tempname()
    let curchange=changenr()
    exe 'undo ' . b:changenr_on_load
    exe 'w ' . tmpfile
    exe 'undo ' . curchange
    exe 'leftabove vertical diffsplit ' . tmpfile
    setlocal readonly bufhidden=delete
    nnoremap <buffer> q :q<CR>
    autocmd BufDelete <buffer> diffoff!
endfunction
command! DiffWithOpened silent call DiffWithOpened()

nnoremap <silent> <Plug>DiffWithLastSave :<C-U>call DiffWithLastSave()<CR>
nnoremap <silent> <Plug>DiffWithOpened :<C-U>silent call DiffWithOpened()<CR>
