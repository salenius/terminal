;; Omatekemien Lisp-funktioiden kokoelma
;; Author: Tommi Salenius
;; Email: tommisalenius@gmail.com
;; Created: La, 2.6.2018
;; License: GPL (2018)

(require 'cl)
(require 'thingatpt)

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



;; Kerro automaaattisesti kahdella
(defun kerro-2 (x)
    "Kerro luku kahdella automaattisesti."
    (* 2 x))

(defun inc (num)
  "Kasvata numeroa NUM yhdellä."
  (setq num (1+ num)))

(defun toista (x func)
  "Toista haluttu toimenpide FUNC X määrä kertoja."
  (defvar num)
  (setq num 0)
  (while (< num x)
    (func)
    (inc x)))

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

(message "Toimii") ; Katso toimiiko

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

(pyöristä 0.4354685894483325 4)

(defun jaa (x y)
  "Jaa X luvulla Y ja pyöristä tulosta 3:n desimaalin tarkkuudelle."
  (let ((z 0))
    (setq z (/ (float x) (float y)))
    (pyöristä z 3)))

(jaa 0.45843 0.46382094)



;; Kumulatiivinen summafunktio. Tarkoituksena on,
;; että tätä voi käyttää org-modessa taulukoissa
;; jotta voidaan laskea juokseavaa summaa.

(defun cumsum (termi &rest args)
  "Tee juokseva summa argumenteista ARGS listan indeksiin TERMI asti."
  (if (> termi (length args)) (message "Valitsemasi indeksi ylittää listan pituuden. Ole hyvä ja lyhennä sitä, jotta funktio toimisi normaalisti.")
  (let ((x 0) (y 0) (lst args))
  (while (< x termi)
    (setq x (+ x 1))
    (setq y (+ y (car lst)))
    (setq lst (cdr lst)))
   y)))

;; Luo vastaava keskiarvo. Tässä on hyödynnetty Lispin symbolista kielenrakennetta;
;; Rakennetaan ensin cumsum-funktiota vastaava symboli, joka evaluoidaan oikeassa paikassa.

(defun cummean (termi &rest args)
  "Tee juokseva keskiarvo argumenteista ARGS listan indeksiin TERMI asti."
  ;; Tarkista ensin, että indeksi ei ylitä listan pituutta.
  (if (> termi (length args)) (message "Valitsemasi indeksi ylittää listan pituuden. Ole hyvä ja lyhennä sitä, jotta funktio toimisi normaalisti.")
    (let (var)
      ;; Ongelma pyritään ratkaisemaan muuttamalla ohjelman kulku cumsum-funktion muotoon.
      ;; Koska &rest args -muuttujat esiintyvät funktion bodyssa listana, ne pitää ensin
      ;; parsia cons-funktion avulla yhteen listaan termin ja cunsum-funktion kanssa.
      (setq var (cons 'cumsum (cons termi args)))
      (setq var (/ (eval var) (float termi)))
      ;; Lopuksi määrittele näytettävien desimaalien määrä. Tässä tapauksessa valittu 3.
      ;; (string-to-number (format "%.4f" var)))))
      (pyöristä var 3))))

;; Lue tekstiä ja evaluoi sitä Lisp-koodina.

(defun käännä-merkkijonoksi (x)
  "Tarkista onko argumentti X numero, ja jos se on, niin muunna se merkkijonoksi."
  (if (or (typep x 'float) (typep x 'integer))
      (number-to-string x) x))

(defun teksti-eval (txt)
"Lue TXT, tulkitse se Lisp-koodiksi ja evaluoi se."
  (eval (car (read-from-string txt))))
  

;; (defun lue-merkki-pari (merkki &optional func str)
  ;; "Anna argumentiksi järjestetty merkkijonopari MERKKI, ja muunna se haluttuun
;; Lisp-koodimuotoon, jossa se voidaan evaluoida. Halutessaan käyttäjä voi määritellä
;; minkä funktion FUNC suhteen evaluoidaan, jolloin merkkiparia kohdellaan tämän funktion
;; argumentteina. Lopuksi vielä määritä onko listan toinen alkio (cadr) merkkijono asettamalla STR arvoksi t tai nil."
  ;; (let ((x nil) (y nil) (z1 nil) (z2 nil) (s-auki nil) (s-kiinni nil))
    ;;Jos listan alkiot ovat numeroita, käännä ne merkkijonoiksi.
     ;; (setq z1 (käännä-merkkijonoksi (car merkki)))
     ;; (setq z2 (käännä-merkkijonoksi (cadr merkki)))
     ;;Tarkista tulkitaanko listan cadr merkkijonona.
     ;; (if (eq str t)
	 ;; (progn (setq s-auki " \"")
		;; (setq s-kiinni "\" "))
       ;; (progn (setq s-auki " ")
	      ;; (setq s-kiinni " ")))
    ;; (if (eq func nil)
	;; (progn
	  ;; (setq x (concat "(" z1 " " z2 ")"))
	  ;; (teksti-eval x))
      ;; (progn
	;; (setq y (symbol-name func))
	;; (setq x (concat "(" y s-auki z1 s-kiinni z2 ")"))
	;; (teksti-eval x)))))

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

(defun id (x)
  "Identiteettifunktio, palauttaa argumentin X."
  x)

(id 5)

;; (defmacro taulukko-eval (func table str)
  ;; "Makro, jolla voit äkkiä kirjoittaa mikä taulukko TABLE kuvaa niitä
  ;; näppäinyhdistelmiä, jotka tuottavat tietyn funktion FUNC. STR on t tai nil
  ;; riippuen siitä onko taulukon 1. sarake tarkoitettu tulkittavaksi merkkijonona
  ;; vai symbolina, eli laitetaanko sen ympärille sitaatit vai ei."
  ;; `(mapc (lambda (x) (lue-merkki-pari x ,func ,str)) ,table))

(defun taulukko-eval (func table str)
       "Makro, jolla voit äkkiä kirjoittaa mikä taulukko TABLE kuvaa niitä
    näppäinyhdistelmiä, jotka tuottavat tietyn funktion FUNC. STR on t tai nil
    riippuen siitä onko taulukon 1. sarake tarkoitettu tulkittavaksi merkkijonona
    vai symbolina, eli laitetaanko sen ympärille sitaatit vai ei."
    (mapc (lambda (x) (lue-merkki-pari x func str)) table))

;; Ikkunoiden hallinta

(defun sulje-buffer-ja-ikkuna ()
  "Sulje nykyinen bufferi ja sulje ikkuna jos ja vain jos ikkunoita on enemmän kuin yksi."
  (interactive)
  (if (> (length (window-list)) 1)
      (progn (kill-this-buffer)
	     (delete-window))
    (kill-this-buffer)))

;;(setq x (lue-merkki-pari '("ankka" "sorsa") 'setq t))

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

;(namespace-clojure)

;(file-name-directory buffer-file-name)

;; The File Ends Here ends
