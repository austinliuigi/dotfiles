function! FzfNewBuffer(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
          if a:lines[0] == ''
              execute 'enew'
          else
              execute 'edit ' . a:lines[0]
          endif
      else
          execute 'edit ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewBuffer :call FzfNewBuffer(<bang>0)
nnoremap <silent> <Plug>FzfNewBuffer :FzfNewBuffer<CR>

function! FzfNewWinLeft(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute 'topleft vnew ' . a:lines[0]
      else
          execute 'topleft vnew ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewWinLeft :call FzfNewWinLeft(<bang>0)
nnoremap <silent> <Plug>FzfNewWinLeft :FzfNewWinLeft<CR>

function! FzfNewWinRight(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute 'botright vnew ' . a:lines[0]
      else
          execute 'botright vnew ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewWinRight :call FzfNewWinRight(<bang>0)
nnoremap <silent> <Plug>FzfNewWinRight :FzfNewWinRight<CR>

function! FzfNewWinUp(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute 'topleft new ' . a:lines[0]
      else
          execute 'topleft new ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewWinUp :call FzfNewWinUp(<bang>0)
nnoremap <silent> <Plug>FzfNewWinUp :FzfNewWinUp<CR>

function! FzfNewWinDown(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute 'botright new ' . a:lines[0]
      else
          execute 'botright new ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewWinDown :call FzfNewWinDown(<bang>0)
nnoremap <silent> <Plug>FzfNewWinDown :FzfNewWinDown<CR>

function! FzfNewTabLeft(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute '-tabedit ' . a:lines[0]
      else
          execute '-tabedit ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewTabLeft :call FzfNewTabLeft(<bang>0)
nnoremap <silent> <Plug>FzfNewTabLeft :FzfNewTabLeft<CR>

function! FzfNewTabRight(fullscreen)
    function! s:FzfFileAccept(lines) abort
      " a:lines is a list with three elements (two if there were no matches):
      "   <search-query>, <expect-key>|<empty> [, <selected-items...>]
      if len(a:lines) < 2
          return
      elseif len(a:lines) == 2 || !empty(a:lines[1]) |
              execute 'tabedit ' . a:lines[0]
      else
          execute 'tabedit ' . split(a:lines[2], '#####')[0]
      endif
    endfunction
    let l:spec = {
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-n'],
        \'sink*': funcref('s:FzfFileAccept')
        \}
    call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction
command! -bang FzfNewTabRight :call FzfNewTabRight(<bang>0)
nnoremap <silent> <Plug>FzfNewTabRight :FzfNewTabRight<CR>
