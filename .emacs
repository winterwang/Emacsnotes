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
;; 设置bullet list
(setq org-bullets-bullet-list '("☰" "☷" "☯" "☭"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" "bd51a329aa9b8e29c6cf2c8a8cf136e0d2960947dfa5c1f82b29c9178ad89a27" default)))
 '(display-time-mode t)
 '(font-use-system-font t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   (quote
    (magit auctex-latexmk auctex ace-window ack 2048-game circadian farmhouse-theme use-package ess afternoon-theme forest-blue-theme multi-term mc-extras pinyin-search pinyin pyim bing-dict ace-pinyin egg e2wm-R yatemplate poly-R ess-view ess-R-data-view ac-mozc markdownfmt markdown-toc markdown-preview-mode markdown-preview-eww markdown-mode+ mkdown ox-hugo auto-complete org-ac))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono CJK SC" :foundry "GOOG" :slant normal :weight normal :height 128 :width normal)))))

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
;; ---------------------------------------------------------
;; auto-complete の設定
;; ---------------------------------------------------------
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.2) ; 補完リストが表示されるまでの時間
(define-key ac-completing-map (kbd "C-n") 'ac-next)      ; C-n で次候補選択
(define-key ac-completing-map (kbd "C-p") 'ac-previous)  ; C-p で前候補選択
;; ファイルパスの補完
(global-set-key [(alt tab)] 'ac-complete-filename)
(setq ac-dwim t)  ; 空気読んでほしい
;; 情報源として
;; * ac-source-filename
;; * ac-source-words-in-same-mode-buffers
;; を利用
(setq-default ac-sources '(ac-source-filename
                           ac-source-words-in-same-mode-buffers
                           ac-source-yasnippet))

(setq ac-auto-start 3);; 補完を開始する文字数

;; 色
(set-face-background 'ac-completion-face "#333333")
(set-face-foreground 'ac-candidate-face "black")
(set-face-background 'ac-selection-face "#666666")
(set-face-foreground 'popup-summary-face "black")  ;; 候補のサマリー部分
(set-face-background 'popup-tip-face "#ffffd8")  ;; ドキュメント部分
(set-face-foreground 'popup-tip-face "black")

;; ---------------------------------------------------------
;; ESS の設定
;; ---------------------------------------------------------
(require 'ess-site)

;R 関連--------------------------------------------
;; パスの追加
(add-to-list 'load-path "~/.emacs.d/elpa")

;; 拡張子が r, R の場合に R-mode を起動
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))

;; R-mode を起動する時に ess-site をロード
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)

;; R を起動する時に ess-site をロード
(autoload 'R "ess-site" "start R" t)


;; R-mode, iESS を起動する際に呼び出す初期化関数
(setq ess-loaded-p nil)
(defun ess-load-hook (&optional from-iess-p)
  ;; インデントの幅を 2 にする（デフォルト 2）
  (setq ess-indent-level 2)
  ;; インデントを調整
  (setq ess-arg-function-offset-new-line (list ess-indent-level))
  ;; comment-region のコメントアウトに # を使う（デフォルト##）
  (make-variable-buffer-local 'comment-add)
  (setq comment-add 0)

  ;; 最初に ESS を呼び出した時の処理
  (when (not ess-loaded-p)
    ;; 補完機能を有効にする
    (setq ess-use-auto-complete t)
    ;; helm を使いたいので IDO は邪魔
    (setq ess-use-ido nil)
    ;; キャレットがシンボル上にある場合にもエコーエリアにヘルプを表示する
    (setq ess-eldoc-show-on-symbol t)
    ;; 起動時にワーキングディレクトリを尋ねられないようにする
    (setq ess-ask-for-ess-directory nil)
    ;; # の数によってコメントのインデントの挙動が変わるのを無効にする
    (setq ess-fancy-comments nil)
    (setq ess-loaded-p t)
    (unless from-iess-p
      ;; ウィンドウが 1 つの状態で *.R を開いた場合はウィンドウを横に分割して R を表示する
      (when (one-window-p)
        (split-window-below)
        (let ((buf (current-buffer)))
          (ess-switch-to-ESS nil)
          (switch-to-buffer-other-window buf)))
      ;; R を起動する前だと auto-complete-mode が off になるので自前で on にする
      ;; cf. ess.el の ess-load-extras
      (when (and ess-use-auto-complete (require 'auto-complete nil t))
        (add-to-list 'ac-modes 'ess-mode)
        (mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
                '(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
        ;; auto-complete のソースを追加
        (setq ac-sources '(ac-source-acr
                           ac-source-R
                           ac-source-filename
                           ac-source-yasnippet)))))

  (if from-iess-p
      ;; R のプロセスが他になければウィンドウを分割する
      (if (> (length ess-process-name-list) 0)
          (when (one-window-p)
            (split-window-horizontally)
            (other-window 1)))
    ;; *.R と R のプロセスを結びつける
    ;; これをしておかないと補完などの便利な機能が使えない
    (ess-force-buffer-current "Process to load into: ")))

;; R-mode 起動直後の処理
(add-hook 'R-mode-hook 'ess-load-hook)

;; R 起動直前の処理
(defun ess-pre-run-hooks ()
  (ess-load-hook t))
(add-hook 'ess-pre-run-hook 'ess-pre-run-hooks)

;; auto-complete-acr
;(require 'auto-complete-acr)

;; e2wm-R
(require 'e2wm-R)

;; e2wm:dp-R-view, e2wm:stop-management を toggleis する
(defun e2wm:toggle-management ()
  (interactive)
  (if (e2wm:pst-get-instance)
      (e2wm:stop-management) (e2wm:dp-R-view)))
(define-key ess-mode-map (kbd "C-,") 'e2wm:toggle-management)

;(load-theme 'ample-zen t)
; enable math in markdown files
(setq markdown-enable-math t)
; auto pair
;; (defun autopair-insert-opening ()
;;      (interactive)
;;      (when (autopair-pair-p)
;;        (setq autopair-action (list 'opening (autopair-find-pair) (point))))
;;      (autopair-fallback))


;; ;; チャンク挿入
;; (defun tws-insert-r-chunk (header)
;;   "Insert an r-chunk in markdown mode.
;; Necessary due to interactions between polymode and yas snippet"
;;   (interactive "sHeader: ")
;;   (insert (concat "```{r " header "}\n\n```"))
;;   (forward-line -1))

;; (define-key poly-markdown+r-mode-map (kbd "M-n M-r") 'tws-insert-r-chunk)

;; (defun tws-insert-py-chunk (header)
;;   "Insert a python-chunk in markdown mode.
;; Necessary due to interactions between polymode and yas snippet"
;;   (interactive "sHeader: ")
;;   (insert (concat "```{python " header "}\n\n```"))
;;   (forward-line -1))

;; (define-key poly-markdown+r-mode-map (kbd "M-n M-p") 'tws-insert-py-chunk)

;; (defun tws-insert-norm-chunk (header)
;;   "Insert a chunk in markdown mode.
;; Necessary due to interactions between polymode and yas snippet"
;;   (interactive "sHeader: ")
;;   (insert (concat "```{" header "}\n\n```"))
;;   (forward-line -1))

;; (define-key poly-markdown+r-mode-map (kbd "M-n M-c") 'tws-insert-norm-chunk)

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
; load theme on startup
;(load-theme 'afternoon t)		

; load markdown preview
(autoload 'markdown-preview-mode "markdown-preview-mode.el" t)

;; markdown-mode
;; m-x package-list-package, install markdown-mode | once
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.Rmd" . markdown-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (append '(("\\.md$" . yatex-mode)
;;                 ("\\.txt$" . yatex-mode)) auto-mode-alist))


;; Install additinal themes from melpa
;; make sure to use :defer keyword
;; Install additinal themes from melpa
;; make sure to use :defer keyword
(require 'use-package)
(use-package farmhouse-theme :ensure :defer)
;(use-package nyx-theme :ensure :defer)	;

(use-package circadian
  :ensure t
  :config
  (setq circadian-themes '(("8:00" . farmhouse-light)
                           ("19:30" . farmhouse-dark)))
  (circadian-setup))

; turn on pair mode 
(electric-pair-mode 1)

; use C-; to insert assign arrows like R
(global-set-key (kbd "C--")  (lambda () (interactive) (insert " <- ")))
;(ess-toggle-underscore nil)

; display the math upon saving in ogr-mode
(defun my/org-render-latex-fragments ()
  (if (org--list-latex-overlays)
      (progn (org-toggle-latex-fragment)
             (org-toggle-latex-fragment))
    (org-toggle-latex-fragment)))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'my/org-render-latex-fragments 'make-it-local)))
; wrap the lines
(global-visual-line-mode t)

;; custom binding for magit-status
(use-package magit
  :config
  (global-set-key (kbd "C-c m") 'magit-status))
