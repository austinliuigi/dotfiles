" Name:     Custom Color Scheme
" Author:   Austin Liu
" Created:  July 30, 2021
" Modified: August 17, 2021
"
" Resources "{{{
"
" Useful commands for testing colorschemes:
" :source $VIMRUNTIME/syntax/hitest.vim
" :help highlight-groups
" :help cterm-colors
" :help group-name
"
" Useful links for developing colorschemes:
" http://www.vim.org/scripts/script.php?script_id=2937
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" http://www.frexx.de/xterm-256-notes/"
"
" }}}
" Environment Specific Overrides "{{{
" Allow or disallow certain features based on current terminal emulator or 
" environment.

" Terminals that support italics
let s:terms_italic=[
            \"rxvt",
            \"gnome-terminal"
            \]
" For reference only, terminals are known to be incomptible.
" Terminals that are in neither list need to be tested.
let s:terms_noitalic=[
            \"iTerm.app",
            \"Apple_Terminal"
            \]
if has("gui_running")
    let s:terminal_italic=1 " TODO: could refactor to not require this at all
else
    let s:terminal_italic=0 " terminals will be guilty until proven compatible
    for term in s:terms_italic
        if $TERM_PROGRAM =~ term
            let s:terminal_italic=1
        endif
    endfor
endif

" }}}
" Default Option Values"{{{
" ---------------------------------------------------------------------
function! s:SetOption(name,default)
    if type(a:default) == type(0)
        let l:wrap=''
        let l:ewrap=''
    else
        let l:wrap='"'
        let l:ewrap='\"'
    endif
    if !exists("g:scheme_".a:name) || g:scheme_{a:name}==a:default
        exe 'let g:scheme_'.a:name.'='.l:wrap.a:default.l:wrap.'"'
    endif
endfunction

if ($TERM_PROGRAM ==? "apple_terminal" && &t_Co < 256)
    let s:scheme_termtrans_default = 1
else
    let s:scheme_termtrans_default = 0
endif
call s:SetOption("termtrans",s:scheme_termtrans_default)
call s:SetOption("bold",1)
call s:SetOption("underline",1)
call s:SetOption("italic",1) " note that we need to override this later if the terminal doesn't support
call s:SetOption("diffmode","normal")
call s:SetOption("hitrail",0)

"}}}
" Colorscheme Initialization "{{{
" ---------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "custom"

"}}}
" Set Colors"{{{
" ---------------------------------------------------------------------
"
" Set both gui and terminal color values in separate conditional statements
" Due to possibility that CSApprox is running (though I suppose we could just
" leave the hex values out entirely in that case and include only cterm colors)
if (has("gui_running"))
    let s:vmode       = "gui"
    let s:back        = "#303030" "background
    let s:dgray       = "#3a3a3a" "cursorline
    let s:mdgray      = "#585858" "listchars
    let s:mgray       = "#9e9e9e" "comments
    let s:lgray       = "#a8a8a8" "statusline inactive
    let s:vlgray      = "#dadada"
    let s:dwhite      = "#e4e4e4" "statusline active
    let s:mwhite      = "#eeeeee" "primary text
    let s:white       = "#ffffff" "emphasized text
    let s:yellow      = "#d7af00"
    let s:green       = "#afaf00"
    let s:red         = "#af5f5f"
    let s:magenta     = "#d7afaf"
    let s:violet      = "#afafff"
    let s:blue        = "#afd7d7"
    let s:cyan        = "#87afaf"
    let s:ygreen      = "#d7d75f" 
else
    let s:vmode       = "cterm"
    let s:back        = "236" "background
    let s:dgray       = "237" "cursorline
    let s:mdgray      = "240" "listchars
    let s:mgray       = "247" "comments
    let s:lgray       = "248" "statusline inactive
    let s:vlgray      = "253"
    let s:dwhite      = "254" "statusline active
    let s:mwhite      = "255" "primary text
    let s:white       = "231" "emphasized text
    let s:yellow      = "178"
    let s:green       = "142"
    let s:red         = "131"
    let s:magenta     = "181"
    let s:violet      = "147"
    let s:blue        = "152"
    let s:cyan        = "109"
    let s:ygreen      = "185"
endif
"}}}
" Formatting options and null values for passthrough effect "{{{
" ---------------------------------------------------------------------
    let s:none            = "NONE"
    let s:none            = "NONE"
    let s:t_none          = "NONE"
    let s:n               = "NONE"
    let s:c               = ",undercurl"
    let s:r               = ",reverse"
    let s:s               = ",standout"
    let s:ou              = ""
    let s:ob              = ""
"}}}
" Background value based on termtrans setting "{{{
" ---------------------------------------------------------------------
if (has("gui_running") || g:scheme_termtrans == 0)
    let s:backtp        = s:back
else
    let s:backtp        = "NONE"
    let s:dgray         = "236"
endif
"}}}
" Overrides dependent on user specified values and environment "{{{
" ---------------------------------------------------------------------
if (g:scheme_bold == 0 || &t_Co == 8 )
    let s:b           = ""
    let s:bb          = ",bold"
else
    let s:b           = ",bold"
    let s:bb          = ""
endif

if g:scheme_underline == 0
    let s:u           = ""
else
    let s:u           = ",underline"
endif

if g:scheme_italic == 0 " || s:terminal_italic == 0
    let s:i           = ""
else
    let s:i           = ",italic"
endif
"}}}
" Highlighting Primitives"{{{
" ---------------------------------------------------------------------

exe "let s:bg_none      = ' ".s:vmode."bg=".s:none   ."'"
exe "let s:bg_backtp    = ' ".s:vmode."bg=".s:backtp ."'"
exe "let s:bg_back      = ' ".s:vmode."bg=".s:back ."'"
exe "let s:bg_dgray     = ' ".s:vmode."bg=".s:dgray ."'"
exe "let s:bg_mdgray    = ' ".s:vmode."bg=".s:mdgray ."'"
exe "let s:bg_mgray     = ' ".s:vmode."bg=".s:mgray ."'"
exe "let s:bg_vlgray    = ' ".s:vmode."bg=".s:vlgray ."'"
exe "let s:bg_mwhite    = ' ".s:vmode."bg=".s:mwhite  ."'"
exe "let s:bg_dwhite    = ' ".s:vmode."bg=".s:dwhite  ."'"
exe "let s:bg_white     = ' ".s:vmode."bg=".s:white  ."'"
exe "let s:bg_lgray     = ' ".s:vmode."bg=".s:lgray  ."'"
exe "let s:bg_ygreen    = ' ".s:vmode."bg=".s:ygreen  ."'"
exe "let s:bg_yellow    = ' ".s:vmode."bg=".s:yellow ."'"
exe "let s:bg_green     = ' ".s:vmode."bg=".s:green ."'"
exe "let s:bg_red       = ' ".s:vmode."bg=".s:red    ."'"
exe "let s:bg_magenta   = ' ".s:vmode."bg=".s:magenta."'"
exe "let s:bg_violet    = ' ".s:vmode."bg=".s:violet ."'"
exe "let s:bg_blue      = ' ".s:vmode."bg=".s:blue   ."'"
exe "let s:bg_cyan      = ' ".s:vmode."bg=".s:cyan   ."'"

exe "let s:fg_none      = ' ".s:vmode."fg=".s:none   ."'"
exe "let s:fg_backtp    = ' ".s:vmode."fg=".s:backtp ."'"
exe "let s:fg_back      = ' ".s:vmode."fg=".s:back ."'"
exe "let s:fg_dgray     = ' ".s:vmode."fg=".s:dgray ."'"
exe "let s:fg_mdgray     = ' ".s:vmode."fg=".s:mdgray ."'"
exe "let s:fg_mgray     = ' ".s:vmode."fg=".s:mgray ."'"
exe "let s:fg_vlgray    = ' ".s:vmode."fg=".s:vlgray ."'"
exe "let s:fg_mwhite    = ' ".s:vmode."fg=".s:mwhite  ."'"
exe "let s:fg_dwhite     = ' ".s:vmode."fg=".s:dwhite  ."'"
exe "let s:fg_white     = ' ".s:vmode."fg=".s:white  ."'"
exe "let s:fg_lgray     = ' ".s:vmode."fg=".s:lgray  ."'"
exe "let s:fg_ygreen     = ' ".s:vmode."fg=".s:ygreen  ."'"
exe "let s:fg_yellow    = ' ".s:vmode."fg=".s:yellow ."'"
exe "let s:fg_green    = ' ".s:vmode."fg=".s:green ."'"
exe "let s:fg_red       = ' ".s:vmode."fg=".s:red    ."'"
exe "let s:fg_magenta   = ' ".s:vmode."fg=".s:magenta."'"
exe "let s:fg_violet    = ' ".s:vmode."fg=".s:violet ."'"
exe "let s:fg_blue      = ' ".s:vmode."fg=".s:blue   ."'"
exe "let s:fg_cyan      = ' ".s:vmode."fg=".s:cyan   ."'"

exe "let s:fmt_none     = ' ".s:vmode."=NONE".          " term=NONE".    "'"
exe "let s:fmt_bold     = ' ".s:vmode."=NONE".s:b.      " term=NONE".s:b."'"
exe "let s:fmt_bldi     = ' ".s:vmode."=NONE".s:b.s:i.  " term=NONE".s:b.s:i."'"
exe "let s:fmt_undr     = ' ".s:vmode."=NONE".s:u.      " term=NONE".s:u."'"
exe "let s:fmt_undb     = ' ".s:vmode."=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi     = ' ".s:vmode."=NONE".s:u.s:i.  " term=NONE".s:u.s:i."'"
exe "let s:fmt_uopt     = ' ".s:vmode."=NONE".s:ou.     " term=NONE".s:ou."'"
exe "let s:fmt_curl     = ' ".s:vmode."=NONE".s:c.      " term=NONE".s:c."'"
exe "let s:fmt_ital     = ' ".s:vmode."=NONE".s:i.      " term=NONE".s:i."'"
exe "let s:fmt_stnd     = ' ".s:vmode."=NONE".s:s.      " term=NONE".s:s."'"
exe "let s:fmt_revr     = ' ".s:vmode."=NONE".s:r.      " term=NONE".s:r."'"
exe "let s:fmt_revb     = ' ".s:vmode."=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"
" revbb (reverse bold for bright colors) is only set to actual bold in low 
" color terminals (t_co=8, such as OS X Terminal.app) and should only be used 
" with colors 8-15.
exe "let s:fmt_revbb    = ' ".s:vmode."=NONE".s:r.s:bb.   " term=NONE".s:r.s:bb."'"
exe "let s:fmt_revbbu   = ' ".s:vmode."=NONE".s:r.s:bb.s:u." term=NONE".s:r.s:bb.s:u."'"

if has("gui_running")
    exe "let s:sp_none      = ' guisp=".s:none   ."'"
    exe "let s:sp_backtp    = ' guisp=".s:backtp ."'"
    exe "let s:sp_back      = ' guisp=".s:back ."'"
    exe "let s:sp_dgray     = ' guisp=".s:dgray ."'"
    exe "let s:sp_mdgray     = ' guisp=".s:mdgray ."'"
    exe "let s:sp_mgray     = ' guisp=".s:mgray ."'"
    exe "let s:sp_vlgray    = ' guisp=".s:vlgray ."'"
    exe "let s:sp_mwhite    = ' guisp=".s:mwhite  ."'"
    exe "let s:sp_dwhite    = ' guisp=".s:dwhite  ."'"
    exe "let s:sp_white     = ' guisp=".s:white  ."'"
    exe "let s:sp_lgray     = ' guisp=".s:lgray  ."'"
    exe "let s:sp_ygreen     = ' guisp=".s:ygreen  ."'"
    exe "let s:sp_yellow    = ' guisp=".s:yellow ."'"
    exe "let s:sp_green    = ' guisp=".s:green ."'"
    exe "let s:sp_red       = ' guisp=".s:red    ."'"
    exe "let s:sp_magenta   = ' guisp=".s:magenta."'"
    exe "let s:sp_violet    = ' guisp=".s:violet ."'"
    exe "let s:sp_blue      = ' guisp=".s:blue   ."'"
    exe "let s:sp_cyan      = ' guisp=".s:cyan   ."'"
else
    let s:sp_none      = ""
    let s:sp_backtp    = ""
    let s:sp_back      = ""
    let s:sp_dgray     = ""
    let s:sp_mdgray     = ""
    let s:sp_mgray     = ""
    let s:sp_vlgray    = ""
    let s:sp_mwhite    = ""
    let s:sp_dwhite    = ""
    let s:sp_white     = ""
    let s:sp_lgray     = ""
    let s:sp_ygreen     = ""
    let s:sp_yellow    = ""
    let s:sp_green    = ""
    let s:sp_red       = ""
    let s:sp_magenta   = ""
    let s:sp_violet    = ""
    let s:sp_blue      = ""
    let s:sp_cyan      = ""
endif

"}}}
" Basic highlighting"{{{
" ---------------------------------------------------------------------
" note that link syntax to avoid duplicate configuration doesn't work with the
" exe compiled formats

exe "hi! Normal"         .s:fmt_none   .s:fg_mwhite  .s:bg_backtp

exe "hi! Comment"        .s:fmt_ital   .s:fg_mgray .s:bg_none
"       *Comment         any comment

exe "hi! Constant"       .s:fmt_none   .s:fg_magenta   .s:bg_none
"       *Constant        any constant
"        String          a string constant: "this is a string"
"        Character       a character constant: 'c', '\n'
"        Number          a number constant: 234, 0xff
"        Boolean         a boolean constant: TRUE, false
"        Float           a floating point constant: 2.3e10

exe "hi! Identifier"     .s:fmt_none   .s:fg_blue   .s:bg_none
"       *Identifier      any variable name
"        Function        function name (also: methods for classes)
"
exe "hi! Statement"      .s:fmt_none   .s:fg_ygreen  .s:bg_none
"       *Statement       any statement
"        Conditional     if, then, else, endif, switch, etc.
"        Repeat          for, do, while, etc.
"        Label           case, default, etc.
"        Operator        "sizeof", "+", "*", etc.
"        Keyword         any other keyword
"        Exception       try, catch, throw

exe "hi! PreProc"        .s:fmt_none   .s:fg_green .s:bg_none
"       *PreProc         generic Preprocessor
"        Include         preprocessor #include
"        Define          preprocessor #define
"        Macro           same as Define
"        PreCondit       preprocessor #if, #else, #endif, etc.

exe "hi! Type"           .s:fmt_none   .s:fg_yellow .s:bg_none
"       *Type            int, long, char, etc.
"        StorageClass    static, register, volatile, etc.
"        Structure       struct, union, enum, etc.
"        Typedef         A typedef

exe "hi! Special"        .s:fmt_none   .s:fg_red    .s:bg_none
"       *Special         any special symbol
"        SpecialChar     special character in a constant
"        Tag             you can use CTRL-] on this
"        Delimiter       character that needs attention
"        SpecialComment  special things inside a comment
"        Debug           debugging statements

exe "hi! Underlined"     .s:fmt_none   .s:fg_violet .s:bg_none
"       *Underlined      text that stands out, HTML links

exe "hi! Ignore"         .s:fmt_none   .s:fg_none   .s:bg_none
"       *Ignore          left blank, hidden  |hl-Ignore|

exe "hi! Error"          .s:fmt_bold   .s:fg_red    .s:bg_none
"       *Error           any erroneous construct

exe "hi! Todo"           .s:fmt_bold   .s:fg_red    .s:bg_none
"       *Todo            anything that needs extra attention; mostly the
"                        keywords TODO FIXME and XXX
"
"}}}
" Extended highlighting "{{{
" ---------------------------------------------------------------------

exe "hi! User1"          .s:fmt_bold   .s:fg_vlgray .s:bg_dgray
exe "hi! User2"          .s:fmt_bold   .s:fg_white  .s:bg_cyan
exe "hi! User3"          .s:fmt_bold   .s:fg_white  .s:bg_yellow
exe "hi! User4"          .s:fmt_bold   .s:fg_dgray  .s:bg_mgray
exe "hi! User5"          .s:fmt_bold   .s:fg_white  .s:bg_red
exe "hi! User6"          .s:fmt_bold   .s:fg_white  .s:bg_green
exe "hi! User7"          .s:fmt_bold   .s:fg_mgray  .s:bg_dwhite
exe "hi! User8"          .s:fmt_bold   .s:fg_red    .s:bg_white
exe "hi! User9"          .s:fmt_bold   .s:fg_red    .s:bg_mgray
exe "hi! SpecialKey"     .s:fmt_bold   .s:fg_mdgray  .s:bg_none
exe "hi! NonText"        .s:fmt_bold   .s:fg_mdgray  .s:bg_none
exe "hi! StatusLine"     .s:fmt_none   .s:fg_white  .s:bg_cyan .s:fmt_revbb
exe "hi! StatusLineNC"   .s:fmt_none   .s:fg_mgray  .s:bg_dwhite .s:fmt_revbb
exe "hi! Visual"         .s:fmt_none   .s:fg_mgray  .s:bg_back  .s:fmt_revbb
exe "hi! Directory"      .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! ErrorMsg"       .s:fmt_revr   .s:fg_red    .s:bg_none
exe "hi! IncSearch"      .s:fmt_stnd   .s:fg_ygreen .s:bg_none
exe "hi! Search"         .s:fmt_revr   .s:fg_yellow .s:bg_none
exe "hi! MoreMsg"        .s:fmt_none   .s:fg_ygreen  .s:bg_none
exe "hi! ModeMsg"        .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! LineNr"         .s:fmt_none   .s:fg_mgray  .s:bg_backtp
exe "hi! Question"       .s:fmt_bold   .s:fg_ygreen  .s:bg_none
exe "hi! VertSplit"      .s:fmt_none   .s:fg_dgray  .s:bg_lgray
exe "hi! Title"          .s:fmt_bold   .s:fg_yellow .s:bg_none
exe "hi! VisualNOS"      .s:fmt_stnd   .s:fg_none   .s:bg_dgray .s:fmt_revbb
exe "hi! WarningMsg"     .s:fmt_bold   .s:fg_red    .s:bg_none
exe "hi! WildMenu"       .s:fmt_none   .s:fg_yellow .s:bg_dgray .s:fmt_revbb
exe "hi! Folded"         .s:fmt_undb   .s:fg_vlgray .s:bg_none .s:sp_back
exe "hi! FoldColumn"     .s:fmt_none   .s:fg_mwhite .s:bg_dgray
if      (g:scheme_diffmode=="high")
exe "hi! DiffAdd"        .s:fmt_revr   .s:fg_ygreen  .s:bg_none
exe "hi! DiffChange"     .s:fmt_revr   .s:fg_yellow .s:bg_none
exe "hi! DiffDelete"     .s:fmt_revr   .s:fg_red    .s:bg_none
exe "hi! DiffText"       .s:fmt_revr   .s:fg_blue   .s:bg_none
elseif  (g:scheme_diffmode=="low")
exe "hi! DiffAdd"        .s:fmt_undr   .s:fg_ygreen  .s:bg_none  .s:sp_ygreen
exe "hi! DiffChange"     .s:fmt_undr   .s:fg_yellow .s:bg_none  .s:sp_yellow
exe "hi! DiffDelete"     .s:fmt_bold   .s:fg_red    .s:bg_none
exe "hi! DiffText"       .s:fmt_undr   .s:fg_blue   .s:bg_none  .s:sp_blue
else " normal
    if has("gui_running")
exe "hi! DiffAdd"        .s:fmt_bold   .s:fg_ygreen  .s:bg_dgray .s:sp_ygreen
exe "hi! DiffChange"     .s:fmt_bold   .s:fg_yellow .s:bg_dgray .s:sp_yellow
exe "hi! DiffDelete"     .s:fmt_bold   .s:fg_red    .s:bg_dgray
exe "hi! DiffText"       .s:fmt_bold   .s:fg_blue   .s:bg_dgray .s:sp_blue
    else
exe "hi! DiffAdd"        .s:fmt_none   .s:fg_ygreen  .s:bg_dgray .s:sp_ygreen
exe "hi! DiffChange"     .s:fmt_none   .s:fg_yellow .s:bg_dgray .s:sp_yellow
exe "hi! DiffDelete"     .s:fmt_none   .s:fg_red    .s:bg_dgray
exe "hi! DiffText"       .s:fmt_none   .s:fg_blue   .s:bg_dgray .s:sp_blue
    endif
endif
exe "hi! SignColumn"     .s:fmt_none   .s:fg_mwhite
exe "hi! Conceal"        .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! SpellBad"       .s:fmt_curl   .s:fg_none   .s:bg_none   .s:sp_red
exe "hi! SpellCap"       .s:fmt_curl   .s:fg_none   .s:bg_none   .s:sp_violet
exe "hi! SpellRare"      .s:fmt_curl   .s:fg_none   .s:bg_none   .s:sp_cyan
exe "hi! SpellLocal"     .s:fmt_curl   .s:fg_none   .s:bg_none   .s:sp_yellow
exe "hi! Pmenu"          .s:fmt_none   .s:fg_mwhite .s:bg_dgray  .s:fmt_revbb
exe "hi! PmenuSel"       .s:fmt_none   .s:fg_mgray  .s:bg_dwhite  .s:fmt_revbb
exe "hi! PmenuSbar"      .s:fmt_none   .s:fg_dwhite .s:bg_mwhite .s:fmt_revbb
exe "hi! PmenuThumb"     .s:fmt_none   .s:fg_mwhite .s:bg_back   .s:fmt_revbb
exe "hi! TabLine"        .s:fmt_undr   .s:fg_mwhite .s:bg_dgray  .s:sp_mwhite
exe "hi! TabLineFill"    .s:fmt_undr   .s:fg_mwhite .s:bg_dgray  .s:sp_mwhite
exe "hi! TabLineSel"     .s:fmt_undr   .s:fg_mgray  .s:bg_dwhite  .s:sp_mwhite  .s:fmt_revbbu
exe "hi! CursorColumn"   .s:fmt_none   .s:fg_none   .s:bg_dgray
exe "hi! CursorLine"     .s:fmt_uopt   .s:fg_none   .s:bg_dgray  .s:sp_white
exe "hi! CursorLineNr"   .s:fmt_none   .s:fg_white  .s:bg_none
exe "hi! ColorColumn"    .s:fmt_none   .s:fg_none   .s:bg_dgray
exe "hi! Cursor"         .s:fmt_none   .s:fg_back   .s:bg_mwhite
hi! link lCursor Cursor
exe "hi! MatchParen"     .s:fmt_bold   .s:fg_red    .s:bg_dgray
exe "hi! EndOfBuffer"    .s:fmt_none   .s:fg_yellow .s:bg_none

"}}}
" vim syntax highlighting "{{{
" ---------------------------------------------------------------------
"exe "hi! vimLineComment" . s:fg_mgray .s:bg_none   .s:fmt_ital
"hi! link vimComment Comment
"hi! link vimLineComment Comment
hi! link vimVar Identifier
hi! link vimFunc Function
hi! link vimUserFunc Function
hi! link helpSpecial Special
hi! link vimSet Normal
hi! link vimSetEqual Normal
exe "hi! vimCommentString"  .s:fmt_none    .s:fg_violet .s:bg_none
exe "hi! vimCommand"        .s:fmt_none    .s:fg_yellow .s:bg_none
exe "hi! vimCmdSep"         .s:fmt_bold    .s:fg_blue   .s:bg_none
exe "hi! helpExample"       .s:fmt_none    .s:fg_white  .s:bg_none
exe "hi! helpOption"        .s:fmt_none    .s:fg_cyan   .s:bg_none
exe "hi! helpNote"          .s:fmt_none    .s:fg_magenta.s:bg_none
exe "hi! helpVim"           .s:fmt_none    .s:fg_magenta.s:bg_none
exe "hi! helpHyperTextJump" .s:fmt_undr    .s:fg_blue   .s:bg_none
exe "hi! helpHyperTextEntry".s:fmt_none    .s:fg_ygreen  .s:bg_none
exe "hi! vimIsCommand"      .s:fmt_none    .s:fg_vlgray .s:bg_none
exe "hi! vimSynMtchOpt"     .s:fmt_none    .s:fg_yellow .s:bg_none
exe "hi! vimSynType"        .s:fmt_none    .s:fg_cyan   .s:bg_none
exe "hi! vimHiLink"         .s:fmt_none    .s:fg_blue   .s:bg_none
exe "hi! vimHiGroup"        .s:fmt_none    .s:fg_blue   .s:bg_none
exe "hi! vimGroup"          .s:fmt_undb    .s:fg_blue   .s:bg_none
"}}}
" diff highlighting "{{{
" ---------------------------------------------------------------------
hi! link diffAdded Statement
hi! link diffLine Identifier
"}}}
" git & gitcommit highlighting "{{{
"git
"exe "hi! gitDateHeader"
"exe "hi! gitIdentityHeader"
"exe "hi! gitIdentityKeyword"
"exe "hi! gitNotesHeader"
"exe "hi! gitReflogHeader"
"exe "hi! gitKeyword"
"exe "hi! gitIdentity"
"exe "hi! gitEmailDelimiter"
"exe "hi! gitEmail"
"exe "hi! gitDate"
"exe "hi! gitMode"
"exe "hi! gitHashAbbrev"
"exe "hi! gitHash"
"exe "hi! gitReflogMiddle"
"exe "hi! gitReference"
"exe "hi! gitStage"
"exe "hi! gitType"
"exe "hi! gitDiffAdded"
"exe "hi! gitDiffRemoved"
"gitcommit
"exe "hi! gitcommitSummary"      
exe "hi! gitcommitComment"      .s:fmt_ital     .s:fg_mgray    .s:bg_none
hi! link gitcommitUntracked gitcommitComment
hi! link gitcommitDiscarded gitcommitComment
hi! link gitcommitSelected  gitcommitComment
exe "hi! gitcommitUnmerged"     .s:fmt_bold     .s:fg_ygreen     .s:bg_none
exe "hi! gitcommitOnBranch"     .s:fmt_bold     .s:fg_mgray    .s:bg_none
exe "hi! gitcommitBranch"       .s:fmt_bold     .s:fg_magenta   .s:bg_none
hi! link gitcommitNoBranch gitcommitBranch
exe "hi! gitcommitDiscardedType".s:fmt_none     .s:fg_red       .s:bg_none
exe "hi! gitcommitSelectedType" .s:fmt_none     .s:fg_ygreen     .s:bg_none
"exe "hi! gitcommitUnmergedType"
"exe "hi! gitcommitType"
"exe "hi! gitcommitNoChanges"
"exe "hi! gitcommitHeader"
exe "hi! gitcommitHeader"       .s:fmt_none     .s:fg_mgray    .s:bg_none
exe "hi! gitcommitUntrackedFile".s:fmt_bold     .s:fg_cyan      .s:bg_none
exe "hi! gitcommitDiscardedFile".s:fmt_bold     .s:fg_red       .s:bg_none
exe "hi! gitcommitSelectedFile" .s:fmt_bold     .s:fg_ygreen     .s:bg_none
exe "hi! gitcommitUnmergedFile" .s:fmt_bold     .s:fg_yellow    .s:bg_none
exe "hi! gitcommitFile"         .s:fmt_bold     .s:fg_mwhite     .s:bg_none
hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
hi! link gitcommitSelectedArrow  gitcommitSelectedFile
hi! link gitcommitUnmergedArrow  gitcommitUnmergedFile
"exe "hi! gitcommitArrow"
"exe "hi! gitcommitOverflow"
"exe "hi! gitcommitBlank"
" }}}
" html highlighting "{{{
" ---------------------------------------------------------------------
exe "hi! htmlTag"           .s:fmt_none .s:fg_mgray .s:bg_none
exe "hi! htmlEndTag"        .s:fmt_none .s:fg_mgray .s:bg_none
exe "hi! htmlTagN"          .s:fmt_bold .s:fg_white  .s:bg_none
exe "hi! htmlTagName"       .s:fmt_bold .s:fg_blue   .s:bg_none
exe "hi! htmlSpecialTagName".s:fmt_ital .s:fg_blue   .s:bg_none
exe "hi! htmlArg"           .s:fmt_none .s:fg_vlgray .s:bg_none
exe "hi! javaScript"        .s:fmt_none .s:fg_yellow .s:bg_none
"}}}
" perl highlighting "{{{
" ---------------------------------------------------------------------
exe "hi! perlHereDoc"    . s:fg_white  .s:bg_backtp   .s:fmt_none
exe "hi! perlVarPlain"   . s:fg_yellow .s:bg_backtp   .s:fmt_none
exe "hi! perlStatementFileDesc". s:fg_cyan. s:bg_backtp .s:fmt_none

"}}}
" tex highlighting "{{{
" ---------------------------------------------------------------------
exe "hi! texStatement"   . s:fg_cyan   .s:bg_backtp   .s:fmt_none
exe "hi! texMathZoneX"   . s:fg_yellow .s:bg_backtp   .s:fmt_none
exe "hi! texMathMatcher" . s:fg_yellow .s:bg_backtp   .s:fmt_none
exe "hi! texMathMatcher" . s:fg_yellow .s:bg_backtp   .s:fmt_none
exe "hi! texRefLabel"    . s:fg_yellow .s:bg_backtp   .s:fmt_none
"}}}
" ruby highlighting "{{{
" ---------------------------------------------------------------------
exe "hi! rubyDefine"     . s:fg_white  .s:bg_backtp   .s:fmt_bold
"rubyInclude
"rubySharpBang
"rubyAccess
"rubyPredefinedVariable
"rubyBoolean
"rubyClassVariable
"rubyBeginEnd
"rubyRepeatModifier
"hi! link rubyArrayDelimiter    Special  " [ , , ]
"rubyCurlyBlock  { , , }

"hi! link rubyClass             Keyword
"hi! link rubyModule            Keyword
"hi! link rubyKeyword           Keyword
"hi! link rubyOperator          Operator
"hi! link rubyIdentifier        Identifier
"hi! link rubyInstanceVariable  Identifier
"hi! link rubyGlobalVariable    Identifier
"hi! link rubyClassVariable     Identifier
"hi! link rubyConstant          Type
"}}}
" haskell syntax highlighting"{{{
" ---------------------------------------------------------------------
" For use with syntax/haskell.vim : Haskell Syntax File
" http://www.vim.org/scripts/script.php?script_id=3034
" See also Steffen Siering's github repository:
" http://github.com/urso/dotrc/blob/master/vim/syntax/haskell.vim
" ---------------------------------------------------------------------
"
" Treat True and False specially, see the plugin referenced above
let hs_highlight_boolean=1
" highlight delims, see the plugin referenced above
let hs_highlight_delimiters=1

exe "hi! cPreCondit". s:fg_green.s:bg_none   .s:fmt_none

exe "hi! VarId"    . s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! ConId"    . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi! hsImport" . s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi! hsString" . s:fg_vlgray .s:bg_none   .s:fmt_none

exe "hi! hsStructure"        . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hs_hlFunctionName"  . s:fg_blue   .s:bg_none
exe "hi! hsStatement"        . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hsImportLabel"      . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hs_OpFunctionName"  . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi! hs_DeclareFunction" . s:fg_green .s:bg_none   .s:fmt_none
exe "hi! hsVarSym"           . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hsType"             . s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi! hsTypedef"          . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hsModuleName"       . s:fg_ygreen  .s:bg_none   .s:fmt_undr
exe "hi! hsModuleStartLabel" . s:fg_magenta.s:bg_none   .s:fmt_none
hi! link hsImportParams      Delimiter
hi! link hsDelimTypeExport   Delimiter
hi! link hsModuleStartLabel  hsStructure
hi! link hsModuleWhereLabel  hsModuleStartLabel

" following is for the haskell-conceal plugin
" the first two items don't have an impact, but better safe
exe "hi! hsNiceOperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! hsniceoperator"     . s:fg_cyan   .s:bg_none   .s:fmt_none

"}}}
" Markdown Highlighting"{{{
" exe "hi! markdownAutomaticLink"
" exe "hi! markdownBlockQuote"
exe "hi! markdownBold"                  . s:fmt_bold    .s:fg_none      .s:bg_none
exe "hi! markdownBoldDelimiter"         . s:fmt_bold    .s:fg_violet   .s:bg_none
exe "hi! markdownBoldItalic"            . s:fmt_bldi    .s:fg_none      .s:bg_none
exe "hi! markdownBoldItalicDelimiter"   . s:fmt_bldi    .s:fg_violet      .s:bg_none
" exe "hi! markdownCodeDelimiter"
" exe "hi! markdownError"
" exe "hi! markdownEscape"
" exe "hi! markdownFootnote"
" exe "hi! markdownFootnoteDefinition"
exe "hi! markdownH1"                    . s:fmt_bold    .s:fg_yellow    .s:bg_none
exe "hi! markdownH2"                    . s:fmt_bold    .s:fg_ygreen    .s:bg_none
hi! link markdownH3 markdownH2
hi! link markdownH4 markdownH2
hi! link markdownH5 markdownH2
hi! link markdownH6 markdownH2
exe "hi! markdownHeadingDelimiter"      . s:fmt_bold    .s:fg_magenta    .s:bg_none
" exe "hi! markdownHeadingRule"
" exe "hi! markdownId"
" exe "hi! markdownIdDeclaration"
" exe "hi! markdownIdDelimiter"
exe "hi! markdownItalic"                . s:fmt_ital    .s:fg_none      .s:bg_none
exe "hi! markdownItalicDelimiter"       . s:fmt_ital    .s:fg_violet    .s:bg_none
" exe "hi! markdownLinkText"
exe "hi! markdownListMarker"            . s:fmt_none    .s:fg_blue      .s:bg_none
hi! link markdownOrderedListMarker markdownListMarker
" exe "hi! markdownRule"
" exe "hi! markdownUrl"
" exe "hi! markdownUrlDelimiter"
" exe "hi! markdownUrlTitle"
" exe "hi! markdownUrlTitleDelimiter"
"}}}
" pandoc markdown syntax highlighting "{{{
" ---------------------------------------------------------------------

"PandocHiLink pandocNormalBlock
exe "hi! pandocTitleBlock"               .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! pandocTitleBlockTitle"          .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi! pandocTitleComment"             .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi! pandocComment"                  .s:fg_mgray .s:bg_none   .s:fmt_ital
exe "hi! pandocVerbatimBlock"            .s:fg_yellow .s:bg_none   .s:fmt_none
hi! link pandocVerbatimBlockDeep         pandocVerbatimBlock
hi! link pandocCodeBlock                 pandocVerbatimBlock
hi! link pandocCodeBlockDelim            pandocVerbatimBlock
exe "hi! pandocBlockQuote"               .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader1"        .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader2"        .s:fg_cyan   .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader3"        .s:fg_yellow .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader4"        .s:fg_red    .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader5"        .s:fg_mwhite  .s:bg_none   .s:fmt_none
exe "hi! pandocBlockQuoteLeader6"        .s:fg_mgray .s:bg_none   .s:fmt_none
exe "hi! pandocListMarker"               .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi! pandocListReference"            .s:fg_magenta.s:bg_none   .s:fmt_undr

" Definitions
" ---------------------------------------------------------------------
let s:fg_pdef = s:fg_violet
exe "hi! pandocDefinitionBlock"              .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi! pandocDefinitionTerm"               .s:fg_pdef  .s:bg_none  .s:fmt_stnd
exe "hi! pandocDefinitionIndctr"             .s:fg_pdef  .s:bg_none  .s:fmt_bold
exe "hi! pandocEmphasisDefinition"           .s:fg_pdef  .s:bg_none  .s:fmt_ital
exe "hi! pandocEmphasisNestedDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bldi
exe "hi! pandocStrongEmphasisDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_bold
exe "hi! pandocStrongEmphasisNestedDefinition"   .s:fg_pdef.s:bg_none.s:fmt_bldi
exe "hi! pandocStrongEmphasisEmphasisDefinition" .s:fg_pdef.s:bg_none.s:fmt_bldi
exe "hi! pandocStrikeoutDefinition"          .s:fg_pdef  .s:bg_none  .s:fmt_revr
exe "hi! pandocVerbatimInlineDefinition"     .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi! pandocSuperscriptDefinition"        .s:fg_pdef  .s:bg_none  .s:fmt_none
exe "hi! pandocSubscriptDefinition"          .s:fg_pdef  .s:bg_none  .s:fmt_none

" Tables
" ---------------------------------------------------------------------
let s:fg_ptable = s:fg_blue
exe "hi! pandocTable"                        .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi! pandocTableStructure"               .s:fg_ptable.s:bg_none  .s:fmt_none
hi! link pandocTableStructureTop             pandocTableStructre
hi! link pandocTableStructureEnd             pandocTableStructre
exe "hi! pandocTableZebraLight"              .s:fg_ptable.s:bg_back.s:fmt_none
exe "hi! pandocTableZebraDark"               .s:fg_ptable.s:bg_dgray.s:fmt_none
exe "hi! pandocEmphasisTable"                .s:fg_ptable.s:bg_none  .s:fmt_ital
exe "hi! pandocEmphasisNestedTable"          .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi! pandocStrongEmphasisTable"          .s:fg_ptable.s:bg_none  .s:fmt_bold
exe "hi! pandocStrongEmphasisNestedTable"    .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi! pandocStrongEmphasisEmphasisTable"  .s:fg_ptable.s:bg_none  .s:fmt_bldi
exe "hi! pandocStrikeoutTable"               .s:fg_ptable.s:bg_none  .s:fmt_revr
exe "hi! pandocVerbatimInlineTable"          .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi! pandocSuperscriptTable"             .s:fg_ptable.s:bg_none  .s:fmt_none
exe "hi! pandocSubscriptTable"               .s:fg_ptable.s:bg_none  .s:fmt_none

" Headings
" ---------------------------------------------------------------------
let s:fg_phead = s:fg_green
exe "hi! pandocHeading"                      .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi! pandocHeadingMarker"                .s:fg_yellow.s:bg_none.s:fmt_bold
exe "hi! pandocEmphasisHeading"              .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi! pandocEmphasisNestedHeading"        .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi! pandocStrongEmphasisHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi! pandocStrongEmphasisNestedHeading"  .s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi! pandocStrongEmphasisEmphasisHeading".s:fg_phead .s:bg_none.s:fmt_bldi
exe "hi! pandocStrikeoutHeading"             .s:fg_phead .s:bg_none.s:fmt_revr
exe "hi! pandocVerbatimInlineHeading"        .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi! pandocSuperscriptHeading"           .s:fg_phead .s:bg_none.s:fmt_bold
exe "hi! pandocSubscriptHeading"             .s:fg_phead .s:bg_none.s:fmt_bold

" Links
" ---------------------------------------------------------------------
exe "hi! pandocLinkDelim"                .s:fg_mgray .s:bg_none   .s:fmt_none
exe "hi! pandocLinkLabel"                .s:fg_blue   .s:bg_none   .s:fmt_undr
exe "hi! pandocLinkText"                 .s:fg_blue   .s:bg_none   .s:fmt_undb
exe "hi! pandocLinkURL"                  .s:fg_vlgray .s:bg_none   .s:fmt_undr
exe "hi! pandocLinkTitle"                .s:fg_vlgray .s:bg_none   .s:fmt_undi
exe "hi! pandocLinkTitleDelim"           .s:fg_mgray .s:bg_none   .s:fmt_undi   .s:sp_vlgray
exe "hi! pandocLinkDefinition"           .s:fg_cyan   .s:bg_none   .s:fmt_undr   .s:sp_vlgray
exe "hi! pandocLinkDefinitionID"         .s:fg_blue   .s:bg_none   .s:fmt_bold
exe "hi! pandocImageCaption"             .s:fg_violet .s:bg_none   .s:fmt_undb
exe "hi! pandocFootnoteLink"             .s:fg_ygreen  .s:bg_none   .s:fmt_undr
exe "hi! pandocFootnoteDefLink"          .s:fg_ygreen  .s:bg_none   .s:fmt_bold
exe "hi! pandocFootnoteInline"           .s:fg_ygreen  .s:bg_none   .s:fmt_undb
exe "hi! pandocFootnote"                 .s:fg_ygreen  .s:bg_none   .s:fmt_none
exe "hi! pandocCitationDelim"            .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi! pandocCitation"                 .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi! pandocCitationID"               .s:fg_magenta.s:bg_none   .s:fmt_undr
exe "hi! pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none

" Main Styles
" ---------------------------------------------------------------------
exe "hi! pandocStyleDelim"               .s:fg_mgray .s:bg_none  .s:fmt_none
exe "hi! pandocEmphasis"                 .s:fg_mwhite  .s:bg_none  .s:fmt_ital
exe "hi! pandocEmphasisNested"           .s:fg_mwhite  .s:bg_none  .s:fmt_bldi
exe "hi! pandocStrongEmphasis"           .s:fg_mwhite  .s:bg_none  .s:fmt_bold
exe "hi! pandocStrongEmphasisNested"     .s:fg_mwhite  .s:bg_none  .s:fmt_bldi
exe "hi! pandocStrongEmphasisEmphasis"   .s:fg_mwhite  .s:bg_none  .s:fmt_bldi
exe "hi! pandocStrikeout"                .s:fg_mgray .s:bg_none  .s:fmt_revr
exe "hi! pandocVerbatimInline"           .s:fg_yellow .s:bg_none  .s:fmt_none
exe "hi! pandocSuperscript"              .s:fg_violet .s:bg_none  .s:fmt_none
exe "hi! pandocSubscript"                .s:fg_violet .s:bg_none  .s:fmt_none

exe "hi! pandocRule"                     .s:fg_blue   .s:bg_none  .s:fmt_bold
exe "hi! pandocRuleLine"                 .s:fg_blue   .s:bg_none  .s:fmt_bold
exe "hi! pandocEscapePair"               .s:fg_red    .s:bg_none  .s:fmt_bold
exe "hi! pandocCitationRef"              .s:fg_magenta.s:bg_none   .s:fmt_none
exe "hi! pandocNonBreakingSpace"         . s:fg_red   .s:bg_none  .s:fmt_revr
hi! link pandocEscapedCharacter          pandocEscapePair
hi! link pandocLineBreak                 pandocEscapePair

" Embedded Code
" ---------------------------------------------------------------------
exe "hi! pandocMetadataDelim"            .s:fg_mgray .s:bg_none   .s:fmt_none
exe "hi! pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! pandocMetadataKey"              .s:fg_blue   .s:bg_none   .s:fmt_none
exe "hi! pandocMetadata"                 .s:fg_blue   .s:bg_none   .s:fmt_bold
hi! link pandocMetadataTitle             pandocMetadata

"}}}
" Utility autocommand "{{{
" ---------------------------------------------------------------------
" In cases where initialized inside a terminal vim session and 
" then transferred to a gui session via the command `:gui`, the gui vim process 
" does not re-read the colorscheme (or .vimrc for that matter) so any `has_gui` 
" related code that sets gui specific values isn't executed.
"
" Currently sets only the cterm or gui values for the colorscheme 
" depending on gui or terminal mode. It's possible that, if the following 
" autocommand method is deemed excessively poor form, that approach will be 
" used again and the autocommand below will be dropped.
"
" However it seems relatively benign in this case to include the autocommand 
" here. It fires only in cases where vim is transferring from terminal to gui 
" mode (detected with the script scope s:vmode variable). It also allows for 
" other potential terminal customizations that might make gui mode suboptimal.
"
autocmd GUIEnter * if (s:vmode != "gui") | exe "colorscheme " . g:colors_name | endif
"}}}
" Highlight Trailing Space {{{
" Experimental: Different highlight when on cursorline
function! s:hiTrail()
    if g:scheme_hitrail==0
        hi! clear trailingSpace
    else
        syn match trailingSpace "\s*$"
        exe "hi! trailingSpace " .s:fmt_undr .s:fg_red .s:bg_none .s:sp_red
    endif
endfunction  
augroup hiTrail
    autocmd!
    if g:scheme_hitrail==1
        autocmd! Syntax * call s:hiTrail()
        autocmd! ColorScheme * if g:colors_name == "custom" | call s:hiTrail() | else | augroup! s:hiTrail | endif
    endif
augroup END
" }}}



" License "{{{
" ---------------------------------------------------------------------
"
" Copyright (c) 2011 Ethan Schoonover
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" vim:foldmethod=marker:foldlevel=0
"}}}
