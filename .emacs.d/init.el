;; Emacs-asetustiedosto
;; Author: Tommi Salenius
;; Email: tommisalenius at gmail.com
;; Created: Su 27 05 18
;; License: GPL (2018)

;; Tähän tulee Emacsille tehtävät perusasetukset
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Tähän customoidut komennot

(add-to-list 'exec-path "/usr/local/bin")

;; Laita oletuksena Vim-näppäimet
(require 'evil)
(evil-mode 1)

;; Käynnistä serveri geeknotea varten
(server-start)

;; Hiljennä merkkiäänet
(setq ring-bell-function 'ignore)

;; ########## Valitse teema ##############
(load-theme 'darcula)

;; ########## Evil-mode keyboardshortcut / pikanäppäimet ############
					; Insert-mode
;; Käytä: å
(define-key evil-insert-state-map "åå" 'evil-force-normal-state) ; Poistu insert-modesta normal-modeen
					; Normal-mode
(define-key evil-normal-state-map "åk" 'describe-key) ; Tutki äkkiä jonkun näppäinyhdistelmän merkitys 
(define-key evil-normal-state-map "åf" 'search-forward)
(define-key evil-normal-state-map "öö" 'ace-window) ; Mahdollista liikkuminen ikkunoiden välillä
(define-key evil-normal-state-map "åg" 'find-file) ; Etsi tiedosto
(define-key evil-normal-state-map "öwh" 'split-window-horizontally)
(define-key evil-normal-state-map "ås" 'save-buffer) ; Tallena tiedosto
(define-key evil-normal-state-map "§" 'end-of-line) ; Mene rivin loppuun
(define-key evil-normal-state-map "ää" 'evil-execute-macro) ; Aja makro
;; (define-key evil-normal-state-map "" ')


(set-keyboard-coding-system nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" default)))
 '(package-selected-packages
   (quote
    (ess ace-window darcula-theme geeknote dracula-theme google-maps evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
