"""Essentials

syntax on						" enable syntax highlighting

filetype plugin indenton		" enable filetype detection, execute filetype-specific ex commands local to the local buffer, and load the indent file for the detected filetype

set encoding=utf-8				" character encoding format

set backspace=start,eol,indent	" better backspace in insert mode

set showcmd


"""Niceties

let $RC="HOME./vim/vimrc"		" define environment variable to alias our vimrc file

set hidden						" allow a buffer to load in a window that currently has a modified buffer

set relativenumber				" make line numbers relative to current line

set number						" show line numbers (only shows current line # with relativenumber set)

set showmatch					" show matching symmetric delimiter

set scrolloff=5					" num of lines to keep above/below cursor

set wildmenu					" command-line autocomplete bar

set lazyredraw					" be conservative with screen refreshes

"set directory=~/tmp

"set backupdir=~/tmp


""" Whitespace

set tabstop=4					" length of <tab> when it is displayed

set softtabstop=4				" length of <tab> (& respective <bksp>) when you type it

set shiftwidth=4				" indent length

set expandtab					" tab will act as spaces (makes its length consistent across all platforms)

set autoindent					" indent to the previous line's indent level

set smartindent					" indent based on c syntax


""" Searching

set incsearch					" search as you type

set hlsearch					" search highlighting


""" Mappings

inoremap jk <esc>

nnoremap <space>h :nohlsearch<CR>