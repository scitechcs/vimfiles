"""" Basic Behavior

syntax on
set guicursor=
set number              " show line numbers
set nowrap              " do not wrap lines
set encoding=utf-8      " set encoding to UTF-8 (default was "latin1")
set mouse=a             " enable mouse support (might not work well on Mac OS X)
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell          " blink cursor on error, instead of beeping
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set rnu
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir " Saves undo steps to a file so you can redo even after exiting Vim
set undofile
set nocompatible           " No need to be compatible with Vi which would come at the expense of some functionality
set gdefault               " applies find and replace subsitition globally by default. To only replace first occurrence use /g

call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'habamax/vim-asciidoctor'
Plug 'haya14busa/incsearch.vim'
call plug#end()

"""" Key Bindings

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk
;
" map shortcut for NERDTree
:map <C-n> : NERDTree


"""" Vim Appearance

" put colorscheme files in ~/.vim/colors/

" use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on

set guifont=Fira_Mono:h11:cANSI:qDRAFT

if has('gui_running')
  set guioptions-=T  " no toolbar
  colorscheme molokai

endif

let g:gruvbox_contrast_dark = 'hard'

highlight CursorLineNr gui=bold guifg=DarkRed guibg=#c0d0e0

"""" Tab settings

set tabstop=4           " width that a <TAB> character displays as
set expandtab           " convert <TAB> key-presses to spaces
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set softtabstop=4       " backspace after pressing <TAB> will remove up to this many spaces

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')

"""" Search settings

set incsearch           " search as characters are entered, which is incremental search
set hlsearch            " highlight matches

" turn off search highlighting with <CR> (carriage-return)
nnoremap <CR> :nohlsearch<CR><CR>

" map Esc key alternative to jk and kj
inoremap jk <ESC>
inoremap kj <ESC>


"""" Miscellaneous settings that might be worth enabling

set cursorline         " highlight current line
"set background=dark    " configure Vim to use brighter colors
"set autoread           " autoreload the file in Vim if it has been changed outside of Vim

" pretty print
command! PrettyPrintHTML !tidy -mi -html -wrap 0 %
command! PrettyPrintXML !tidy -mi -xml -wrap 0 %

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" clear search highlights by typing ,<space>
nnoremap <leader><space> :noh<cr>

" use tab to move around to bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" use semicolon to enter commandline instead of shift-; (:)
nnoremap ; :


set foldmethod=expr
set foldnestmax=4

set filetype=on

set statusline=%t%=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ %h%m%r%y\ %c\ %l/%L\ %P

let mapleader = ","

" strip all trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" open _vimrc file with ,ev (leader edit vim)
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

"setting this value forces wrapping even if nowrap is set
"set textwidth=100

"" habamax/asciidoctor plugin settings

" Fold sections, default `0`.
let g:asciidoctor_folding = 1

" Fold options, default `0`.
let g:asciidoctor_fold_options = 1

" What to use for HTML, default `asciidoctor`.
let g:asciidoctor_executable = 'asciidoctor'

" What extensions to use for HTML, default `[]`.
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']

" Path to the custom css
let g:asciidoctor_css_path = '~/docs/AsciiDocThemes'

" Custom css name to use instead of built-in
let g:asciidoctor_css = 'haba-asciidoctor.css'

" Conceal *bold*, _italic_, `code` and urls in lists and paragraphs, default `0`.
" See limitations in end of the README
let g:asciidoctor_syntax_conceal = 0

" Highlight indented text, default `1`.
let g:asciidoctor_syntax_indented = 0

" Function to create buffer local mappings and add default compiler
fun! AsciidoctorMappings()
    nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
    nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
    nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
    nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
    nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
    nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
    nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
    nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
    " :make will build pdfs
    compiler asciidoctor2pdf
endfun

" Call AsciidoctorMappings for all `*.adoc` and `*.asciidoc` files
augroup asciidoctor
    au!
    au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END

winpos 800 0
winsize 150 50

" Used with incsearch plugin to hide highlights after moving the cursor following a search
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
