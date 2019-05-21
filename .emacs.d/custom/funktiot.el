;;; -*- lexical-binding: t -*-
;; Omatekemien Lisp-funktioiden kokoelma
;; Author: Tommi Salenius
;; Email: tommisalenius@gmail.com
;; Created: La, 2.6.2018
;; License: GPL (2018)

(require 'cl)
(require 'thingatpt)
(require 'dash)

(defun jaa-pareiksi (x)
  "Anna argumentiksi yhtenäinen lista s-ekspressioneita
  (a b c d e f ...) ja palauta lista, jossa alkiot on
  muodostettu pareiksi tyyliin (a b), (c d), (e f), ..."
  (if (eq x nil) nil
    (cons (list (car x) (cadr x)) (jaa-pareiksi (cddr x)))))

(defmacro olk (seq &rest body)
  "Nimeä lokaali muuttuja. Let-makron ystävällisempi versio,
   joka noudattaa Clojuren notaatiota. Syötä argumenteiksi
   symboli jono s.e. jonon parittoman indeksin (1, 3, 5, ...)
   alkiot ovat symboleja ja parillisen indeksin (2, 4, 6, ...)
   jäsenet puolestaan s-expressioneita, ja lisäksi joukko
   lokaalisten muuttujien avulla evaluoitavia s-expressioneita."
  `(let* ,(jaa-pareiksi seq) ,@body))

;; Luo merkki ja palaa x määrä merkkejä takaisin

(defun luo-merkki (s m)
  "Aseta symboli s tekstiin ja palaa m askelta taakse."
  (insert s)
  (backward-char m))

;; Funktio, jolla saadaan autom. kaarisulkeet

(defun kaarisulkeet ()
  "Luo kaarisulkeet."
  ;; (interactive)
  (luo-merkki "()" 1))

(defun hakasulkeet ()
  "Luo hakasulkeet."
  (interactive)
  (luo-merkki "[]" 1))

(defun aaltosulkeet ()
    "Aseta aaltosulkeet ja mene niiden sisälle."
    (insert "{}")
    (backward-char 1))

;; Funktio, jonka avulla saadaan kirjoitettua shell-komentoja

(defun pvm (x)
  "Aseta nykyinen päivämäärä bufferiin."
  (insert (format-time-string x)))

(defun loadfunc ()
  "Lataa tämä kyseinen tiedosto."
  (interactive) (load "funktiot.el"))

(defun keskiarvo (a b)
  "Laske kahden luvun keskiarvo."
  (interactive "nAnna luku \nnAnna toinen luku ")(message "%s" (/ (+ a b) 2.0)))

(defun elisp-run (arg)
  "Tee Elisp-rivin evaluation dynaamisesti."
   (interactive)(end-of-line)
   (eval-last-sexp arg))

;; Lataa init-tiedosto uudestaan

(defun loadinit ()
  "Lataa init.el-tiedosto uudestaan."
  (interactive)(load "/Users/tommi/.emacs.d/init.el"))

;; Luodaan kokeellinen makro
;; Tämä on 1. (E)lisp-makro, luotu 4.6.2018 klo 22.22

(defmacro lfile (file)
  "Tiedoston (FILE) lataamisen shortcut."
  ((interactive)(load file)))

(defun loadabb ()
  "Lataa abbrev-taulukko."
  (lfile "aliakset.el"))

;; Tarkista onko lista nil
;;(defun null (x)
;;  "Tarkista onko X nil."
;;  (= x nil))


(defun lisp-evaluointi (arg)
    "Tallenna sijainti rivillä, liiku viimeisen )-merkin kohdalle ja evaluoi Elisp-koodi.
    Palaa lopuksi takaisin kursorin alkuperäiseen paikkaan."
    (interactive "P")
    (save-excursion
      (move-end-of-line 1)
      (search-backward ")")
      (eval-last-sexp arg)))

;; Lisää tekstiä seuraavalle riville.

(defun lisää-teksti (str)
  "Lisää STR tekstiin seuraavalle riville."
  (progn
    (end-of-line 1)
    (insert (format "\n%s" str))))


(defun pyöristä (luku tarkkuus)
  "Pyöristä annettu LUKU kun rajoitteena on tietyn desimaalin TARKKUUS."
  (let ((numb tarkkuus))
    (setq numb (concat "%." (number-to-string numb) "f"))
    (string-to-number (format numb luku))))


(defun jaa (x y)
  "Jaa X luvulla Y ja pyöristä tulosta 3:n desimaalin tarkkuudelle."
  (thread-first x
    float
    (/ (float y))
    (pyöristä 3)))

;; Kumulatiivinen summafunktio. Tarkoituksena on,
;; että tätä voi käyttää org-modessa taulukoissa
;; jotta voidaan laskea juokseavaa summaa.

(defun cumsum (termi &rest args)
  "Tee juokseva summa argumenteista ARGS listan indeksiin TERMI asti."
  (thread-last args
    (-take termi)
    (-reduce '+)))

;; Luo vastaava keskiarvo. Tässä on hyödynnetty Lispin symbolista kielenrakennetta;
;; Rakennetaan ensin cumsum-funktiota vastaava symboli, joka evaluoidaan oikeassa paikassa.

(defun cummean (termi &rest args)
  "Tee juokseva keskiarvo argumenteista ARGS listan indeksiin TERMI asti."
  ;; Tarkista ensin, että indeksi ei ylitä listan pituutta.
  (if (> termi (length args)) (message "Valitsemasi indeksi ylittää listan pituuden. Ole hyvä ja lyhennä sitä, jotta funktio toimisi normaalisti.")
    (olk (val (jaa (apply 'cumsum (cons termi args)) termi))
         (pyöristä val 3))))

;; Lue tekstiä ja evaluoi sitä Lisp-koodina.

(defun käännä-merkkijonoksi (x)
  "Tarkista onko argumentti X numero, ja jos se on, niin muunna se merkkijonoksi."
  (if (or (typep x 'float) (typep x 'integer))
      (number-to-string x) x))

(defun teksti-eval (txt)
"Lue TXT, tulkitse se Lisp-koodiksi ja evaluoi se."
  (eval (car (read-from-string txt))))
  
(defun lue-merkki-pari (merkki &optional func str)
  "Anna argumentiksi järjestetty merkkijonopari MERKKI, ja muunna se haluttuun
Lisp-koodimuotoon, jossa se voidaan evaluoida. Halutessaan käyttäjä voi määritellä
minkä funktion FUNC suhteen evaluoidaan, jolloin merkkiparia kohdellaan tämän funktion
argumentteina. Lopuksi vielä määritä onko listan toinen alkio (cadr) merkkijono asettamalla STR arvoksi t tai nil."
      ;; Jos listan alkiot ovat numeroita, käännä ne merkkijonoiksi.
   (olk (z1 (käännä-merkkijonoksi (car merkki))
	z2 (käännä-merkkijonoksi (cadr merkki))
	s-auki (if str " \"" " ")
	s-kiinni (if str "\" " " "))
     ;; Tarkista tulkitaanko listan cadr merkkijonona.
    
    (if (eq func nil)
	  (teksti-eval (concat "(" z1 " " z2 ")"))
      (olk (y (symbol-name func)
	    x (concat "(" y s-auki z1 s-kiinni z2 ")"))
	(teksti-eval x)))))


(defun nimeä-symboli (merkki)
  (olk (x nil)
    (setq x (concat "(setq " (car merkki) " " (cadr merkki) ")"))
    (eval (car (read-from-string x)))))


;; Aseta päivämäärä  

(defun pvm-viikonpäivällä ()
  "Aseta nykyinen päivämäärä systeemiin muodossa `Ma, 1.1.2000`."
  (interactive)
  (pvm "%a, %d.%m.%Y"))

(defun taulukko-eval (func table str)
       "Funktio, jolla voit äkkiä kirjoittaa mikä taulukko TABLE kuvaa niitä
    näppäinyhdistelmiä, jotka tuottavat tietyn funktion FUNC. STR on t tai nil
    riippuen siitä onko taulukon 1. sarake tarkoitettu tulkittavaksi merkkijonona
    vai symbolina, eli laitetaanko sen ympärille sitaatit vai ei."
    (mapcar (lambda (x) (lue-merkki-pari x func str)) table))

;; Ikkunoiden hallinta

(defun sulje-buffer-ja-ikkuna ()
  "Sulje nykyinen bufferi ja sulje ikkuna jos ja vain jos ikkunoita on enemmän kuin yksi."
  (interactive)
  (if (> (length (window-list)) 1)
      (progn (kill-this-buffer)
	     (delete-window))
    (kill-this-buffer)))

;; Etsi matriiseja tekstistä säännöllisen lausekkeen avulla (noudattaa Matlabin matriisikertolaskua)

(setq re-matriisi "^\\(\\[\\)[0-9a-z;.\s\\[\\]\\{1,\\}\\(\\]\\[\\)?\\(\\]\\*\\[\\)?[0-9a-z;.\s]*\\(\\]\\)'?$")

;; Aseta footeri org-tiedostojen loppuun s.e. koodiblokkien indentointi ei muutu
;; Hyödyllinen erityisesti Python-koodia sisältävien org-tiedostojen kannalta

(defun fiksaa-python-indentointi ()
  "Aseta tiedoston loppuun footeri, jossa luodaan tiedoston sisäinen muuttuja,
joka estää koodiblokeissa esiintyvän indentoinnin muuttumisen. Hyödyllinen erityisesti
Python-koodia sisältävien blokkien kannalta. Tarkoitettu vain org-tiedostoihin."
  (interactive)
  (let ((kommentti "\n#\sTämän\stehtävä\son\sfiksata\sorg-src-blokin\sPython-koodin\ssisennys\n")
	(muuttuja "#\sLocal\sVariables\n#\sorg-src-preserve-indentation:\st\n#\sEnd:")
	(otsikko "\n*\sAlaviite\n"))
    ;; Tarkistetaan ensin, löytyy Alaviite-nimistä otsikkoa tiedostosta
    (save-excursion (setq paikka (re-search-forward otsikko nil 0)))
    (if (eq paikka nil)
	;; Jos otsikkoa ei löydy, lisää se ja lokaalit muuttujat spesifioiva
	;; kommenttirivi bufferin loppuun.
	(save-excursion
	  (end-of-buffer)
	  (insert otsikko)
	  (insert kommentti)
	  (insert muuttuja))
      ;; Muussa tapauksessa älä tee mitään
      (message ""))))

;; Muunna sana lennosta isolla tai pienellä kirjoitetuksi

(defun vaihda-ekan-kirjaimen-koko ()
  "Jos sana alkaa pienellä kirjaimella, muunna se isoksi ja toisin päin."
  (interactive)
   (save-excursion
     (progn
       (if (string-match "\\b[A-ZÅÄÖ]+" (thing-at-point 'word))
	   (capitalize-word (string (thing-at-point 'word)))
	 (downcase-word (string (word-at-point)))))))


(defun mikä-sana ()
  (interactive)
  (message (number-to-string (thing-at-point 'word))))

(defun piste ()
  (interactive)
  (message (string 2)))

(defun clojure-kansio (jono)
  "Syötä merkkijono, joka kuvaa
   tiedoston kansiohierarkiaan tiedosto
   itse pois lukien

  Esim. jos tiedosto on /Users/user/Clojure/projekti/src/projekti/filu.clj,
  niin syötä tähän /Users/user/Clojure/projekti/src/projekti/.

  Funktio muokaa listasta vektorin, filtteröi pois alkioita kunnes
  se pääsee src-merkin kohdalle, ja yhdistää jäljellä olevat alkiot
  takaisin yhteen erottimena piste (.)."
  (interactive)
  (olk (kjono (split-string jono "/")
	kansio (car kjono))
    (while (not (or (string-equal kansio "test") (string-equal kansio "src")))
      (progn
	(if (> (length (cdr kjono)) 0)
	    (setq kjono (cdr kjono))
	  (error "Tiedostohierarkiassa ei ole src-kansiota! Tarkista,
            että työskentelet validin Clojure-projektin kanssa."))
	(setq kansio (car kjono))
	))
    (string-join (cdr kjono) ".")
    ))

(defun namespace-clojure ()
  "Kerää aukiolevan tiedoston polku ja palauta merkkijono,
  joka on muotoa kansio.tiedosto-ilman-liitettä."
  (interactive)
  (olk (file-nimi buffer-file-name
        kansio (file-name-directory file-nimi)
	kansio-ilman (clojure-kansio kansio)
	tiedosto (file-name-sans-extension file-nimi)
	tiedosto-ilman (file-name-base tiedosto))

       (insert (string-join (list kansio-ilman tiedosto-ilman)))))

(defun forward-sexp-ehkä-uusi-rivi (&optional args)
  "Etene s-expression kerrallaan eteenpäin. Koska tavallinen
 sp-forward-sexp jumittuu kun tullaan rivin loppuun Evil-moden
 ollessa päällä, funktio tarkistaa onko kursori rivin lopussa;
 jos se on, niin siirrytään seuraavan rivin alkuun ja jatketaan
 kuten yleensä. Funktion haittana on toistaiseksi se, että sitä
 ei voi monistaa Evil-moden normaalitilassa."
  (interactive)
  (olk (eolvar nil)
    (save-excursion 
      (forward-char 1)
      (setq eolvar (eolp)))
    (if eolvar
	(progn
	  (next-line args)
	  (beginning-of-line)
	  (sp-forward-sexp args))
      (sp-forward-sexp args))))


(defun transponoi (lst)
  "Transponoi lista ((a b c) (d e f)) muotoon
   ((a d) (b e) (c f))"
  (olk (n (length (car lst))
	  i 0
	  nlst (list (mapcar (lambda (x) (nth 0 x)) lst)))
       (while (< i n)
	 (setq i (+ 1 i))
	 (setq nlst (cons (mapcar (lambda (x) (nth i x)) lst) nlst))) ; Cons-funktio liittää uudet alkiot listan eteen, joten lopussa lista on käännettävä takaperin
       (reverse (cdr nlst)))) ; Koska (car nlst) = (nil nil), pudota ne pois

(defun liitä-merkkijonot (vec)
  (mapconcat 'identity vec ""))


(defun lisää-välit (vec)
  (mapcar (lambda (x) (concat " " x)) vec))

(defun lisää-sulut (str)
  (concat "(" str ")"))


(defun lista->elisp->eval (vstr)
  (thread-first vstr
    lisää-välit
    liitä-merkkijonot
    lisää-sulut
    teksti-eval))

(defun lainausmerkit-ympärille?
    (str bool)
  (if bool (concat "\"" str "\"") str))

(defun lista->evil-define
    (mode str? lst)
  "Tekee annetun merkkijonolistan LST perusteella major moden MODE-kohtaisen
näppäinoikotien. Funktio ottaa argumenteikseen näiden lisäksi parametrin STR?,
joka on boolelainen; jos se on t, niin tulkitaan, että listan ensimmäinen alkio
on kirjainyhdistelmä, jolloin alkion ympärille lisätään lainausmerkit, jos nil
niin ei lisätä. MODE tulee aina antaa symbolina quote-merkin kanssa.

Esim. funktio kuvaa jos str = t ja mode = 'python-mode:

(\"år\" \"python-shell-send-buffer\") -> (evil-define-key 'normal python-mode-map
(kbd \"år\") 'python-shell-send-buffer)"
  (lista->elisp->eval (list "evil-define-key" "'normal"
			(concat (symbol-name mode) "-map")
			"(kbd"
			(thread-first lst car
				      (lainausmerkit-ympärille? str?)
				      (concat ")"))
			(concat "'" (cadr lst)))))

(defun taulukko-mode-specific-keybindings
    (mode str? taulukko)
  "Ota argumentiksi org-modessa oleva taulukko ja käytä kaikki taulukon
rivit lista->evil-define-mode-funktion kautta."
  (mapcar (apply-partially 'lista->evil-define mode str?) taulukko))

(defun aja-koodi
    (func)
  (save-excursion
	 (save-buffer)
	 (eshell-command (funcall func (buffer-name)))))

(defun python-tiedosto
    ()
  (interactive)
  (aja-koodi (lambda (x) (concat "python " x))))

(defun python-eksekuuttaa
    ()
  "Aja Python-tiedosto Eshellin läpi ja tulosta
mahdollinen output näytölle."
  (interactive)
  (olk (buf-nimi (buffer-name)
	python-komento (concat "python " buf-nimi))
       (save-excursion
	 (save-buffer)
	 (eshell-command python-komento))))

(defmacro interactive-choice
    (teksti vaihtoehdot)
  "Interactive-makron laajennus, jossa käyttäjältä tivataan
jokin valmiista vaihtoehdoista. Argumentiksi syötetään
promptin teksti ja lista vaihtoehdoista, jotka käyttäjä
voi valita."
  `(interactive
    (list (completing-read ,teksti ,vaihtoehdot t nil))))

;; Bussiaikatauluskripti

(defun dösä-aikataulu
    ()
  "Muokkaa tästä sellainen, että voit hakea aikatauluja
mielivaltaisesta paikasta toiseen."
  (interactive)
  (eshell-command "python /Users/tommi/Python/Automatisointi/bussiaikataulu.py"))


;; The File Ends Here ends
