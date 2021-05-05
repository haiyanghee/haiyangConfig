let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ }
""if has('nvim-0.5')
""  augroup lsp
""    au!
""    au FileType java lua require('jdtls').start_or_attach({cmd = {'/usr/local/bin/jdtls'}})
""  augroup end
""endif

let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0

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
let g:EclimCompletionMethod = 'omnifunc'

