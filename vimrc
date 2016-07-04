" vim:fdm=marker
" Install Plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")

Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'    }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme solarized

"--------------------------------------------------------------------------------
" important
"--------------------------------------------------------------------------------
set nocompatible

"--------------------------------------------------------------------------------
" moving around, searching and patterns
"--------------------------------------------------------------------------------
set autochdir  " Change working directory to opened file's one
set incsearch  " highlight matches when typing
set ignorecase " case-insensitive searching
set smartcase  " if there are uppercase chars in search pattern, make search case sensitive

"--------------------------------------------------------------------------------
" displaying text
"--------------------------------------------------------------------------------
set scrolloff=5 " Scroll offset
set wrap        " wrap lines
set linebreak   " Respect words when wrapping
set breakindent " Indent wrapped text
set showbreak=>
set list
set listchars=tab:⇢\ ,trail:·
set number      " Show line numbers

"--------------------------------------------------------------------------------
" syntax, highlighting and spelling
"--------------------------------------------------------------------------------
set background=dark
filetype plugin indent on " Filetype detection
syntax on
set hlsearch              " highlight all matches
set colorcolumn=120       " Highlight n-th column

"--------------------------------------------------------------------------------
" multiple windows
"--------------------------------------------------------------------------------
set laststatus=2 " Always show statusline
set hidden       " Hide buffer (instead of closing)
set splitbelow
set splitright

"--------------------------------------------------------------------------------
" terminal
"--------------------------------------------------------------------------------
set ttyfast " Improves drawing performance

"--------------------------------------------------------------------------------
" using the mouse
"--------------------------------------------------------------------------------
set mouse=a " Enable mouse support

"--------------------------------------------------------------------------------
" messages and info
"--------------------------------------------------------------------------------
set showcmd " Show partial command in the last line of screen

"--------------------------------------------------------------------------------
" editing text
"--------------------------------------------------------------------------------
set textwidth=0
set wrapmargin=0
set backspace=indent,eol,start " Make backspace work like it should
set noshowmatch                " Don't visually jump to matching bracket when typing closing one

"--------------------------------------------------------------------------------
" tabs and indenting
"--------------------------------------------------------------------------------
set shiftwidth=4  " Indent width when using << and >>
set softtabstop=4 " How many spaces should TAB be replaced with
set shiftround    " Round indendation to multiples of shiftwidth when using << and >>
set expandtab     " When typing, replace TAB with spaces
set autoindent    " Copy indentation from previous line

"--------------------------------------------------------------------------------
" mapping
"--------------------------------------------------------------------------------
set ttimeout
set ttimeoutlen=50

"--------------------------------------------------------------------------------
" reading and writing files
"--------------------------------------------------------------------------------
set nowritebackup
set nobackup
set autoread " Reload file when changed outside vim

"--------------------------------------------------------------------------------
" the swap file
"--------------------------------------------------------------------------------
set noswapfile

"--------------------------------------------------------------------------------
" command line editing
"--------------------------------------------------------------------------------
set history=1000
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.so,*.swp,*.zip
set wildignorecase
set wildmenu

"--------------------------------------------------------------------------------
" executing external commands
"--------------------------------------------------------------------------------
set shell=bash " Use zsh shell when running external commands

"--------------------------------------------------------------------------------
" multi-byte characters
"--------------------------------------------------------------------------------
set encoding=utf8

"--------------------------------------------------------------------------------
" various
"--------------------------------------------------------------------------------
set gdefault " by default replace matches in whole file, not only current line

"--------------------------------------------------------------------------------
" MAPPINGS
"--------------------------------------------------------------------------------
let mapleader="<Space>"

" Make j/k work on wrapped lines
nnoremap j gj
nnoremap k gk

" Disable help keybind
noremap <F1> <ESC>
inoremap <F1> <NOP>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Leave cursor in place when joining lines with J
nnoremap J mzJ`z

" Make selection remain after indenting
vnoremap > >gv
vnoremap < <gv

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Do not enter ex-mode with Q
nnoremap Q <nop>

" Use jk to exit insert mode
inoremap jk <esc>

" Search for selected text using */#
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"--------------------------------------------------------------------------------
" AUTOCOMMANDS
"--------------------------------------------------------------------------------
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

au VimResized * wincmd =

"--------------------------------------------------------------------------------
" PLUGINS OPTIONS
"--------------------------------------------------------------------------------
" CtrlP
let g:ctrlp_by_filename = 1             " By default search filenames only
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=0
let g:ctrlp_lazy_update = 50            " Now, that's a really nice option! (reducing lag when typing in ctrlp)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_seed_identifiers_with_syntax = 1

" Airline
let g:airline_theme='luna'

