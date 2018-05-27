""" Pythonrc
""" Tommi Salenius
""" tommisalenius@gmail.com
""" General Public License (2018)

" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal formatoptions=croql
nmap <F5> :!clear;<space>python<space>%<CR>
nmap <F6> :!python<space>%<Cr>
set foldmethod=indent

" set foldmethod=indent
let python_highlight_all=1

"Lintteri syntasticia varten
let b:ale_linters = ['pylint']

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Koodi
inoremap åy Ohi<space>on! 
