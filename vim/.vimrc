" no vi-compatible
set nocompatible

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vim bundle management
Bundle 'gmarik/vundle'
" file browser
Bundle 'scrooloose/nerdtree'
" Python mode (indentation, doc, refactor, lints, code checking, 
" motion and operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Terminal Vim with 256 colors colorscheme
Bundle 'fisadev/fisa-vim-colorscheme'
Bundle "pangloss/vim-javascript"
Bundle 'groenewege/vim-less'

filetype plugin indent on

colo evening
set number
set ruler
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set history=255
set showcmd
set showmatch
set incsearch
set autoindent
set fileformat=unix
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,default,latin1
set nobackup
set ignorecase
set smartcase
set columns=106
set grepprg=ack-grep\ --smart-case\ --ignore-dir=venv\ --type-add=json=.json
set iskeyword+=-
set autochdir

let NERDTreeIgnore = ['\.pyc$']
map <F12> :NERDTreeToggle<CR>
imap <F12> <ESC>:NERDTreeToggle<CR>
let g:NERDTreeWinSize = 22


" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

if has('gui_macvim')
    if hostname() == 'Xiaohans-iMac.local'
        set guifont=Andale\ Mono:h14,\ Consolas:h14
    else
        set guifont=DejaVu\ Sans\ Mono:h14.00,\ Consolas:h14
    endif
else
    "set guifont=Consolas:h9:cANSI
    set clipboard=unnamedplus
endif

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if has('mouse')
    set mouse=a
endif

" this require install xclip
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
imap <C-v> <ESC>:call setreg("\"", system("xclip -o -selection clipboard"))<CR>p

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" ACK {{
vnoremap <F5> "+y:lgrep --ignore-dir=venv <C-R>+ <CR> :lw<CR>
nnoremap <F5> :execute "lgrep ".expand("<cword>") <CR> :lw<CR>
inoremap <F5> :execute "lgrep ".expand("<cword>") <CR> :lw<CR>
" }}

au BufRead,BufNewFile *.py set ft=python.django " For SnipMate
au BufRead,BufNewFile *.html set ft=htmldjango.html " For SnipMate             

if has('autocmd')
    filetype plugin indent on
    augroup vimrcEx
        au!
        " When editing a file, always jump to the last known cursor position
        autocmd BufReadPost * 
                    \ if line("'\"") > 1 && line("'\"") <= line("$") | 
                    \   exe "normal! g`\"" | 
                    \ endif
    augroup END
endif

