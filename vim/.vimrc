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
" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
map <F12> :NERDTreeToggle<CR>
imap <F12> <ESC>:NERDTreeToggle<CR>
let g:NERDTreeWinSize = 22

" Python mode (indentation, doc, refactor, lints, code checking, 
" motion and operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'

" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
"Bundle 'vim-scripts/JavaScript-Indent'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'groenewege/vim-less'

Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'
nmap <leader>g :Ggrep
" ,f for global git serach for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent
            \ Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
:vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent
            \ Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>
" key mapping for error navigation
nmap <leader>[ :cprev<CR>
nmap <leader>] :cnext<CR>

" syntax checker for many languages
Bundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1

Bundle 'Raimondi/delimitMate'
Bundle 'marijnh/tern_for_vim'

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
set columns=110
set iskeyword+=-
set autochdir


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

""inoremap ' ''<Left>
""inoremap " ""<Left>
""inoremap ( ()<Left>
""inoremap [ []<Left>
""inoremap { {}<Left>

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

