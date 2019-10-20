"------------------------------
"	latex stuff
"------------------------------
" spel checking
setlocal spell
inoremap $ $$<esc>ha

"remove weird indent
set inde=

" autocompile when saving
autocmd BufWritePost * :!pdflatex % 

nnoremap <Leader>pdf :!zathura --fork %<.pdf<cr>
