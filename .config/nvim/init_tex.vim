"------------------------------
"	latex stuff
"------------------------------

call deoplete#custom#var('omni', 'input_patterns', {
          \ 'tex': g:vimtex#re#deoplete
          \})

" spel checking
setlocal spell
inoremap $ $$<esc>ha

nnoremap <buffer>k gk
nnoremap <buffer>j gj

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
