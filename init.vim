" Download latest neovim as an appimage:
"   curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
" LEADER
" --------------------------------------------------------------------------------
let g:mapleader = "\<Space>"
""" PLUGINS
" --------------------------------------------------------------------------------
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " :CocInstall coc-python, coc-pairs
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " theme
    Plug 'morhetz/gruvbox'
call plug#end()
""" PLUGINS CONFIG
" --------------------------------------------------------------------------------
" CoC
" --------------------------------------------------------------------------------
let g:coc_global_extensions = [
    \ 'coc-python', 'coc-pairs'
    \ ]
" tab completion for coc
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" fzf
" --------------------------------------------------------------------------------
nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>; :BLines<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'}
""" GENERAL CONFIG
" --------------------------------------------------------------------------------
syntax on
set encoding=utf-8
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set mouse=a
set number relativenumber
set ignorecase " ignore case when searching
color gruvbox
" keep selected after changing indent
vnoremap > >gv
vnoremap < <gv
" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" Use leader + `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)
" cursor line with color
set cursorline
hi cursorline cterm=none term=none
highlight CursorLine guibg=#303000 ctermbg=234
