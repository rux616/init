" Spaces and Tabs
" ---------------
set tabstop=4           " Number of visual spaces per <tab>
set softtabstop=4       " Number of spaces in <tab> when editing
set expandtab           " Turns <tab> into <space>s
set autoindent          " Autoindents when you create a new line.

" UI Configuration
" ----------------
set number              " show line numbers
set cursorline          " highlight current line

" Folding
" -------
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
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
