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
set columns=105
set grepprg=ack-grep\ --smart-case\ --ignore-dir=venv\ --type-add=json=.json

if has('gui_macvim')
    set guifont=DejaVu\ Sans\ Mono:h14.00
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

