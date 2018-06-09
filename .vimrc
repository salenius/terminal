"""" Tommi Salenius
"""" Vimrc-tiedosto
"""" GPL (2018)

" Aseta yleiset asetukset
set number
set wildmenu
set incsearch
set smarttab
set relativenumber
set tabstop=4
syntax on
set autoindent
filetype indent plugin on
set splitright

""" Vimbleä varten, Vimble on pluginien hallintatyökalu
set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"""
Plugin 'mattn/emmet-vim'
Plugin 'nerdtree'
"Plugin 'syntastic'
Plugin 'w0rp/ale'
""" Tuet eri kielille
Plugin 'bib.vim'
Plugin 'c.vim'
Plugin 'cpp.vim'
Plugin 'css.vim'
Plugin 'go.vim'
Plugin 'html.vim'
Plugin 'java.vim'
Plugin 'javascript.vim'
Plugin 'json.vim'
Plugin 'markdown.vim'
Plugin 'matlab.vim'
Plugin 'plaintex.vim'
Plugin 'python.vim'
Plugin 'r.vim'
Plugin 'sql.vim'
Plugin 'tex.vim'
Plugin 'updatedb.vim'
" Erillinen tuki R:lle
" Vaatii tmux-terminaalin, joka ei ole toistaiseksi käytössä
"Plugin 'jalvesaq/Nvim-R'

call vundle#end()            " required
filetype plugin indent on 

" Avaa NerdTree. Älä automatisoi tätä koska dot-tiedostojen kanssa tulee
" ongelmia
nnoremap öö :NERDTree<Cr>
nnoremap öc :NERDTreeClose<Cr>
nnoremap öb :NERDTreeFromBookmark<Space>

" Liiku ikkunoiden välillä
nnoremap åw :wincmd l<Cr>
nnoremap öh :wincmd h<Cr>
nnoremap öl :wincmd l<Cr>

" Emmet-pikanäppäinten hyödynnys
" Ts. kun haluat laajentaa lyhenteitä, niin paina å ja ,
let g:user_emmet_leader_key='å'

" Suositellut asetukset syntasticsille, eli linterille
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:ale_linters = {'c': ['cpplint'], 'cpp': ['cpplint'], 'python': ['pylint'],'r': ['lintr']}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Alen asetukset
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Tallenna ja lataa automaattisesti foldatut (=peitetyt)
" tekstit tiedoston suljettaessa ja avatessa
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Tee värimaailmasta kivempi (kommentit turkoosilla tummansinisen sijaan)
color desert

" Näppäinlyhenteet seuraavasti: Ctrl = C, Alt = M, Shift = S, Enter = Cr
nmap § $

" Aja makroja helpommin
nnoremap ä @

" Pikanäppäimet poistumiselle tiedostosta.
" ä = älä tallena
" ö = tallenna
nnoremap ää :q!
nnoremap åå :wq<Cr>
" Näppäinoikotie escille
inoremap åå <esc>
vnoremap åå <esc> 

" Hae tekstin sisällä
inoremap åf <Esc>/
inoremap åF <Esc>?
inoremap åv <Esc>v
inoremap åe <C-r>=
inoremap åh <Esc>:help<space>
nnoremap åh :help<space>
nnoremap åh :help<space>

" Hyppää pois eri sulkumerkkien sisältä
" Toimii toistaiseksi vain ()
inoremap <S><S> <esc>/)<Cr>a

" map CTRL-E to end-of-line (insert mode)
map <C-e> <esc>$i<right>
imap <F7> <esc>:w<Enter>i

" Kirjoita nopeasti funktiokomento insert-tilassa
imap <C-r> <C-r>=

" Liiku helposti seuraavaan tabiin/välilehteen
map <S-tab> <esc>gt
nmap <tab> gt

" Uusi rivi helposti
nmap <C-n> <S-e>a<Enter><esc> 

" Säädä oletuksena, että tex-tiedostot omat LaTeX-tiedostoja (ei plaintex)
let g:tex_flavor = "latex"

" Markdown-automatisointi
au BufNewFile,BufRead *.md set filetype=markdown

" Kustoimodut funktiot
function Email()
		return readfile("/Users/tommi/.vim/metadata/email.txt") 
endfunction

function License()
		return readfile("/Users/tommi/.vim/metadata/license.txt")
endfunction

function Pvm()
		return strftime('%a %d %m %y')  
endfunction

function Vuosi()
		return strftime('%Y')
endfunction

function Kansio()
		return expand('%:p:h:t') 
endfunction

" Tähän customoidut filetypet
" " Käytä tätä duunimuistiinpanojen kanssa
au BufNewFile,BufRead *.bof set filetype=bof

" Bof-komennot
autocmd FileType bof nnoremap ;env i#<space>BoF-muistiinpano,<space>salassapidettävä
autocmd FileType bof nnoremap <space><space> $a<enter><esc> 
autocmd FileType bof nnoremap ;line $a<enter>-------------------------<enter><esc>

