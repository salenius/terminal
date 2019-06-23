;; Emacs-asetustiedosto
;; Author: Tommi Salenius
;; Email: tommisalenius at gmail.com
;; Created: Su 27 05 18
;; License: GPL (2018)

;; Tähän tulee Emacsille tehtävät perusasetukset.
;; Laita kaikki uudet asetukset emacs.org-nimiseen tiedostoon oikean
;; välilehden alle.

(setq lexical-binding t)

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Use-package toimintaan
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/Users/tommi/.emacs.d/elpa")
  (require 'use-package))

;; Ido-moodi päälle
;; (require 'ido)
;; (ido-mode t)

(use-package ido
  :config (ido-mode t))

;; Laita oletuksena Vim-näppäimet
;; (require 'evil)
;; (evil-mode 1)
;; Tähän customoidut komennot

(add-to-list 'exec-path "/Users/tommi/.local/bin")
(add-to-list 'load-path "/Users/tommi/.emacs.d/custom")


;; Lataa aliakset
(load "aliakset.el")
(load "funktiot.el")
(load "apikeys.el") ;; API-avaimet
(setq-default abbrev-mode t)
(setq abbrev-file-name
      "/Users/tommi/.emacs.d/custom/erikoismerkit.el")
(load "erikoismerkit.el")


;; Käytä org-modea
(require 'org)
(setq org-src-fontify-natively t)

;; Käynnistä serveri geeknotea varten
(server-start)

;; Hae terminaalista ympäristömuuttujat
(exec-path-from-shell-initialize)

;; Pistä flycheck-moodi globaaliksi, tämä mahdollistaa virheiden ilmoittamisen
(global-flycheck-mode)

;; Smartparens-paketin käyttö sulkujen hallintaan
;; Keksi tähän jotain

;; ######### Mahdollista snippetit ##########
(add-to-list 'load-path "/Users/tommi/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Käytä Common Lisp -paketteja

(require 'cl)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-safe-themes
   (quote
    ("ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba" "e1994cf306356e4358af96735930e73eadbaf95349db14db6d9539923b225565" "4af6fad34321a1ce23d8ab3486c662de122e8c6c1de97baed3aa4c10fe55e060" "3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" default)))
 '(elfeed-feeds
   (quote
    ("http://johnhcochrane.blogspot.com/feeds/posts/default/" "http://noahpinionblog.blogspot.com" "http://noahpinionblog.blogspot.com/" "http://johnhcochrane.blogspot.com/" "http://newmonetarism.blogspot.com/")))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
	  (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
			 (:color "#808080"))
     (implicitParams :underline
		     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(package-selected-packages
   (quote
    (company-lsp lsp-python lsp-mode md4rd ess-mode org-gcal ob-ipython helm-org-rifle gnuplot ein xref-js2 js2-refactor js2-mode ace-jump-mode expand-region rust-mode zenburn-theme helpful evil-lion org-ref company-statistics paredit projectile evil-smartparens clojure-mode markdown-mode cider haskell-mode multiple-cursors vlf virtualenvwrapper emms ob-prolog all-the-icons-dired all-the-icons google-translate flx ivy-youtube ido-vertical-mode 0blayout company general elisp-def ido-at-point counsel eclipse-theme w3m evil-magit helm-google helm-youtube helm which-key powerline-evil ivy elmacro smex elfeed-org elfeed ox-reveal org hydra bog gandalf-theme python-cell magit org-bullets suggest smartparens flycheck exec-path-from-shell jedi-direx virtualenv elpy python-mode auto-virtualenv jedi anaconda-mode yasnippet matlab-mode ess ace-window darcula-theme geeknote dracula-theme google-maps evil)))
 '(safe-local-variable-values (quote ((org-src-preserve-indentation . t))))
 '(virtualenv-root "/Applications/anaconda3/envs/BoF/bin/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(abbrev-mode -1)

;; Lataa omat asetukset emacs.org-tiedostosta

(org-babel-load-file
  (expand-file-name "/Users/tommi/.emacs.d/emacs_uusi.org"))

;; Koodi päättyy
