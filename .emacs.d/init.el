;;; init.el --- daniel.source's basic Emacs configuration

;;; Commentary:

;; This file is part of daniel.source's dotfiles repository available
;; at https://github.com/danielsource/dotfiles.

;; Functions and variables defined here are prefixed with 'd/'.

;;; Code:

;;
;; Setup my theme
;;

(defun d/load-theme (theme)
  "Load Custom theme named THEME if it exists.

Return t if THEME was successfully loaded, nil otherwise."
  (let ((file
	 (locate-file (concat (symbol-name theme) "-theme.el")
		      `(,(expand-file-name "themes" data-directory) custom-theme-directory t))))
    (if file
	(load-theme theme t))))

(if (not custom-enabled-themes)
    (d/load-theme 'modus-vivendi))

;; theme ends here

;; Disable menu-bar, tool-bar, and scroll-bar
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq inhibit-startup-screen t
      initial-scratch-message ""
      disabled-command-function nil  ; Enable all disabled commands.
      compilation-ask-about-save nil ; Auto save when compiling.
      history-length 1000)	     ; Change minibuffer history length.

(fset 'yes-or-no-p 'y-or-n-p) ; y or n makes answering questions faster

;; Setup Dired and hide details
(add-hook 'dired-mode-hook
	  (lambda ()
            (dired-hide-details-mode 1)))
(setq dired-hide-details-hide-symlink-targets nil
      dired-listing-switches "-alF --group-directories-first")

;; Delete trailing white space on save
(add-hook 'before-save-hook
	  'delete-trailing-whitespace)

(column-number-mode 1)
(delete-selection-mode 1)
(winner-mode 1)	; Undo/redo window layouts

;; Auto pair parentheses, braces, quotes, etc.
(electric-pair-mode)
(setq electric-pair-preserve-balance nil)

;; Auto-update buffer if file has changed on disk.
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t) ; Revert Dired and other buffers

;; Save what you enter into minibuffer prompts
(savehist-mode 1)

;; Remember recently edited files
(recentf-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Enable built-in tab completion
(setq tab-always-indent 'complete)

;; Be case sensitive when using dabbrev
(setq dabbrev-case-fold-search nil)

;; Offload the `custom-set-variables' to a separate file
(setq custom-file (locate-user-emacs-file "custom.el"))
(unless (file-exists-p custom-file)
  (with-temp-file custom-file))
(load custom-file nil t)

;; Put backup files in one directory
(defvar d/backup-directory (locate-user-emacs-file "backups"))
(setq backup-directory-alist `(("." . ,d/backup-directory)))
(make-directory d/backup-directory t)

(defun d/reload-config ()
  (interactive)
  (load-file (locate-user-emacs-file "init.el")))

(defun d/format-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;;
;; Setup C Linux coding style
;; https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it
;;

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
	    (setq indent-tabs-mode t)
            (setq show-trailing-whitespace t)
            (c-set-style "linux-tabs-only")))

;; C ends here

;;
;; Spell checking
;;

(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "en_US,pt_BR")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic ispell-dictionary))

;;
;; General keybindings
;;

(ffap-bindings)
(global-set-key (kbd "<f12>") 'd/reload-config)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "<f9>") 'imenu)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c f") 'find-name-dired)
(global-set-key (kbd "C-c i") 'd/format-buffer)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-c s") 'sort-lines)
(global-set-key (kbd "C-x m") 'man)
(global-set-key (kbd "C-ç") 'xref-find-references)

;;; init.el ends here
