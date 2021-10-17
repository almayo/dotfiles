"----------------------------------------------------------
" dein Scripts
"   require v:version >= 800
"----------------------------------------------------------
if v:version >= 800
    if &compatible
        set nocompatible               " Be iMproved
    endif
    
    " install dir
    let s:dein_dir = expand('~/.cache/dein')
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    
    " dein installation check
    if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
        endif
        execute 'set runtimepath^=' . s:dein_repo_dir
    endif
    
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)
        call dein#add(s:dein_repo_dir)
        call dein#add('Shougo/unite.vim')
        call dein#add('scrooloose/syntastic')
        call dein#add('mitsuhiko/vim-jinja')
        call dein#end()
        call dein#save_state()
    endif
    
    filetype plugin indent on
    syntax enable
    
    " plugin installation check
    if dein#check_install()
        call dein#install()
    endif
endif

"----------------------------------------------------------
" syntastic
"----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = '--ignore="E501"'

"----------------------------------------------------------
" flake8
"----------------------------------------------------------
let g:syntastic_python_checkers = ["flake8"]
let g:flake8_ignore = 'E501'


"encoding-----------------------------
set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

"format-----------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

"fold------------------------------
set foldmethod=marker

if has("autocmd")
    augroup fileTypeIndent
        autocmd!
        autocmd BufNewFile,BufRead *.py   setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufNewFile,BufRead *.sh   setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufNewFile,BufRead *.yml  setlocal tabstop=2 softtabstop=2 shiftwidth=2
        autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
    augroup fileTypeFolding
        autocmd!
        autocmd FileType *.py setlocal foldmethod=indent
        autocmd FileType *.sh setlocal foldmethod=marker
        autocmd FileType *.yml setlocal foldmethod=indent
        autocmd FileType *.yaml setlocal foldmethod=indent
endif

"search-----------------------------
set incsearch
set ignorecase
set smartcase
set hlsearch
set noshowmatch

"other-----------------------------
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,],~
set number
set noswapfile

"keymap-----------------------------
inoremap <silent> <C-e> <Esc>
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>

nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Right> <Nop>
nnoremap <Left> <Nop>

nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

nmap <Space> <C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
