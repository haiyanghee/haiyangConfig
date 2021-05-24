call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rhysd/vim-clang-format' 

"vimtex
Plug 'lervag/vimtex'

"neomake
Plug 'neomake/neomake'

"eclim??
"Plug 'dansomething/vim-eclim'

Plug 'mfussenegger/nvim-jdtls'
"Syntax highlighting for magma
Plug 'petRUShka/vim-magma'

"vim git stuff
Plug 'tpope/vim-fugitive'

"LSP
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

""Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

"will make vim to reload files that are saved but not edited..
Plug 'djoshea/vim-autoread'

"Plug 'nvim-lua/completion-nvim'

"Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
endif

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'deoplete-plugins/deoplete-lsp'

"python3 support for deoplete:
"pip3 install --user pynvim

"Deoplete for clang 
"Plug 'zchee/deoplete-clang'

" echodoc (shows you the function arguments..)
"Plug 'Shougo/echodoc.vim'

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
"let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_callback_hooks = ['MyTestHook']
function! MyTestHook(status)
  echom a:status
endfunction



if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also https://sunaku.github.io/vim-256color-bce.html
    set t_ut=y
endif


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
"hi! Visual guibg=#64666D

"hi! Visual guibg=#70727A
"hi! Visual guibg=#56596A
"hi! NonText ctermbg=NONE guibg=NONE
"hi! Cursor guibg=white guifg=black
"set cursorline
"set guicursor=
"hi! MatchParen  guibg=darkgreen
set termguicolors

set path+=**
set wildmenu
set hidden "allows switching buffers without saving

filetype on
filetype indent on
filetype plugin on

"visually select text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"copy file name
nnoremap cf :let @+=expand("%:t")<CR>
nnoremap yf :let @"=expand("%:t")<CR>
"copy file path
nnoremap cF :let @+=expand("%:p")<CR>
nnoremap yF :let @"=expand("%:p")<CR>

nnoremap t :tabe<cr>:Ex<cr>
"nnoremap k gk
"nnoremap j gj

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

"view and reload vimrc
nnoremap <Leader>sv: :source ~/.config/nvim/init.vim<cr>
nnoremap <Leader>ev: :vsplit ~/.config/nvim/init.vim<cr>
" use urlview
"nnoremap <Leader>u :w<Home>slient <End> !urlview<CR>
noremap <Leader>u :w<Home>silent <End> !urlview<CR>


"LSP
"let g:LanguageClient_autoStart = 1
"let g:LanguageClient_trace = 'verbose'
"let $RUST_BACKTRACE = 'full'
"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_loggingFile = '/tmp/languageclient-neovim.log'
"let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'

"nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> K :call LanguageClient#explainErrorAtPoint()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"let g:LanguageClient_useFloatingHover=1

"table mode compatibility with markdown
let g:table_mode_corner='|'


"Telescope
"Turns off deoplete completion in telescope prompt
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').file_browser()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"Deoplete
let g:deoplete#enable_at_startup = 1
set completeopt+=menuone,preview

"defx settings
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

autocmd BufWritePost * call defx#redraw()


"lsp settings
lua << EOF

local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua PeekDefinition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) -- not supported by clang yet
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
   buf_set_keymap('n', '<space>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
  -- buf_set_keymap('n', '<space>ca', "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>", opts)
   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
  -- buf_set_keymap('n', '<leader>ws', "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
  buf_set_keymap('n', '<leader>ws', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)

  -- clang header open in vsplit (see below)
  buf_set_keymap('n', '<leader>h', '<cmd>:ClangdSwitchSourceHeaderVSplit<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

    --Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end


-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
 local servers = { "pyright", "rust_analyzer", "tsserver" }
 for _, lsp in ipairs(servers) do
   nvim_lsp[lsp].setup { on_attach = on_attach, }
 end


 -- to open header file as a vsplit
local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = require'lspconfig'.util.validate_bufnr(bufnr)
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
        if err then error(tostring(err)) end
        if not result then print ("Corresponding file can’t be determined") return end
        vim.api.nvim_command(splitcmd..' '..vim.uri_to_fname(result))
    end)
end


   nvim_lsp.clangd.setup { on_attach = on_attach,
        commands = {
    	    ClangdSwitchSourceHeader = {
                function() switch_source_header_splitcmd(0, "edit") end;
                description = "Open source/header in current buffer";
            },
            ClangdSwitchSourceHeaderVSplit = {
                function() switch_source_header_splitcmd(0, "vsplit") end;
                description = "Open source/header in a new vsplit";
            },
            ClangdSwitchSourceHeaderSplit = {
                function() switch_source_header_splitcmd(0, "split") end;
                description = "Open source/header in a new split";
            }
    }
   }
EOF

"For comment highlighting (such as TODO, FIXME, ... ) install the `comment` parser!
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        custom_captures = {},
    },
}
EOF


" making the autocmpletion a bit more pleaseant
autocmd CompleteDone * silent! pclose!
autocmd InsertLeave * silent! pclose!

set updatetime=1000

"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow

"setting the paths to libclang, which was required for deoplete-clang
"let g:deoplete#sources#clang#libclang_path = '/lib/libclang.so'
"let g:deoplete#sources#clang#clang_header = '/lib/clang'
 " path to directory where library can be found

"set cmdheight=2
"set noshowmode
"let g:echodoc#enable_at_startup = 1


"autocmd!  BufRead,BufEnter *.tex source ~/.config/nvim/init_tex.vim

augroup filetypeAutoCommands
    autocmd! filetypeAutoCommands

    au  BufRead,BufEnter * checktime

    au VimResized * exe "normal \<c-w>="
    
    "set formatoptions-=cro " removes the shityy auto commenter
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    
    " NOTE Using BufEnter might be a better idea because there are some cases where BufRead will not tigger
    
    au  VimResized * exe "normal \<c-w>="

" tex
    au  BufRead,BufEnter *.tex source ~/.config/nvim/init_tex.vim
" autocmd BufRead,BufEnter *.tex :!make

" c++
    au  BufReadPre,BufRead,BufEnter *.cpp source ~/.config/nvim/init_cpp.vim
    au  BufReadPre,BufRead,BufEnter *.hpp source ~/.config/nvim/init_cpp.vim

" c
    au  BufReadPre,BufRead,BufEnter *.c source ~/.config/nvim/init_cpp.vim
    au  BufReadPre,BufRead,BufEnter *.h source ~/.config/nvim/init_cpp.vim

" haskell
    au  BufReadPre,BufRead,BufEnter *.hs source ~/.config/nvim/init_haskell.vim

" java
    au  BufReadPre,BufRead,BufEnter *.java source ~/.config/nvim/init_java.vim

" python
    au  BufReadPre,BufRead,BufEnter *.py source ~/.config/nvim/init_python.vim

" md
    au  BufRead,BufEnter *.md source ~/.config/nvim/init_md.vim

" update sxhkdrc
    au  BufWritePost *sxhkdrc :!killall sxhkd; sxhkd &
augroup END

"autocmd  BufWritePost ~/dwm-haiyang/*.h :!sudo make clean install
"autocmd  BufWritePost ~/dwm-haiyang/*.c :!sudo make clean install
autocmd  BufWritePost *.Xresources :!xrdb .Xresources

" vim
"autocmd BufRead,BufEnter *. source ~/.vimrc
"let g:EclimCompletionMethod = 'omnifunc'
