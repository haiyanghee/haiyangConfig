"------------------------------
"	latex stuff
"------------------------------

""call deoplete#custom#var('omni', 'input_patterns', {
""          \ 'tex': g:vimtex#re#deoplete
""          \})

" spel checking
setlocal spell
inoremap $ $$<esc>ha

nnoremap <buffer>k gk
nnoremap <buffer>j gj

"remove weird indent
"NOTE: if you uncomment the line below, when you use vimtex macros like "]]",
"it insets a "^F" after it ... don't know why
"set inde=

"this is the default indent keys for vim
"set indentkeys=0{,0},0),0],:,0#,!^F,o,O,e

" set up for this buffer
lua <<EOF
  local cmp = require('cmp')

  cmp.setup.buffer {
    formatting = {
      format = function(entry, vim_item)
          vim_item.menu = ({
            omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
            buffer = "[Buffer]",
            -- formatting for other sources
            })[entry.source.name]
          return vim_item
        end,
    },
    sources = cmp.config.sources({
       { name = 'omni' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    })
  }
EOF


"autocmd! BufWritePost * :!pdflatex -synctex=1 % 

""augroup texAutoCommands
""    autocmd! texAutoCommands
""    " autocompile when saving
""    "au BufWritePost * :!latexmk -pdf % 
""    au BufWritePost * :!make
""augroup END

nnoremap <Leader>pdf :!zathura --fork %<.pdf<cr>
