; Put this in your .emacs


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)

(require 'org-install)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . true) (python . true)) 
)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))
(setq org-ellipsis "⤵")

(global-unset-key (kbd "M-<down-mouse-1>")) (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

;可以将 todo list 的状态增加为五种：TODO，DOING，HANGUP，DONE，CANCEL。
;注意，在 HANGUP 和 DONE 之间有一条竖线 “|”，在竖线之前的状态和之后的状态使用的是不同的face。
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "HANGUP" "|" "DONE" "CANCEL")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(font-use-system-font t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   (quote
    (multi-term mc-extras pinyin-search pinyin pyim bing-dict ace-pinyin egg e2wm-R yatemplate poly-R ess-view ess-R-data-view ac-mozc markdownfmt markdown-toc markdown-preview-mode markdown-preview-eww markdown-mode+ mkdown ox-hugo auto-complete org-ac))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono CJK JP" :foundry "GOOG" :slant normal :weight normal :height 98 :width normal)))))

 ; hide password when typing

(add-hook 'shell-mode-hook
          #'(lambda ()
              (setq comint-password-prompt-regexp
                    (replace-regexp-in-string "for \\[\\^.+?\\]\\+" "for .+"
                                              comint-password-prompt-regexp t t))))

; automatically get the correct mode 
;auto-mode-alist (append (list '("\\.c$" . c-mode)
;			      '("\\.tex$" . latex-mode)
;			      '("\\.S$" . S-mode)
;			      '("\\.s$" . S-mode)
;			      '("\\.R$" . R-mode)
;			      '("\\.r$" . R-mode)
;			      '("\\.html$" . html-mode)
 ;                             '("\\.emacs" . emacs-lisp-mode)
;	                )
;		      auto-mode-alist)
; comment out the following if you are not using R/S-Plus on ACPUB
; add a ";" in front of each line 
;(load "/usr/pkg/ess/lisp/ess-site")
;(setq-default inferior-S+6-program-name "Splus")
;(setq-default inferior-R-program-name "R")

;; -- for ess-mode
(setq auto-mode-alist
      (append '(("\\.r$" . R-mode)
 		("\\.R$" . R-mode)
 		) auto-mode-alist))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(add-hook 'ess-mode-hook
 	  '(lambda ()
 	     (define-key ess-mode-map [f1] 'ess-help)
 	     (define-key ess-mode-map [f5] 'ess-eval-buffer)
 	     (define-key ess-mode-map [f7] 'ess-eval-region-or-function-or-paragraph-and-step)
 	     ))

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  (setq load-path 
    (append (list "path/to/polymode/" "path/to/polymode/modes/")
        load-path))
  (require 'poly-R)
  (require 'poly-markdown)     
  (poly-markdown+r-mode))

; make all org file started with indent format
(setq org-startup-indented t)

(add-hook 'ess-noweb-mode-hook 'my-noweb-hook)

(defun my-noweb-hook ()
  (define-key ess-noweb-mode-prefix-map "b"
    #'(lambda () (interactive) (TeX-command "BibTeX" 'TeX-master-file)))
  (define-key ess-noweb-mode-prefix-map "P"
    #'(lambda () (interactive)
        (ess-swv-PDF "texi2pdf"))))
