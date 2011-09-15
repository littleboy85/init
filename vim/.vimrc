set nocompatible

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
set nobackup
set ignorecase
set smartcase
set columns=84

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if has('mouse')
    set mouse=a
endif

map <F12> :NERDTreeToggle<CR>
imap <F12> <ESC>:NERDTreeToggle<CR>
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

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
