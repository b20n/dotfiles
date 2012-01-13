;; Hide the splash screen
(setq inhibit-splash-screen t)
;; Force utf-8 on slime
(setq slime-net-coding-system 'utf-8-unix)
;; Always show column numbers
(setq column-number-mode t)

(progn
  ;; Hide the toolbar
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  ;; Hide the menubar
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  ;; Hide the scrollbar
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1)))

;; Configure load paths
(add-to-list 'load-path "~/.emacs.d")
(let ((default-directory "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;; Color themes
(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

;; Always use spaces for indentation
(setq-default indent-tabs-mode nil)
;; Default to 2-space tabs
(setq-default tab-width 2)


;; I use version control, don't annoy me with backup files everywhere
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Allow single-char yes/no responses
(fset 'yes-or-no-p 'y-or-n-p)

;; Uniqify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(defun my-backward-kill-word ()
  "Kill words backward my way."
  (interactive)
  (if (bolp)
      (backward-delete-char 1)
    (if (string-match "^\\s-+$" (buffer-substring (point-at-bol) (point)))
        (kill-region (point-at-bol) (point))
      (backward-kill-word 1))))

;; Replace m-x with C-x C-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'my-backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

;; Hotkey for commenting regions
(global-set-key (kbd "C-x C-;") 'comment-or-uncomment-region)

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-save-directory-list-file "~/.emacs.d/ido.cache")
(ido-mode t)


(put 'erase-buffer 'disabled nil)

;; Don't let files end without a newline
(setq-default require-final-newline t)

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

(delete-selection-mode 1) ;; DEL actually deletes regions

(setq initial-scratch-message
      ";; happy hacking!\n")

;; key board / input method settings
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")       ; prefer utf-8 for language settings
(set-input-method nil)                   ; no funky input for normal editing;
(setq read-quoted-char-radix 10)         ; use decimal, not octal

(require 'whitespace)
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 10 [182 10])
        (tab-mark 9 [8677 9] [92 9])))
(setq whitespace-style '(face spaces tabs space-mark
                              tab-mark trailing lines-tail
                              indentation::space))
(global-whitespace-mode 1)

;; Integrate terminal emacs with OSX pasteboard
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;;;;;;;;;;;;;;;;;
;; Major modes ;;
;;;;;;;;;;;;;;;;;

(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj" . clojure-mode))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'actionscript-mode)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

(add-to-list 'load-path "~/.emacs.d/scala")
(require 'scala-mode-auto)

(require 'coffee-mode)

;; Erlang!
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.6.5/emacs"
                      load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;; Haskell!
(load "~/.emacs.d/haskell/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))


(add-hook 'python-mode-hook
  (lambda () (setq tab-width 4)))

(add-hook 'sh-mode-hook
  (lambda () (setq sh-basic-offset 2
                   sh-indentation 2)))