" Bib tex
autocmd FileType bib inoremap §aer American<space>Economic<space>Review
autocmd FileType bib inoremap §jme Journal<space>of<space>Monetary<space>Economics
autocmd FileType bib inoremap §res Review<space>of<space>Economic<space>Studies
autocmd FileType bib inoremap §eco Econometrica
autocmd FileType bib inoremap §jpe Journal<space>of<space>Political<space>Economy
autocmd FileType bib inoremap §aej American<space>Economic<space>Journal
autocmd FileType bib inoremap §mac Macroeconomics
autocmd FileType bib inoremap §kak Kansantaloudellinen<space>Aikakauskirja
autocmd FileType bib inoremap §qje Quarterly<space>Journal<space>of<space>Economics

" Credit to Luke Smith
" (https://github.com/LukeSmithxyz/voidrice/blob/master/.vimrc) 
autocmd FileType bib inoremap ;a @article{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>journal<Space>=<Space>"<++>",<Enter><tab>volume<Space>=<Space>"<++>",<Enter><tab>pages<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ;b @book{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>publisher<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ;c @incollection{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>booktitle<Space>=<Space>"<++>",<Enter><tab>editor<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>publisher<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>8kA,<Esc>i

" Python-komennot
autocmd FileType python nnoremap ;env :read<space>/users/tommi/.vim/templates/Python-template<enter>ggdd<S-g><S-e>a<enter><esc>
autocmd FileType python inoremap ;pr print()<esc>i
autocmd FileType python nnoremap <F2> ggi<C-r>=readfile('/Users/tommi/.vim/templates/Python-template')<Cr><esc>?#email<Cr>c<S-e><C-r>=Email()<Cr><esc>dd/#pvm<Cr>c<S-e><C-r>=Pvm()<Cr><esc>/#lisenssi<Cr>c<S-e><C-r>=License()<Cr><esc>ddk$a<space>(<C-r>=Vuosi()<Cr>)<esc><s-G>$a<Cr><esc>

" R-komennot
autocmd FileType r nnoremap <F2> ggi<C-r>=readfile('/Users/tommi/.vim/templates/R-template')<Cr><esc>?#email<Cr>c<S-e><C-r>=Email()<Cr><esc>dd/#pvm<Cr>c<S-e><C-r>=Pvm()<Cr><esc>/#lisenssi<Cr>c<S-e><C-r>=License()<Cr><esc>ddk$a<space>(<C-r>=Vuosi()<Cr>)<esc><s-G>$a<Cr>gk<esc>
autocmd FileType r nnoremap ;env :read<space>/users/tommi/.vim/templates/R-template<enter>ggdd<S-g><S-e>a<enter><esc>
autocmd FileType r inoremap ;. $
autocmd FileType r inoremap ;varmalli vars::VAR()<esc>i
autocmd FileType r inoremap ;tilde ~ 
autocmd FileType r nnoremap <F5> :!Rscript %<Enter>
autocmd FileType r nnoremap <space><space> /#%%<enter>ce
autocmd FileType r inoremap ;func <-<space>function(#arg){<enter>#%%<enter>}<esc>?#arg<enter>ce
autocmd FileType r nnoremap cc 0i#<esc>
autocmd FileType r vnoremap cc 0i#<esc>
autocmd FileType r inoremap ,, ,<space>

" HTML-komennot
autocmd FileType html inoremap ;b <b></b><Space><Esc>FbT>i

" Java-komennot
autocmd FileType java inoremap ;main <esc>:read<space>/users/tommi/.vim/templates/java-main<enter>kddji<tab> 
autocmd FileType java nnoremap <F2> ggipackage<space><C-r>=Kansio()<Enter>;<Esc>:read<space>/Users/tommi/.vim/templates/Java-template<Enter><esc>?#mail<Cr>c<S-e><C-r>=Email()<Cr><esc>dd/#pvm<Cr>c<S-e><C-r>=Pvm()<Enter><esc>?#lisenssi<Enter>c<S-e><C-r>=License()<CR><esc>ddk$a<space>(<C-r>=Vuosi()<Cr>)<esc><S-g>$a<Cr><esc>

" Matlab-komennot
autocmd FileType matlab nnoremap <space><space> /##<Enter>c<S-e>
autocmd FileType matlab inoremap ;func function<space>###OUTPUT<space>=<space>###NIMI<space>(###args<space>)<enter><tab>%##kommentti<enter><enter>end<esc>?###NIMI<Enter>c<S-e><C-r>=expand("%:t:r")<Enter><esc>0/###OUTPUT<Enter>c<S-e>
autocmd FileType matlab nnoremap <F2> ggi<C-r>=readfile('/Users/tommi/.vim/templates/Matlab-template')<Cr><esc>?#email<Cr>c<S-e><C-r>=Email()<Cr><esc>dd/#pvm<Cr>c<S-e><C-r>=Pvm()<Cr><esc>/#lisenssi<Cr>c<S-e><C-r>=License()<Cr><esc>ddk$a<space>(<C-r>=Vuosi()<Cr>)<esc>/#info<Cr>c<S-e>


