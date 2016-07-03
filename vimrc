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
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'    }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()
"================================================================================

set encoding=utf8

filetype plugin indent on " Filetype detection
syntax on
colorscheme solarized
set t_Co=256 " Enable 256 colors
set background=dark

" Indentation options
set expandtab       " When typing, replace TAB with spaces
set softtabstop=4   " How many spaces should TAB be replaced with
set shiftwidth=4    " Indent width when using << and >>
set shiftround      " Round indendation to multiples of shiftwidth when using << and >>
set autoindent      " Copy indentation from previous line

set number " Show line numbers
set mouse=a " Enable mouse support
set backspace=indent,eol,start " Make backspace work like it should
set showcmd " Show partial command in the last line of screen

" Don't create backup files
set nobackup
set nowritebackup
set noswapfile

" Show menu with possible completion matches for commands
set wildmenu
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.so,*.swp,*.zip
set wildignorecase

" Search improvements
set hlsearch    " highlight all matches
set incsearch   " highlight matches when typing
set ignorecase  " case-insensitive searching
set smartcase   " if there are uppercase chars in search pattern, make search case sensitive
set gdefault    " by default replace matches in whole file, not only current line

set noshowmatch " Don't visually jump to matching bracket when typing closing one
set scrolloff=5 " Scroll offset
set colorcolumn=120 " Highlight n-th column

" Wrap lines visually but not psychically
set wrap
set textwidth=0 wrapmargin=0

set linebreak   " Respect words when wrapping
set breakindent " Indent wrapped text
set ttyfast " Improves drawing performance

" Reduces delay before entering normal mode after pressing ESC
set ttimeout
set ttimeoutlen=50

set autochdir " Change working directory to opened file's one

" Show tabs and trailing spaces
set list
set listchars=tab:⇢\ ,trail:·

" Make j/k move through wrapped lines
nnoremap j gj
nnoremap k gk

set laststatus=2 " Always show statusline
set hidden " Hide buffer (instead of closing)

" By default create splits on right/bottom
set splitbelow
set splitright

set shell=bash " Use zsh shell when running external commands
set autoread " Reload file when changed outside vim

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
" Disable Help keybind
noremap <F1> <ESC>
inoremap <F1> <NOP>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Make selection remain after indenting
vnoremap > >gv
vnoremap < <gv

" Leave cursor in place when joining lines with J
nnoremap J mzJ`z

" CtrlP settings
" let g:ctrlp_map = '<leader>p'
let g:ctrlp_by_filename = 1             " By default search filenames only
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files=0
let g:ctrlp_lazy_update = 50            " Now, that's a really nice option! (reducing lag when typing in ctrlp)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_clear_cache_on_exit = 0

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" YouCompleteMe options
" let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_seed_identifiers_with_syntax = 1


" bind K to grep for word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
let g:ag_working_path_mode="r"

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

nnoremap Q <nop>

let g:airline_theme='luna'

inoremap jk <esc>
inoremap <esc> <nop>

au VimResized * wincmd =

" Remap leader key
let mapleader="\<Space>"
