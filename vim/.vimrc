" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
  endif
  au BufNewFile,BufRead *.vundle set filetype=vim

" ================ Turn Off Swap Files =============="
" Options
syntax on
set number relativenumber
set termguicolors
set mouse=a
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set cursorline
set signcolumn=yes
set ignorecase
set incsearch
set hlsearch
set showcmd
set belloff=all
set updatetime=100
set shm+=I
set fillchars+=eob:\

