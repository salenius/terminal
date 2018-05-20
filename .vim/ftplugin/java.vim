" " Java-tiedostoja koskevat asetukset tänne
" " Author: Tommi Salenius
" " Lisenssi: GPL (2018)

nnoremap <F2> ggipackage<space><C-r>=expand('%:p:h:t')<Enter>;<Esc>:read<space>.vim/templates/Java-template<Enter><esc>?#pvm<Enter>c<S-e><C-r>=strftime('%a<space>%d<space>%b<space>%y')<Enter>
