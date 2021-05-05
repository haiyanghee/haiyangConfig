"let g:LanguageClient_serverCommands = {
"  \ 'cpp': ['clangd'],
"  \ 'c': ['clangd'],
"  \ }
""lua require'lspconfig'.clangd.setup{}

let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0


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
            "\"ContinuationIndentWidth": 32}
