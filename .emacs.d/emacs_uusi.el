(setq lexical-binding t)

(set-language-environment "UTF-8") (set-default-coding-systems 'utf-8)
(set-locale-environment "fi_FI.UTF-8")
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(setq initial-scratch-message "Toimii")

(let ((user-info (quote (("sähköpostiosoite" "tommisalenius@gmail.com")))))
(setq sähköpostiosoite "tommisalenius@gmail.com")
)

(tool-bar-mode -1)

(setq inhibit-startup-screen t)

(global-hl-line-mode nil)

;; (define-key key-translation-map (kbd "åe") (kbd "M-x"))
;; (define-key key-translation-map (kbd "åE") (kbd "M-X"))

(global-linum-mode t)

(setq backup-directory-alist '(("." . "/Users/tommi/.emacs.d/backup")))

(setq ring-bell-function 'ignore)

(display-time-mode 1)
(setq display-time-24hr-format t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq explicit-shell-file-name "/bin/zsh")

(load-theme 'zenburn)

(set-cursor-color "#c8a2c8")

(require 'company)
(setq company-idle-delay 0)

(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'lisp-interactive-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'ess-mode-hook 'company-mode)

(setq-default require-final-newline nil)

(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode  ess-r-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

;; (yasnippet backquote-change) to ‘warning-suppress-types’

(load "apikeys.el")

(use-package evil
  :ensure t
  :init

  (defmacro def-avain (nimi moodi)
    "Yleistyökalu, jonka avulla käyttäjä voi luoda funktioita, jotka asettavat
    puolestaan pikanäppäinkomennon tietyn tilan funktioille. NIMI on funktion nimi,
    jonka makro palauttaa, MOODI on puolesta mode, jolle funktio voi luoda näppäinyhdistelmän."
    `(defun ,nimi (key func)
       (define-key ,moodi (kbd key) func)))

  (defmacro luo-avain (moodi key func)
    `(add-hook (quote ,(intern (concat (symbol-name moodi) "-hook")))
		 (lambda () (evil-define-key 'normal ,(intern (concat (symbol-name moodi) "-map")) (kbd ,key) (quote ,func)))))


  (defmacro kirjoita (merkki)
    `(lambda ()
       (interactive)(insert ,merkki)))

  (def-avain evil/ins evil-insert-state-map)
  (def-avain evil/n evil-normal-state-map)
  (def-avain evil/i evil-insert-state-map)
  (def-avain evil/m evil-motion-state-map)
  (def-avain evil/v evil-visual-state-map)
  (def-avain company/a company-active-map)

  :config
  (evil-mode 1)

  (evil/n "§" 'end-of-line)
  (evil/n "zj" 'evil-scroll-down)
  (evil/n "zk" 'evil-scroll-up)
  
  (evil/n "ås" 'save-buffer)
  (evil/n "öb" 'counsel-ibuffer)
  (evil/n "öä" 'kill-this-buffer)
  
  (evil/n "öd" 'dired)
  (evil/n "gf" 'helm-find-files)
  (evil/n "ää" 'evil-execute-macro)
  
  (evil/n "öwh" 'split-window-right)
  (evil/n "öwv" 'split-window-below)
  (evil/n "ökt" 'delete-window)
  (evil/n "öka" 'delete-other-windows)
  (evil/n "öö" 'ace-window)
  (evil/n "åhf" 'counsel-describe-function)
  (evil/n "åhv" 'counsel-describe-variable)
  (evil/n "åhk" 'describe-key)
  (evil/n "åhl" 'select-jargon)
  (evil/n "åe" 'helm-M-x)
  (evil/i "åe" 'helm-M-x)
  (evil/v "åe" 'helm-M-x)
  (evil/n "C-s" 'swiper)

  (evil/n "C-ö" 'comment-line)
  (evil/n "ål" 'eval-last-sexp)
  (evil/n "åL" 'eval-last-sexp-and-replace-it-by-result)
  (evil/n "å TAB" 'indent-region)

  (evil/n "ånm" 'bookmark-set)
  (evil/n "gm" 'bookmark-jump)

  (evil/i "C-ö" 'evil-normal-state)
  (evil/i "å." (kirjoita "å"))
  (evil/i "åi" (kirjoita "|"))
  (evil/i "¨s" (kirjoita "\\"))
  (evil/i "¨d" (kirjoita "$"))
  (evil/i "å2" (kirjoita "@"))
  (evil/i "å SPC" 'sp-forward-sexp)
  
  (evil/n ",j" 'sp-join-sexp)
  (evil/n ",s" 'sp-forward-slurp-sexp)
  (evil/n ",S" 'sp-backward-slurp-sexp)
  (evil/n ",b" 'sp-forward-barf-sexp)
  (evil/n ",B" 'sp-backward-barf-sexp)
  (evil/n ",u" 'sp-unwrap-sexp)
  (evil/n ",k" 'sp-kill-sexp)
  (evil/n "D" 'sp-kill-hybrid-sexp)
  (evil/n ",K" 'sp-backward-kill-sexp)
  (evil/n ",ww" 'sp-wrap-round)
  (evil/n ",t" 'sp-transpose-sexp)
  (evil/n ",T" 'sp-transpose-hybrid-sexp)
  (evil/n ",a" 'sp-beginning-of-sexp)
  (evil/n ",l" 'sp-end-of-sexp)
  (evil/n ",e" 'sp-emit-sexp)
  
  (evil/v ",ww" 'sp-wrap-round)
  (evil/n ",wc" 'sp-wrap-curly)
  (evil/v ",wc" 'sp-wrap-curly)
  (evil/n ",ws" 'sp-wrap-square)
  (evil/v ",ws" 'sp-wrap-square)

  ;; Hydrat

  (evil/n "åg" 'magit-hydra/body)
  (evil/n "åt" 'shell-hydra/body)

  ;; Major mode -spesifit evil-pikanäppäimet
  (luo-avain org-mode "åre" org-edit-src-code)
  (luo-avain org-src-mode "ås" org-edit-src-exit)
  (luo-avain ess-mode "årr" ess-eval-region-or-function-or-paragraph-and-step)
  (luo-avain ess-mode "årl" ess-load-file)
  (luo-avain ess-mode "åd" ess-display-help-on-object)
  (luo-avain python-mode "åd" elpy-doc)
  (luo-avain python-mode "åp" python-projekti-hydra/body)
  

  )

(use-package helm
  :ensure t
  :init (require 'helm-config))

(use-package hydra
  :init

  (defhydra magit-hydra (:color pink
  				:hint nil)
      "
  ^Branch^         ^Versionhallinta^
  ^^^^^^^-----------------------------------
  _s_: status       _a_: stageta kaikki muutokset
  _i_: init         _f_: stageta tietty tiedosto
  _o_: checkout     _c_: commitoi muutokset
  ^^                _pl_: pullaa branchista
  ^^                _psh_: pushaa Githubiin tms
  "
      ("s" magit-status)
      ("i" magit-init)
      ("o" magit-checkout)
      ("a" magit-stage-modified)
      ("f" magit-stage-file)
      ("c" magit-commit)
      ("pl" magit-pull-from-upstream)
      ("psh" magit-push-current-to-upstream)
      ("q" nil "peruuta" :color blue))
  (defhydra shell-hydra (:color pink :hint nil)
        "
    ^Terminaalit^     ^Tulkit^
    ------------------------------------------------
    _e_: Eshell       _p_: iPython
    _t_: iTerm        _r_: R
    "
        ("e" eshell :exit t)
        ("t" term :exit t)
        ("p" ipython3 :exit t)
        ("r" R :exit t)
        ("q" nil "peruuta" :color blue))
  
  (defhydra skrollaus-hydra (:color pink :hint nil)
      "
  Skrollaa^
  ----------------
  _j_: alas   _k_: ylös
  "
      ("j" evil-scroll-down)
      ("k" evil-scroll-up)
      ("c" nil "peruuta" :color blue))
  (defhydra org-meta-hydra (:color pink :hint nil)
        "
    Liiku
    -----
    _j_: alas
    _k_: ylös
    _r_: aja koodi
    "
        ("j" org-metadown)
        ("k" org-metaup)
        ("r" org-ctrl-c-ctrl-c)
        ("q" nil "exit" :color blue))
  (defhydra helm-projektiili-hydra (:color pink :hint nil :exit t)
        "
    Projektien hallinta
    -------------------
    _p_: etsi projekti
    _f_: etsi tiedosto
    _g_: etsi tiettyä regexiä
    "
        ("p" helm-projectile-switch-project)
        ("f" helm-projectile-find-file)
        ("g" helm-projectile-grep)
        ("q" nil "exit" :color blue)
        )
  (defhydra python-projekti-hydra (:color pink :hint nil)
      "
  ^Virtuaaliympäristö
  -------------------------------
  _v_: valitse ympäristö
  _a_: aktivoi projektiin sidottu
  _d_: deaktivoi nykyinen
  _c_: luo uusi ympäristö
  "
      ("v" valitse-virtuaaliympäristö)
      ("a" pyvenv-activate)
      ("d" pyvenv-deactivate)
      ("c" pyvenv-create)
      ("q" nil "exit" :color blue))

  )

(defhydra skrollaus-hydra (:color pink :hint nil)
    "
Skrollaa^
----------------
_j_: alas   _k_: ylös
"
    ("j" evil-scroll-down)
    ("k" evil-scroll-up)
    ("c" nil "peruuta" :color blue))

(use-package smartparens
  :ensure t

  :config

  (smartparens-global-mode 1)

  ;; Chris Allenille kredit tästä
  ;; Poista Lisp-moodeilta '-merkin ja `-merkin käyttö
  ;; pareina, joiden vastine luodaan automaattisesti
  (sp-with-modes sp--lisp-modes
    (sp-local-pair "'" nil :actions nil) ; disable ', it's the quote character!
    (sp-local-pair "`" "'" :when '(sp-in-string-p))) ; also only use the pseudo-quote inside strings where it serve as a hyperlink

  (sp-with-modes '(org-mode)
    (sp-local-pair "$" "$")
    (sp-local-pair "$$" "$$"))

  (sp-with-modes '(python-mode)
    (sp-local-pair "\"\"\"" "\"\"\"")
    (sp-local-pair "np.array([" "])" :trigger "np.array"))

  (sp-with-modes '(sql-mode)
    (sp-local-pair "/*" "*/")
    (sp-local-pair "case" "end" :trigger "case"))

  (sp-with-modes '(c-mode c++-mode)
    (sp-local-pair "/*" "*/"))

)

(use-package key-chord
  :ensure t
  :init

  (defun evaluoi-ja-tallenna-tulos-leikepöydälle
      (ssexp)
    (interactive "P")
    (thread-first ssexp
      (eval-last-sexp)
      (string)
      (kill-new)
      ))

  :config

  (key-chord-mode 1)

  (key-chord-define-global "eö" 'end-of-line)
  (key-chord-define-global "öa" (lambda (x) (interactive "P")
				  (progn (insert "[]") (backward-char))))
  (key-chord-define-global "äa" (lambda (x) (interactive "P")
				  (progn (insert "{}") (backward-char))))

  ;; Hydrat
  (key-chord-define-global "zx" 'skrollaus-hydra/body)

  ;; org-mode
  (key-chord-define org-mode-map "yu" 'org-meta-hydra/body)

  ;; R:n lokaalit
  (key-chord-define ess-mode-map ",," (kirjoita " <- "))
  (key-chord-define ess-mode-map "yu" (kirjoita " %>% "))
  )

(use-package swiper
  :ensure t)

(use-package yasnippet
  :ensure t
  :init
  (add-to-list 'warning-suppress-types '(yasnippet backquote-change))
)

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (use-package helm-projectile
    :ensure t
    :config
    )
  (helm-projectile-on)
  )

(use-package org
  :ensure t
  :init

  ;; Tuetut
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ipython . t)
     (R . t)
     (sqlite . t)
     (C . t)
     (java . t)
     (prolog . t)
     (latex . t)
     (matlab . t)
     (haskell . t)
     (emacs-lisp . t)
     (js . t)))
  )

(use-package python-mode
  :ensure t
  :custom (elpy-rpc-backend "jedi")
  :init
  (use-package anaconda-mode
    :ensure t)
  (use-package pyvenv
    :ensure t
    :config
    (setq virtuaaliympäristöjen-sijoituspaikka "/Applications/anaconda3/envs")
    (setenv "WORKON_HOME" virtuaaliympäristöjen-sijoituspaikka)
    (defun valitse-virtuaaliympäristö ()
      (interactive)
      (ido-completing-read "Valitse ympäristö: " (pyvenv-virtualenv-list)))
    )
  :config
  (elpy-enable)
  ;; (virtualenv-minor-mode 1)
  (pyvenv-mode 1)
    )

(use-package ess
  :ensure t
  ;; :defer t ;; Pidä tässä kunnes keksit keinon toimia lokaalien key-chordien kanssa

  :init
  (setq ess-use-auto-complete t)
  (setq ess-first-tab-never-complete 'unless-eol)
  (setq-default inferior-R-program-name "/usr/local/bin/R")
  (add-hook 'inferior-ess-mode-hook 'aseta-comint-liikkeet)
  (defun my-ess-hook ()
    ;; ensure company-R-library is in ESS backends
    (make-local-variable 'company-backends)
    (cl-delete-if (lambda (x) (and (eq (car-safe x) 'company-R-args))) company-backends)
    (push (list 'company-R-args 'company-R-objects 'company-R-library :separate
		company-backends)))

  :hook my-ess-hook 

  )

(use-package lsp-mode
  :defer t
  ;; :hook (python-mode . lsp)
  ;; :commands lsp
  )

(use-package edbi
  :ensure t
  )

(use-package emacsql
  :ensure t
  :defer t

  :init
  (use-package emacsql-sqlite
    :ensure t
    :defer t
    :init
    (require 'emacsql)
    (require 'emacsql-sqlite)
    (defvar tietokanta-polku "/Users/tommi/Tietokannat/")
    (defun tietokanta-yhteys (filu) (emacsql-sqlite (concat tietokanta-polku filu)))
    (setq db-formula1 (tietokanta-yhteys "formula1.db"))
    (setq db-jargon (tietokanta-yhteys "jargon.db"))
    )
  )

(use-package md4rd :ensure t
  :config
  (add-hook 'md4rd-mode-hook 'md4rd-indent-all-the-lines)
  (setq md4rd-subs-active '(emacs lisp+Common_Lisp prolog clojure))
  (setq md4rd--oauth-access-token
	reddit-tokeni-client-id)
  (setq md4rd--oauth-refresh-token
	reddit-tokeni-secret-id)
  (run-with-timer 0 3540 'md4rd-refresh-login))


