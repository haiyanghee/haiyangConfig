"let g:LanguageClient_serverCommands = {
"  \ 'cpp': ['clangd'],
"  \ 'c': ['clangd'],
"  \ }
""lua require'lspconfig'.clangd.setup{}

"""see https://jeffkreeftmeijer.com/vim-number/
"""try hybrid line numbers
""set number relativenumber
""set nu rnu
""
"""this is if you have 2 windows and leave one, then all the line numbers will
"""show
""augroup numbertoggle
""  autocmd!
""  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
""  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
""augroup END

"shitty temporary solution to change and excluding livegrep directories
"nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep(require('summerProject').myTable())<cr>
""nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>

let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0

"this should detect the .clang-format file in the parent directory
let g:clang_format#detect_style_file = 1


"according to https://github.com/rhysd/vim-clang-format/issues/6
"the style options will be run if no .clang-format file is detected
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "c++17",
            \
            \"BasedOnStyle": "LLVM",
            \"Language": "Cpp",
            \"IndentWidth": 8,
            \"UseTab": "Always",
            \"BreakBeforeBraces": "Linux",
            \"AlwaysBreakBeforeMultilineStrings": "false",
            \"AllowShortIfStatementsOnASingleLine": "true",
            \"AllowShortLoopsOnASingleLine": "true",
            \"AllowShortFunctionsOnASingleLine": "true",
            \"IndentCaseLabels": "false",
            \"AlignEscapedNewlinesLeft": "false",
            \"AllowAllParametersOfDeclarationOnNextLine": "true",
            \"AlignAfterOpenBracket": "true",
            \"SpaceAfterCStyleCast": "false",
            \"MaxEmptyLinesToKeep": 2,
            \"BreakBeforeBinaryOperators": "All",
            \"BreakStringLiterals": "false",
            \"SortIncludes":    "false",}
            "\"ContinuationIndentWidth": 8}
