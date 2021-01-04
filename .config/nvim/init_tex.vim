"------------------------------
"	latex stuff
"------------------------------
" spel checking
setlocal spell
inoremap $ $$<esc>ha

"remove weird indent
set inde=

"autocmd! BufWritePost * :!pdflatex -synctex=1 % 

augroup texAutoCommands
    autocmd! texAutoCommands
    " autocompile when saving
    "au BufWritePost * :!latexmk -pdf % 
    au BufWritePost * :!make
augroup END

nnoremap <Leader>pdf :!zathura --fork %<.pdf<cr>
