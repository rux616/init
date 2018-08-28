" Spaces and Tabs
" ---------------
set tabstop=4                       " Number of visual spaces per <tab>
set softtabstop=4                   " Number of spaces in <tab> when editing
set expandtab                       " Turns <tab> into <space>s
set autoindent                      " Autoindents when you create a new line.

" UI Configuration
" ----------------
set number                          " show line numbers
set cursorline                      " highlight current line

" Folding
" -------
set foldenable                      " enable folding
set foldlevelstart=10               " open most folds by default
set foldnestmax=10                  " 10 nested fold max
" space opens/closes folds
nnoremap <space> za

" Movement
" --------
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj

" Colors
" ------
colorscheme badwolf

" Functionality
" -------------
syntax enable                       " enable syntax highlighting
set backspace=indent,eol,start      " enable backspace to backspace over things in insert mode

" Keymaps
" -------
" Adds some GUI-centric keymaps for moving to next/previous word
nnoremap <C-Left> b
vnoremap <C-S-Left> b
nnoremap <C-S-Left> gh<C-O>b
inoremap <C-S-Left> <C-\><C-O>gh<C-O>b
nnoremap <C-Right> w
vnoremap <C-S-Right> w
nnoremap <C-S-Right> gh<C-O>w
inoremap <C-S-Right> <C-\><C-O>gh<C-O>w

