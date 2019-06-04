" Functions
" ---------
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" General
" -------
set nocompatible                    " Turn off compatible mode

" Spaces and Tabs
" ---------------
set tabstop=2                       " Number of visual spaces per <tab>
set softtabstop=2                   " Number of spaces in <tab> when editing
set shiftwidth=2                    " Number of spaces to use for each step of indenting
set expandtab                       " Turns <tab> into <space>s
set autoindent                      " Autoindents when you create a new line.

" UI Configuration
" ----------------
set number                          " show line numbers
set cursorline                      " highlight current line
set laststatus=2                    " Force statusline to show
" Build a statusline
set statusline=
set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %F
set statusline+=%m\ 
set statusline+=%=
"set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

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
if filereadable(".vimrc.local")     " enable project-specific .vimrc files
    source .vimrc.local
endif

" Security
" --------
if v:version < 801 || !has("patch-8.1.1365")    " check if vim is < v8.1.1365
    set nomodeline                              " disable modeline capability for security purposes
endif                                           " see https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md for more info

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
