"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-------------------------------------------------
" => Basic VIM settings
"-------------------------------------------------
filetype plugin indent on
let mapleader=','
let maplocalleader='\'
set timeoutlen=500
" auto source vimrc after save
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC 
augroup END " }

set autoread " Set autoread when a file is changed outside
set autowrite " Write on make/shell commands
set hidden " Turn on hidden"
set history=2000 " Increase the lines of history
set clipboard+=unnamedplus " Yanks go on clipboard instead
set modeline " Turn on modeline
if !has('nvim')
    set encoding=utf-8 " Set utf-8 encoding
endif
set completeopt+=longest " Optimize auto complete
set completeopt-=preview " Optimize auto complete
set mousehide " Hide mouse after chars typed
set mouse=a " Mouse in all modes
set backup " Set backup
set undofile " Set undo
set noswapfile
" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Set directories
function! InitializeDirectories()
    let parent=$HOME
    let prefix='.vim'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'undo': 'undodir'}
    "\ 'swap': 'directory',
    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                call mkdir(directory)
                exec 'set '.settingname.'='.directory
            else
                echo "Warning: Unable to create directory: ".directory
                echo "Try: mkdir -p ".directory
            endif
        else
            exec 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

autocmd BufWinLeave *.* silent! mkview " Make Vim save view (state) (folds, cursor, etc)
autocmd BufWinEnter *.* silent! loadview " Make Vim load view (state) (folds, cursor, etc)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Configuration
"-------------------------------------------------

" On Windows, also use '.vim' instead of 'vimfiles'
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

function! IsMac() 
    if has('unix')
        let s:uname = system('uname -s')
        return s:uname == 'Darwin'
    endif
    return 0
endfunction

if !IsMac()
    vnoremap <M-c> "+y
    vmap <M-v> c<ESC>"+p
    imap <M-v> <C-r><C-o>+
endif

set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change
set fileformats=unix,mac,dos " Auto detect the file formats


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/pluggen')

"--------------------------------------------------
" => Plugs
"--------------------------------------------------

" ui
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
    Plug 'kassio/neoterm'
endif

" colour scheme
Plug 'w0ng/vim-hybrid' 
Plug 'nathanaelkane/vim-indent-guides'
Plug 'fholgado/minibufexpl.vim'
Plug 'mhinz/vim-startify'

" Navigation
" Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-unimpaired'
if executable('ctags')
    Plug 'majutsushi/tagbar'
endif

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin '}
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}

if executable('ag')
    Plug 'rking/ag.vim'
elseif executable('ack-grep') || executable('ack')
    Plug 'mileszs/ack.vim'
endif
if executable('git')
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

" Short Cuts 
Plug 'scrooloose/nerdcommenter'
Plug 'AndrewRadev/splitjoin.vim'

" Automatic Helper
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'carlitux/deoplete-ternjs', {'on_ft': 'javascript'}
else
    Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer --clang-completer'}
endif
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate' " auto close quotes, parenthesise, brackets, etc.
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips' " snip
Plug 'honza/vim-snippets'

" syntax error check
if has('nvim')
    Plug 'neomake/neomake'
else
    Plug 'scrooloose/syntastic'
endif

" Language related
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
"Plug 'vim-scripts/sql.vim--Stinson'
"Plug 'django.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'vim-scripts/indenthtml.vim'

"Plug 'leafgarland/typescript-vim'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'othree/javascript-libraries-syntax.vim'
"Plug 'othree/yajs.vim'

" html
Plug 'mattn/emmet-vim'

" change root dir by find git
Plug 'airblade/vim-rooter'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" spell check
set spell
" Ignore CamelCase and camelCase words when spell checking
fun! IgnoreCamelCaseSpell()
  syn match CamelCase1 /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn match CamelCase2 /\<[a-z]\+[A-Z0-9].\{-}\>/ contains=@NoSpell transparent
  syn match ShortWord /\<[a-z]\{1,3}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase1
  syn cluster Spell add=CamelCase2
  syn cluster Spell add=ShortWord
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()


"-------------------------------------------------
" => Vim User Interface
"-------------------------------------------------

" Set title
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" Set status line
set laststatus=2 " Show the statusline
set noshowmode " Hide the default mode text
" Set the style of the status line
" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
auto InsertEnter * set nocursorline
auto InsertLeave * set cursorline


set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids 'hit enter'
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor
if has('gui_running')
    set columns=88
endif

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink

