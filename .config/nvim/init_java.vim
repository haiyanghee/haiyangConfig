""let g:LanguageClient_serverCommands = {
""    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
""    \ }

""if has('nvim-0.5')
""  augroup lsp
""    au!
""    au FileType java lua require('jdtls').start_or_attach({cmd = {'/usr/local/bin/jdtls'}})
""  augroup end
""endif

""let g:clang_format#auto_format = 1
""let g:clang_format#auto_format_on_insert_leave = 0

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \
            \"BasedOnStyle": "LLVM",
            \"Language": "Java",
            \"IndentWidth": 8,
            \"UseTab": "Always",
            \"BreakBeforeBraces": "Linux",
            \"AlwaysBreakBeforeMultilineStrings": "true",
            \"AllowShortIfStatementsOnASingleLine": "false",
            \"AllowShortLoopsOnASingleLine": "false",
            \"AllowShortFunctionsOnASingleLine": "false",
            \"IndentCaseLabels": "false",
            \"AlignEscapedNewlinesLeft": "false",
            \"AlignTrailingComments": "true",
            \"AllowAllParametersOfDeclarationOnNextLine": "false",
            \"AlignAfterOpenBracket": "true",
            \"SpaceAfterCStyleCast": "false",
            \"MaxEmptyLinesToKeep": 2,
            \"BreakBeforeBinaryOperators": "NonAssignment",
            \"BreakStringLiterals": "false",
            \"SortIncludes":    "false",
            \"ContinuationIndentWidth": 4}
"let g:EclimCompletionMethod = 'omnifunc'

nnoremap <M-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>


""If using nvim-dap
""This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
