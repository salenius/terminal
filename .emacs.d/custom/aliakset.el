;; Emacsin Alias-kokoelma
;; Author: Tommi Salenius
;; Created: Ti, 29.5.2018
;; License: GPL (2018)

;; Eri modet

(defalias 'o 'org-mode)
(defalias 'r 'R)
(defalias 'py 'python-mode)
(defalias 'yn 'yas-new-snippet)
(defalias 'kb 'kill-this-buffer)

;; Hae tiedostoja

(defalias 'in (lambda() (interactive)(find-file "/Users/tommi/.emacs.d/init.el")))
(defalias 'al (lambda() (interactive)(find-file "/Users/tommi/.emacs.d/custom/aliakset.el")))
