" R-koodille tarkoitetut säädöt
" Tekijä: Tommi Salenius (2018)
" Lisenssi: GPL


nnoremap ;env :read<space>/users/tommi/.vim/templates/R-template<enter>ggdd<S-g><S-e>a<enter><esc>
inoremap ;. $
inoremap å<Space> <-
inoremap ;tilde ~ 
nnoremap <F5> :!Rscript %<Enter>
nnoremap <F6> :!clear ; Rscript %<Enter>
" Hyppää #%%-merkistä toiseen
nnoremap <space><space> /#%%<enter>cea
" Kommentoi rivi
nnoremap cc 0i#<esc>

" Funktio-snippetit
nnoremap ;func <-<space>function(#arg){<enter>#%%<enter>}<esc>?#arg<enter>ce
inoremap ;varmalli vars::VAR()<esc>i
inoremap ;mat matrix(c(args),<space>nrow=#%%,<space>ncol=#%%,<space>byrow=#%%)
inoremap ;pr print()<esc>i
