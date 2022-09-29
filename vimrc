"" vim-plug
"call plug#begin('~/.vim/plugged') " for vim, not neovim
call plug#begin(stdpath('data') . '/plugged')

"""Code completion"""
Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/deoplete.nvim'

"""Filesearch and filetree browsing"""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" on-demand loading
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} 

"""Tim Pope plugins"""
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

"""Linting"""
" Plug 'w0rp/ale'
"
"""Syntax highlighting"""
Plug 'LukeGoodsell/nextflow-vim'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}

"""Code formatting"""
Plug 'psf/black', {'branch': 'stable'}
"Plug '/home/brice/Desktop/extra_curri_PhD/snakemake_formatting/snakefmt' 
Plug 'bricoletc/snakefmt', {'branch': 'dev'} 


"""Code snippets"""
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"""Debugging"""
Plug 'puremourning/vimspector'

call plug#end()

""""Brice's settings"""""""""""""""
" Snakemake support
au BufNewFile,BufRead Snakefile,*.smk set filetype=snakemake
"au FileType snakemake autocmd BufWritePre <buffer> execute ':Snakefmt'

" ___code formatting___
" __black__
"autocmd BufWritePre *.py execute ':Black'

" tags
set tags+=./tags;/

" __clang-format__
function! Formatonsave()
  let l:formatdiff = 1
  py3f ~/.vim/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

" vimrc (vimcasts #24)
autocmd BufWritePost .vimrc source $MYVIMRC

""" source: https://youtu.be/xf0yYLj4AJI
inoremap jj <esc>
let mapleader = "\<Space>"

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" fzf
nmap // :History/<CR>
nmap /L :BLines<CR>
nmap /C :Commands<CR>

" NERDTree
let NERDTreeShowHidden=1
function! ToggleNERDTree()
    NERDTreeToggle
    " Mirror NERDTree instance in different tabs
    silent NERDTreeMirror
endfunction

nmap <leader>n :call ToggleNERDTree()<CR>

" Set "<leader>s" to substitute the word under the cursor
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
"""

set tabstop=4
set expandtab
set shiftwidth=4
set number
set ignorecase
set smartcase " if search contains uppercase, search becomes case-sensitive. To search lowercase only, use `pattern\C`.
set title

" Place backup files in own directory; double slash avoids same file name ambiguity
:set backupdir=~/.vim/backup//,.

""" YouCompleteMe
" Remove the documentation popup by default, and add a mapping to trigger it
let g:ycm_auto_hover = ""
"nmap <leader>d <plug>(YCMHover)
nmap <leader>d :YcmCompleter GetDoc<CR>
" Run the 'guessing' GoTo: go to declaration/definition, include file, ...
nmap <leader>g :YcmCompleter GoTo<CR>
" Error diagnostics go to `locationlist`: `:lopen`, `:lclose`
let g:ycm_always_populate_location_list = 1

" Get all references to symbol under cursor
nmap <leader>r :YcmCompleter GoToReferences<CR>

""" Source: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" Make it obvious where 80 characters is
set textwidth=88
set colorcolumn=89

" Quicker buffer movement
" nnoremap <leader>b :ls<CR>:b<Space>
nnoremap <leader>b :Buffers<CR>

" Quicker window movement and exit
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <leader>q <C-w>q

" Quicker tab movement
nnoremap 11 1gt
nnoremap 22 2gt
nnoremap 33 3gt

" Quick vimrc editing
nnoremap <leader>v :edit $HOME/.vimrc<CR>

" Paste current filename
nnoremap <leader>f "%p

" Open new window at jumplist target number x (eg for equivalent of Ctrl-W s 2 Ctrl-O, use 2<leader>j)
nnoremap <leader>j :<C-u>execute 'split +normal\ ' . v:count . '<C-o>'<CR>

"""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
""""""""""""""""""

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit


