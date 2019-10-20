call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rhysd/vim-clang-format' 

"LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

"LSP
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"enable  tab stuff
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"For greenlet problem, just do the following:
"pip3 uninstall pynvim
"cd ~/.local/lib/python3.7/site-packages/
"rm -r greenlet-0.4.15-py3.7.egg-info greenlet.cpython-37m-x86_64-linux-gnu.so
"pip3 install --user --no-binary :all: pynvim

Plug 'dhruvasagar/vim-table-mode'

call plug#end()



syntax on
color dracula

set mouse=a
set noswapfile
set incsearch 
set showmatch 
set encoding=utf-8
set backspace=indent,eol,start
set hlsearch
set number
set laststatus=2
set ruler
set tabstop=4
set autoread
set cursorline
set ignorecase
set smartcase
filetype on
filetype indent on
filetype plugin on

nnoremap t :tabe<cr>:Ex<cr>
nnoremap k gk
nnoremap j gj
nnoremap <C-h> <C-w> h
nnoremap <C-j> <C-w> j
nnoremap <C-k> <C-w> k
nnoremap <C-l> <C-w> l
map <C-c> "+y<CR>

"bracket completion
inoremap ( ()<esc>ha
inoremap { {}<esc>ha
inoremap {<cr> {<cr>}<esc>kA<cr><esc>cc
inoremap [ []<esc>ha
inoremap ' ''<esc>ha
inoremap " ""<esc>ha

"modifying brackets
noremap <Leader>( ci(
noremap <Leader>) ci)
noremap <Leader>{ ci{
noremap <Leader>} ci}
noremap <Leader>[ ci[
noremap <Leader>] ci]
noremap <Leader>< ci<
noremap <Leader>> ci>
noremap <Leader>' ci'
noremap <Leader>' ci"


nnoremap <Leader>sv: :source ~/.vimrc<cr>
nnoremap <Leader>ev: :vsplit ~/.vimrc<cr>

autocmd VimResized * exe "normal \<c-w>="

" tex
autocmd BufRead,BufEnter *.tex source ~/.vim/ftplugin/tex.vim
" autocmd BufRead,BufEnter *.tex :!make

" c++
autocmd BufRead,BufEnter *.cpp source ~/.vim/ftplugin/cpp.vim

" c
autocmd BufRead,BufEnter *.c source ~/.vim/ftplugin/cpp.vim

" haskell
autocmd BufRead,BufEnter *.hs source ~/.vim/ftplugin/haskell.vim

" java
autocmd BufRead,BufEnter *.java source ~/.vim/ftplugin/java.vim

" md
autocmd BufRead,BufEnter *.md source ~/.vim/ftplugin/md.vim

" dwm compilation lol
autocmd BufWritePost ~/dwm-haiyang/*.h :!sudo make clean install
autocmd BufWritePost ~/dwm-haiyang/*.c :!sudo make clean install

" vim
"autocmd BufRead,BufEnter *. source ~/.vimrc
let g:EclimCompletionMethod = 'omnifunc'
