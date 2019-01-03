" Vundle
set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" PLUGINS
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jiangmiao/auto-pairs'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()            " required
filetype plugin indent on    " required

" YCM
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

syntax on
set encoding=utf-8
let mapleader = ','

set number
set relativenumber
set showmatch

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set showcmd

set mouse=a " For middle scroll mouse paste, hold Shift

vnoremap > >gv
vnoremap < <gv

set incsearch
set smartcase

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.sh match BadWhitespace /\s\+$/

let g:NERDSpaceDelims = 1
let g:NERDAltDelims_python = 1
let g:NERDTrimTrailingWhitespace = 1

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
augroup END

" gcc compile and run - if name = test.c -> %< = test
" F4 -> compile | F5 -> compile and run
map <F4> :w <CR> :!clear && gcc % -o %< <CR>
map <F5> :w <CR> :!clear && gcc % -o %< && ./%< <CR>

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
setlocal foldmethod=syntax