set relativenumber
set number

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
set textwidth=80 " Change text width
set colorcolumn=+1 " Indicate text border
set list " Show these tabs and spaces and so on
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " Change listchars
set linebreak " Wrap long lines at a blank
set showbreak=↪  " Change wrap line break
set fillchars=diff:⣿,vert:│ " Change fillchars
" Only show trailing whitespace when not in insert mode
augroup trailing
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:⌴
    autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" Set gVim UI setting
if has('gui_running')
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=m
    set guioptions-=T
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------

syntax on " Enable syntax
set background=dark " Set background
if !has('gui_running') || $COLORTERM == 'gnome-terminal'
    set t_Co=256 " Use 256 colors
endif
colorscheme hybrid " Load a colorscheme

if has('gui_running')
    if has('gui_gtk')
        set guifont=DejaVu\ Sans\ Mono\ 11
    elseif has('gui_macvim')
        set guifont=Monaco:h11
    elseif has('gui_win32')
        set guifont=Consolas:h11:cANSI
    endif
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Indent and Tab Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set softtabstop=4 " Indentation levels every four columns
set shiftwidth=4 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

" Indent setting for html
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "body,head,li"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V'.substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(" ",fillcharcount).foldedlinecount.'…'.' '
endfunction
set foldtext=MyFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Filetype Specific
"-------------------------------------------------

" QuickFix
augroup ft_quickfix
    autocmd!
    autocmd Filetype qf setlocal colorcolumn=0 
                \nolist nocursorline nowrap textwidth=0
augroup END

