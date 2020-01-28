" Vundle
set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" PLUGINS
Plugin 'gmarik/Vundle.vim'
Plugin 'tmsvg/pear-tree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'plasticboy/vim-markdown'
call vundle#end()            " required
filetype plugin indent on    " required

" YCM
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
" Remove preview window
set completeopt-=preview

syntax on
set encoding=utf-8
let mapleader = ','

set number
set relativenumber
set showmatch
set autowrite "Autosave when :make

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

" Return to the same line you left off at
augroup line_return
        au!
        au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \       execute 'normal! g`"zvzz' |
                \ endif
augroup END

setlocal foldmethod=syntax
