" LaTeX -dokumenttien komennot
" Tekijä: Tommi Salenius
" Lisenssi: GPL (2018)

"""""""""" Matematiikkamerkinnät
" " Luo matikkaympäristö lennosta
noremap ;å $$<esc>i
noremap ;mal $\alpha$
noremap ;mbe $\beta$
noremap ;mde $\delta$
noremap ;mep $\epsilon$
noremap ;mga $\gamma$
noremap ;mla $\lambda$
noremap ;mka $\kappa$
noremap ;msi $\sigma$
noremap ;mro $\rho$
noremap ;mfi $\phi$
noremap ;mpi $\pi$
noremap ;mom $\omega$
noremap ;mta $\tau$
noremap ;mio $\iota$
noremap ;mmu $\mu$

" " Käytä näitä matikkamoodin sisällä
noremap ;al \alpha
noremap ;be \beta
noremap ;de \delta
noremap ;ep \epsilon
noremap ;ga \gamma
noremap ;la \lambda
noremap ;ka \kappa
noremap ;si \sigma
noremap ;ro \rho
noremap ;fi \phi
noremap ;pi \pi
noremap ;om \omega
noremap ;ta \tau
noremap ;io \iota
noremap ;mu \mu
noremap ;sum \Sigma

" Luo uusi dokumentti ja määrää sillä käytettävät temput
nnoremap <space><space> /###<Enter>ce
nnoremap ;doc :read<space>/Users/tommi/.vim/templates/Latex-template<Enter>g
nnoremap <C-j> i%<space>Tämä<space>on<space>kommentti<Enter><esc>