" Markdown
augroup ft_markdown
    autocmd!
    " Use <localLeader>1/2/3/4/5/6 to add headings
    autocmd Filetype markdown nnoremap <buffer> <localLeader>1 I# <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>2 I## <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>3 I### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>4 I#### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>5 I##### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>6 I###### <ESC>
    " Use <LocalLeader>b to add blockquotes in normal and visual mode
    autocmd Filetype markdown nnoremap <buffer> <localLeader>b I> <ESC>
    autocmd Filetype markdown vnoremap <buffer> <localLeader>b :s/^/> /<CR>
    " Use <localLeader>ul and <localLeader>ol to add list symbols in visual mode
    autocmd Filetype markdown vnoremap <buffer> <localLeader>ul :s/^/* /<CR>
    autocmd Filetype markdown vnoremap <buffer> 
                \<LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
    " Use <localLeader>e1/2/3 to add emphasis symbols
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e1 I*<ESC>A*<ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e2 I**<ESC>A**<ESC>
    autocmd Filetype markdown nnoremap <buffer> 
                \<localLeader>e3 I***<ESC>A***<ESC>
    " Use <Leader>P to preview markdown file in browser
    autocmd Filetype markdown nnoremap <buffer> <Leader>P :MarkdownPreview<CR>
augroup END

" LESS
augroup ft_less
    autocmd!
    autocmd filetype less nnoremap <buffer> <Leader>r :w <BAR> !lessc % > %:t:r.css<CR><Space>
augroup END

" JSON
augroup ft_json
    autocmd!
    " Disable concealing of double quotes
    autocmd filetype json setlocal conceallevel=0
    " " Added folding of {...} and [...] blocks
    " autocmd filetype json setlocal foldmethod=syntax
    autocmd Filetype json setlocal shiftwidth=2 softtabstop=2
augroup END

" javascript
augroup ft_javascript
    autocmd!
    autocmd Filetype javascript setlocal shiftwidth=2 softtabstop=2
    autocmd Filetype javascript let g:indent_guides_guide_size=2
augroup END

augroup ft_scss
    autocmd!
    autocmd Filetype scss setlocal shiftwidth=2 softtabstop=2
    autocmd Filetype scss let g:indent_guides_guide_size=2
augroup END

" html
augroup ft_html
    autocmd!
    autocmd Filetype html setlocal shiftwidth=2 softtabstop=2
    autocmd Filetype html let g:indent_guides_guide_size=2
augroup END

" Perl
augroup ft_perl
    let perl_include_pod=1
    let perl_extended_vars=1
    let perl_sync_dist=250
    autocmd!
    autocmd filetype perl setlocal keywordprg=perldoc\ -f
augroup END

" PHP
augroup ft_php
    if filereadable(expand("$HOME/.vim/dict/php_funclist.txt"))
        function! AddPHPFuncList()  " Inspired by hawk (https://github.com/hawklim)
            set dictionary-=$HOME/.vim/dict/php_funclist.txt dictionary+=$HOME/.vim/dict/php_funclist.txt
            set complete-=k complete+=k
        endfunction
        autocmd!
        autocmd filetype php call AddPHPFuncList()
    endif

    autocmd Filetype php setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

nnoremap <Leader>1 :b1<CR>
nnoremap <Leader>2 :b2<CR>
nnoremap <Leader>3 :b3<CR>
nnoremap <Leader>4 :b4<CR>
nnoremap <Leader>5 :b5<CR>
nnoremap <Leader>6 :b6<CR>
nnoremap <Leader>7 :b7<CR>
nnoremap <Leader>8 :b8<CR>
nnoremap <Leader>9 :b9<CR>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Local Setting
"--------------------------------------------------

" Use local vimrc if available
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("$HOME/.gvimrc.local"))
        source $HOME/.gvimrc.local
    endif
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => vim-airline
"-------------------------------------------------
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 100,
      \ 'gutter': 100,
      \ 'x': 100,
      \ 'y': 100,
      \ }
let g:airline_skip_empty_sections = 1
let g:airline#extensions#whitespace#enabled = 0

"--------------------------------------------------
" => Tagbar
"--------------------------------------------------
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => NERD_tree
"--------------------------------------------------
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeIgnore = ['\.pyc$']
" autocmd VimEnter *  NERDTree " auto open NERDTree
" autocmd VimEnter *  wincmd p " after NERDTree opened, go back previous window

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => nerdtree-git-plugin
"--------------------------------------------------
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => NERD_commenter
"--------------------------------------------------

let NERDCommentWholeLinesInVMode=2
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => UltiSnips
"--------------------------------------------------
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-L>"
let g:UltiSnipsJumpBackwardTrigger="<C-H>"
let g:UltiSnipsEditSplit='context'

" SuperTab like snippets behavior
imap <expr><Tab> pumvisible() ? '<C-N>' : '<Tab>'
imap <expr><S-Tab> pumvisible() ? '<C-P>' : '<S-Tab>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => delimitMate
"--------------------------------------------------
let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => Ag(Ack)
"--------------------------------------------------
if executable('ag')
    nnoremap <Leader>a :Ag<Space>
    nnoremap <Leader>aa :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
elseif executable('ack-grep') || executable('ack')
    nnoremap <Leader>a :Ack!<Space>
endif
if !executable('ag') && has('unix') && executable('ack-grep')
    let g:ackprg='ack-grep -H --nocolor --nogroup --column'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => Syntastic
"--------------------------------------------------
" nnoremap <Leader>s :Errors<CR>
" " set statusline=%#warningmsg#
" " set statusline+=%{SyntasticStatuslineFlag()}
" " set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_auto_jump = 1

" " let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" " let g:syntastic_enable_highlighting = 0
" let g:syntastic_javascript_checkers = ['eslint']
" " let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
" let g:syntastic_less_checkers = [''] 
" " brew install tidy-html5
" let g:syntastic_html_tidy_exec = 'tidy'
" let g:syntastic_html_tidy_quiet_messages={
            " \ 'regex': [
            " \   'discarding unexpected <.*-',
            " \   '> is not recognized',
            " \   'trimming empty <',
            " \   'attribute name']
            " \}
" "let g:syntastic_html_tidy_ignore_errors=[]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => neomake/neomake
"--------------------------------------------------
let g:neomake_list_height = 2
let g:neomake_open_list = 2
let g:neomake_verbose = 3
let g:neomake_javascript_eslint_maker = {
    \ 'exe': 'eslint_d',
    \ }
"    \ 'args': ['--verbose'],
"    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',

let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => javascript-libraries-syntax.vim
"--------------------------------------------------
let g:used_javascript_libs = 'jquery,underscore,angularjs,react,jasmine'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *.js let b:javascript_lib_use_react = 1
autocmd BufReadPre *.js let b:javascript_lib_use_jasmine = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => mxw/vim-jsx
"--------------------------------------------------
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => fugitive
"--------------------------------------------------
if executable('git')
    nnoremap <silent> <leader>gs :Gstatus<CR>:resize 30<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit -a<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => Splitjoin
"--------------------------------------------------
let g:splitjoin_split_mapping = ',k'
let g:splitjoin_join_mapping = ',j'
let g:splitjoin_normalize_whitespace=1
let g:splitjoin_align=1

"--------------------------------------------------
" => Shougo/deoplete
"--------------------------------------------------
let g:deoplete#enable_at_startup = 1

function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

"--------------------------------------------------
" => junegunn/fzf
"--------------------------------------------------

let g:fzf_layout={'down': '~40%'}
let g:fzf_history_dir='~/.fzf-history'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>
nmap <Leader>c :Commits<cr>

"--------------------------------------------------
" => Indent Guides
"--------------------------------------------------
if !has('gui_running')
    let g:indent_guides_auto_colors=0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=237
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
endif

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => startify
"--------------------------------------------------
let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
" => terminal
"--------------------------------------------------

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif



