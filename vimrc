" ########################################################################
" " http://mbrix.dk/files/linux_files/dot.vimrc
" " jdub's config - http://perkypants.org/dotfiles/vimrc.html
" " http://www.stripey.com/vim/vimrc.html
" "
set nocompatible    " vim defaults are much nicer, not compatible with vi
set bg=dark             " use dark background
colorscheme solarized     " default colorscheme
set ffs=unix,dos,mac    " support all three, in this order

set backup                      " make backup file
set backupdir=$HOME/.vim_backup " where to put backup file
set directory=$HOME/.vim_temp   " directory is the directory for temp file

set textwidth=80    " max length of line for inserting text
set whichwrap=b,s,<,>,[,]
set lbr             " wordwrap visually
set formatoptions=l " do not insert hard newlines in paragraphs
"set bs=2            " allow backspacing over everything in insert mode
set ignorecase      " ignore case in search patterns
set smartcase
set scrolloff=4     " how many lines of context on top and bottom
set nohlsearch      " highlight search text in document

set ruler           " Show cursor position
set showmode        " show mode at bottom of screen
set showmatch       " show matching brackets


" pastetoggle - this toggles 'paste' so one can paste text into the terminal
"               without vim messing the text indenting up.
set pastetoggle=<f2>


" ########################################################################
" " Tabs Settings
" "
set expandtab       " insert spaces when hitting <tab>
set autoindent      " always autoindent on
set smartindent     " smartindent! :)
" change all the existing tab characters to match the current tab settings
"retab

" shiftwidth:  Number of spaces to use for each insertion of (auto)indent.
set shiftwidth=4

set tabstop=4       " the width of a tab

" When off, a <Tab> always inserts blanks according to 'tabstop'.
set smarttab

" lazyredraw:  do not update screen while executing macros
set lazyredraw


" ########################################################################
" " Keybindings
" "
" map F1 to Esc, which is cool on my text terminal and sparc
" From Dan York's vimrc, he has a simlar annoyance with his notebook
" imap <f1> <ESC>

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>


" ########################################################################
" " Filetype Specific Stuff
" "
filetype on         " detect the type of file
filetype plugin on  " load filetype plugins

" "
" " Syntax
" "
syntax on
let apache_version = "2.0"
au BufNewFile,BufRead   *.mutt*         so $VIMRUNTIME/syntax/muttrc.vim
au BufNewFile,BufRead   *.mutt\/*       set ft=muttrc
au BufNewFile,BufRead   *mailcap        set ft=mailcap
au BufNewFile,BufRead   *.procmailrc*   so $VIMRUNTIME/syntax/procmail.vim
au BufNewFile,BufRead   *.txt           set ft=human
au BufNewFile,BufRead   *.bash*         set noet ft=bash
au BufNewFile,BufRead   *.ssh\/*        set nu

" ########################################################################
" " Mail - mutt is awesome baby!!
" "
au FileType mail :nmap <F8> :w<CR>:!aspell -e -c %<CR>:e<CR>

" spellcheck for mail that excludes any in news/mail headers
" or in ("> ") quoted text:
"au FileType mail :nmap <F8> :w ! grep -v '^>' <Bar> grep -E -v '^[[:alpha:]-]+: ' ' . '<Bar> aspell -e -c %<CR>:e<CR>
au FileType mail set tw=76 nosi noai   " turn off indenting and set width


" ########################################################################
" " Abbreviations
" "
ab teh the
ab adn and
ab taht that
ab htis this
ab wehn when
ab wtih with
ab konw know
ab scnet scent
ab sduo sudo

iab YDATE <C-R>=strftime("%Y-%m-%d %X %Z")<CR>
iab HDATE <C-R>=strftime("%Y-%m-%d %X %z")<CR>
iab DEBDATE <C-R>=strftime("%a, %d %b %Y %X %z")<CR>


" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
" FROM http://www.stripey.com/vim/vimrc.html
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

highlight Normal guibg=black guifg=white gui=NONE cterm=NONE term=NONE

highlight Statement gui=NONE cterm=NONE term=NONE
highlight Special gui=NONE cterm=NONE term=NONE
highlight Type gui=NONE cterm=NONE term=NONE
highlight Comment ctermfg=DarkBlue gui=NONE cterm=NONE term=NONE
highlight Constant gui=NONE cterm=NONE term=NONE
highlight Identifier gui=NONE cterm=NONE term=NONE

highlight StatusLine guibg=white guifg=black gui=NONE cterm=NONE term=NONE
highlight StatusLineNC guibg=grey guifg=black gui=NONE cterm=NONE term=NONE
highlight ModeMsg guibg=black guifg=white gui=NONE cterm=NONE term=NONE
highlight Search guibg=grey guifg=black gui=NONE cterm=NONE term=NONE

" Help me make those Gnome *.desktop files
au BufEnter * if &filetype == "desktop" | call Desktop() |endif
function! Desktop(...)
    set nosi
    imap ,desktop [Desktop Entry]<RETURN>Version=1.0<RETURN>Encoding=UTF-8<RETURN>Comment=<RETURN>Name=<RETURN>Exec=<RETURN>Terminal=false<RETURN>Categories=<RETURN>Type=Application<RETURN>Icon=<RETURN>MimeType=<RETURN>NoDisplay=false<RETURN>

endfunction

" These maps only work if we're editing an HTMLish file
autocmd BufEnter * if &filetype == "html" || &filetype == "php" || &filetype == "xml" || &filetype == "wml" | call HTML_Maps() | endif
function! HTML_Maps(...)
    " Settings
    "set nosmartindent
    set noexpandtab     " saves a few bytes by adding real tabs
    set nocindent
    set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://,:#
    set formatoptions=croql
    
    " Doctypes
    imap ,html <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><RETURN><html><RETURN><RETURN><head><RETURN><TAB><title></title><RETURN><BACKSPACE></head><RETURN><RETURN><body><RETURN><RETURN><RETURN><RETURN></body><RETURN><RETURN></html>
    imap ,xhtml <?xml version="1.0"?><RETURN><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><RETURN><html><RETURN><RETURN><head><RETURN><TAB><title></title><RETURN><BACKSPACE></head><RETURN><RETURN><body><RETURN><RETURN><RETURN><RETURN></body><RETURN><RETURN></html>
    imap ,p <p>
    imap ,/p </p>
    " Tags
    "imap <p> <p></p><C-O>3h
    "imap <i> <i></i><C-O>3h
    "imap <b> <b></b><C-O>3h
    "imap <u> <u></u><C-O>3h
    "imap <block> <blockquote></blockquote><C-O>12h

    " Entities
    inoremap \& &amp;
    inoremap \< &lt;
    inoremap \> &gt;
    inoremap \. &middot;
endfunction

