"""""""""""""
"  plugins  "
"""""""""""""

call plug#begin('/tmp/plugged-debug')
Plug 'lervag/vimtex'

Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/nvim-cmp'
call plug#end()

let g:vimtex_enabled=1 

lua <<EOF
  require('cmp').setup.buffer {
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
    sources = {
      { name = 'omni' },
    }, {
      { name = 'buffer' },
    }
  }
EOF
