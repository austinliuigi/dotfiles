" :h TextYankPost
" :h Dictionary

" clip.exe is a win program that sends its input to system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'

if executable(s:clip)
    augroup wslyank
        autocmd!
        autocmd TextYankPost * if v:event.regname ==? "p" | call system(s:clip, join(v:event.regcontents, "\n")) | endif
    augroup END
endif


" powershell.exe -Command {command} executes a powershell command as if it were in the command line
let s:has_pshell = executable(glob('/mnt/c/Windows/System32/WindowsPowershell/*/powershell.exe'))
" let s:has_pshell = !empty(system('which powershell.exe'))

function! WslPaste(direction)
    if s:has_pshell
        let tmp = tempname() | exe 'vsplit '.tmp
        read !/mnt/c/Windows/System32/WindowsPowershell/v1.0/powershell.exe -Command Get-Clipboard
        exe 'normal! gg"_dd' | wq
        let clip_content = readfile(tmp)
        " If pasting linewise
        if len(clip_content) > 1
            if a:direction ==? "after"
                call append(line('.'), clip_content)
                exe 'normal! ' . len(clip_content) . 'j"_dd' . len(clip_content)-1 . 'k^'
            else
                call append(line('.')-1, clip_content)
                exe 'normal! k"_dd' . len(clip_content)-1 . 'k^'
            endif
        " If pasting characterwise
        elseif len(clip_content) == 1
            if a:direction ==? "after"
                let str_after_cursor = strpart(getline(line('.')), col('.'))
                if !empty(str_after_cursor)
                    exe 'normal! l"_D'
                endif
            else
                let str_after_cursor = strpart(getline(line('.')), col('.')-1)
                exe 'normal! "_D'
            endif
            call append(line('.'), clip_content)
            join!
            exe 'normal! $'
            let curr_col = col('.')
            call append(line('.'), str_after_cursor)
            join!
            exe 'normal! ' .curr_col. '|'
        endif
        if a:direction ==? "after"
            call repeat#set("\<Plug>WslPasteAfter")
        else
            call repeat#set("\<Plug>WslPasteBefore")
        endif
    endif
endfunction


nnoremap <silent> <Plug>WslPasteAfter :call WslPaste("after")<CR>
nnoremap <silent> <Plug>WslPasteBefore :call WslPaste("before")<CR>

if exists("g:disable_wsl_paste") && g:disable_wsl_paste == 0
    if !hasmapto('<Plug>WslPasteAfter')
        nmap "+p <Plug>WslPasteAfter
        nmap "*p <Plug>WslPasteAfter
    endif
    if !hasmapto('<Plug>WslPasteBefore')
        nmap "+P <Plug>WslPasteBefore
        nmap "*P <Plug>WslPasteBefore
    endif
endif

if exists("g:disable_wsl_yank") && g:disable_wsl_yank == 0
    nnoremap "+ "p
    nnoremap "* "p
endif
