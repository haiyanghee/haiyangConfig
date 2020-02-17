call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rhysd/vim-clang-format' 

"vimtex
Plug 'lervag/vimtex'

Plug 'neomake/neomake'

"LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'



"Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
endif

"Deoplete for clang 
"Plug 'zchee/deoplete-clang'

" echodoc (shows you the function arguments..)
Plug 'Shougo/echodoc.vim'

"Vim table mode
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

let g:tex_flavor = 'latex'

"start server 
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

let g:vimtex_enabled=1 "enable vimtex
let g:vimtex_quickfix_enabled=0
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_callback_hooks = ['MyTestHook']
function! MyTestHook(status)
  echom a:status
endfunction



augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)


syntax on
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
set tabstop=4 shiftwidth=4 expandtab
set autoread
set ignorecase
set smartcase
set background=dark
colorscheme dracula
hi! Normal ctermbg=NONE guibg=NONE
set cursorline
set guicursor=
set termguicolors

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
"inoremap ' ''<esc>ha
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

"To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
"To use `ALT+{h,j,k,l}` to navigate windows from any mode:
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


nnoremap <Leader>sv: :source ~/.config/nvim/init.vim<cr>
nnoremap <Leader>ev: :vsplit ~/.config/nvim/init.vim<cr>


"LSP
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> K :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_useFloatingHover=1


let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 1
set completeopt+=menuone,preview
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" making the autocmpletion a bit more pleaseant
autocmd CompleteDone * silent! pclose!
autocmd InsertLeave * silent! pclose!

"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow

"setting the paths to libclang, which was required for deoplete-clang
"let g:deoplete#sources#clang#libclang_path = '/lib/libclang.so'
"let g:deoplete#sources#clang#clang_header = '/lib/clang'


set cmdheight=2
let g:echodoc#enable_at_startup = 1



"enable  tab stuff
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"For greenlet problem, just do the following:
"pip3 uninstall pynvim
"cd ~/.local/lib/python3.7/site-packages/
"rm -r greenlet-0.4.15-py3.7.egg-info greenlet.cpython-37m-x86_64-linux-gnu.so
"pip3 install --user --no-binary :all: pynvim



autocmd!  BufRead,BufEnter *.tex source ~/.config/nvim/init_tex.vim


augroup filetypeAutoCommands
    autocmd! filetypeAutoCommands

    au VimResized * exe "normal \<c-w>="
    
    "set formatoptions-=cro " removes the shityy auto commenter
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    
    " NOTE Using BufEnter might be a better idea because there are some cases where BufRead will not tigger
    
    au  VimResized * exe "normal \<c-w>="

" tex
    "au  BufRead,BufEnter *.tex source ~/.config/nvim/init_tex.vim
" autocmd BufRead,BufEnter *.tex :!make

" c++
    au  BufRead,BufEnter *.cpp source ~/.config/nvim/init_cpp.vim

" c
    au  BufRead,BufEnter *.c source ~/.config/nvim/init_cpp.vim

" haskell
    au  BufRead,BufEnter *.hs source ~/.config/nvim/init_haskell.vim

" java
    au  BufRead,BufEnter *.java source ~/.config/nvim/init_java.vim

" python
    au  BufRead,BufEnter *.py source ~/.config/nvim/init_python.vim

" md
    au  BufRead,BufEnter *.md source ~/.config/nvim/init_md.vim

" update sxhkdrc
    au  BufWritePost *sxhkdrc :!killall sxhkd; setsid  sxhkd &
augroup END

"autocmd  BufWritePost ~/dwm-haiyang/*.h :!sudo make clean install
"autocmd  BufWritePost ~/dwm-haiyang/*.c :!sudo make clean install

" vim
"autocmd BufRead,BufEnter *. source ~/.vimrc
let g:EclimCompletionMethod = 'omnifunc'
