"""""""""""""
"  plugins  "
"""""""""""""

call plug#begin('/tmp/plugged-debug')
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

"""""""""""
"  basic  "
"""""""""""

syntax on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""
"  nvim-lsp related (completion on_attach)  "
"""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

   nvim_lsp.clangd.setup {
        capabilities = capabilities,
   }
EOF

"""""""""""""""""""""
"  completion-nvim  "
"""""""""""""""""""""
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

au Filetype lua setl omnifunc=v:lua.vim.lsp.omnifunc
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
		\ "\<Plug>(completion_confirm_completion)"  :
		\ "\<c-e>\<CR>" : "\<CR>"
""let g:completion_confirm_key = "\<C-y>"

"change completion source
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp']},
    \{'complete_items': ['path'], 'triggered_only': ['/']},
    \{'complete_items': ['vim-vsnip']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'},
\]
let g:completion_auto_change_source = 1



"""""""""""""""
"  vim-vsnip  "
"""""""""""""""

imap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand)' : '<Tab>'
imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
