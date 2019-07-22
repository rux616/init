" Set up Vundle
" -------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" github plugins
Plugin 'python/black'
Plugin 'sjl/badwolf'
Plugin 'tpope/vim-fugitive'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-packer'

" vim-scripts.org plugins
Plugin 'L9'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



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
silent! colorscheme badwolf

" Functionality
" -------------
syntax enable                       " enable syntax highlighting
set backspace=indent,eol,start      " enable backspace to backspace over things in insert mode
" automatically black-format python files on save
autocmd BufWritePre *.py execute ':Black'
if !exists("g:terraform_fmt_on_save")
    let g:terraform_fmt_on_save = 1
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

" Local Files
" -----------
if filereadable(".vimrc.local")     " enable project-specific .vimrc files
    source .vimrc.local
endif
