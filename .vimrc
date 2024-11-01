""""""""
" CORE "
""""""""

" Set default shell
set shell=/bin/zsh
" No need to run compatible for vi
set nocompatible
" Set default encoding to utf-8
set encoding=utf-8
" Enable filetype specific plugins and indentation
filetype on
filetype plugin on
filetype plugin indent on
" Enable syntax highlighting
syntax on
" Enable cindent
set cindent
" Enable smart indent
set smartindent
" Disable backup files
set nobackup
" Disable swap files
set noswapfile
" Enable highlight for searched terms
set hlsearch
" Highlight incrementably the searched terms
set incsearch
" Highlight current line
" set cursorline
" Make vim go faster (less redraw)
set lazyredraw
" Highlith matching pairs
set showmatch
" Shows what select are in visual mode
set showcmd
" Set "g" as default flag for regex replace
set gdefault
" Display line, column, and percentage of file for the current cursor position
set ruler
" Display line number
set number
" Enable the mouse
set mouse=a
" Scroll 7 lines when off-screen (top-bottom)
set scrolloff=7
" Scroll 7 chars when off-screen (left-right)
set sidescrolloff=7
" Set leader as ,
let mapleader = "\,"
" Enable custom title
set title
" Enable last status
set laststatus=2
" Display ascii value of current character
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
" Ident for four spaces when shifting
set shiftwidth=2
" Use four spaces for one tab
set softtabstop=2
" Expand tabs to spaces
set expandtab
" Automatically indent when moving to the next line
set autoindent
" Enable completion for commands
set wildmenu
" First tab is for list, second for looping through matches
set wildmode=list:longest,full
" Fold on indentation
set foldmethod=indent
" Fold all
set foldlevel=99
" Set term colors as gui colors
set termguicolors
" Set default font
set guifont=Monaco\ Nerd\ Font:h10
" Set chars to display in place of special chars
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" Terminal acceleration
set ttyfast
" Make backspace work again
set backspace=indent,eol,start
" Use the system clipboard
set clipboard=unnamed
" Use the newest regex engine
set re=0

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endi

" Highlight extra-spaces
highlight ExtraWhitespace ctermbg=4 guibg=#cf6a4c
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/
match ExtraWhitespace /^\t*\zs \+/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=4 guibg=#cf6a4c

""""""""""""
" COMMANDS "
""""""""""""

" Simpler save command for files not opened as root
command SW :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Simpler set paste command
command SP :execute ':silent set paste'
" Simpler set nopaste command
command SNP :execute ':silent set nopaste'
function! DummyReplace(needle, substitute)
    execute ':%s/\(.\+ .\+\) ' . a:needle . ' \(.\+\)/\1 ' . a:substitute .' \2/'
endfunction
command -nargs=* REPLACE :call DummyReplace(<f-args>)
" Sort lines by length
command -range=% SORTL :<line1>,<line2>!awk '{ print length(), $0 | "sort -n | cut -d\\  -f2-" }'
" Create occurences of uniq lines
command -range=% CUNIQ :<line1>,<line2>!awk '{ print $0 }' | sort | uniq -c | sort -nr
" Count the number of matches
command COUNT :%s///n

""""""""
" MAPS "
""""""""

" Map the numpad
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Op 0
map! <Esc>On .
map! <Esc>OQ /
map! <Esc>OR *
map! <kPlus> +
map! <Esc>OS -
map! <Esc>OX =
" Map C-arrow to move in buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Disabling ex mode
map Q <Nop>
" Avoid the stupid window to pop
map q: :q
" Map leader{w,x,q} to respective commands
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
" Map \ to clean highlighed terms
nnoremap <silent> <Bslash> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Deactivate arrows
" no <down> <Nop>
" no <left> <Nop>
" no <right> <Nop>
" no <up> <Nop>
" ino <down> <Nop>
" ino <left> <Nop>
" ino <right> <Nop>
" ino <up> <Nop>
" vno <down> <Nop>
" vno <left> <Nop>
" vno <right> <Nop>
" vno <up> <Nop>

""""""""""""
" NERDTREE "
""""""""""""

" Set colors for nerdtree
let NERDChristmasTree = 1
" Highlight current nerdtree line
let NERDTreeHighlightCursorline = 1
" Ignore git, osx, jetbrains, python files
let NERDTreeIgnore=['\.git','\.DS_Store','\.idea', '\.pyc$', '\.pyo$', '__pycache__$']
" Map control-N to open Nerdtree
nnoremap <C-N> :NERDTreeToggle<CR>
" Automatically close NERDTree if its the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"""""""""""""""""
" MULTI-CURSORS "
"""""""""""""""""

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<C-X>'
let g:multi_cursor_next_key='<C-X>'
let g:multi_cursor_prev_key='<C-D>'
let g:multi_cursor_skip_key='<C-F>'
let g:multi_cursor_quit_key='<Esc>'

setlocal foldmethod=syntax

"""""""
" ALE "
"""""""

let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_statusline_format = ['⨉%d', '⚠ %d', '⬥ ok']
let g:ale_linters = { 'vue': ['eslint'], 'javascript':  ['eslint'], 'typescriptreact': ['eslint'], 'typescript': ['tsc', 'eslint'], 'ruby': ['rubocop'] }
let g:ale_fixers = { 'vue':  ['eslint', 'prettier'], 'javascript':  ['eslint', 'prettier'], 'typescript': ['eslint'], 'ruby': ['rubocop'] }
" Auto close quickfix buffer when it's the last open buffer
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

""""""""""""
" POLYGLOT "
""""""""""""
let g:polyglot_disabled = ['markdown', 'csv']

autocmd BufRead,BufNewFile *.pyx set filetype=pyrex
autocmd BufRead,BufNewFile *.twig set filetype=html
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

""""""""""""""""
" AUTOCOMPLETE "
""""""""""""""""

autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType elixir set omnifunc=elixircomplete#Complete
autocmd FileType python set omnifunc=complete#CompletePython
autocmd FileType pyrex set omnifunc=complete#CompletePython
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=complete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

"""""""""""""""""""
" TAB AND SPACING "
"""""""""""""""""""

au FileType c setl shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType php setl shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType python setl shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType pyrex setl shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType ruby setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType elixir setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType yaml setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType javascript setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType eruby setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType html setl shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType css setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType markdown setl shiftwidth=2 softtabstop=2 tabstop=2 expandtab

"""""""""""
" PLUGINS "
"""""""""""
call plug#begin('~/.vim/plugged')

" Autocomplete quotes, parenthesis,brackets...
Plug 'raimondi/delimitmate'
" Easily replace quotes, parenthesis,brackets...
Plug 'tpope/vim-surround'
" Enable multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Left-hand side tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Visual Indentation
Plug 'thaerkh/vim-indentguides'
" Autocomplete using tab
Plug 'ervandew/supertab'
" Gc for commenting
Plug 'tpope/vim-commentary'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Linting
Plug 'dense-analysis/ale'

" Pretty icons for NERDTree
Plug 'ryanoasis/vim-devicons'
" Jellybeans colorscheme
Plug 'nanotech/jellybeans.vim'

" Autocomplete end for ruby
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

call plug#end()

""""""""""
" COLORS "
""""""""""

" Configure the color theme
colorscheme jellybeans
