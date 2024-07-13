(set-language-environment "UTF-8")

(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(dolist (package '(slime zenburn-theme))
  (unless (package-installed-p package)
    (package-install package)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file nil t)

(if (not custom-enabled-themes)
    (load-theme 'zenburn t))

(setq-default cursor-type 'bar)
(setq inhibit-startup-screen t
      initial-scratch-message ""
      tab-always-indent 'complete
      disabled-command-function nil
      read-file-name-completion-ignore-case t
      dired-listing-switches "-al --group-directories-first"
      global-auto-revert-non-file-buffers t
      vc-follow-symlinks t
      history-length 1000
      inferior-lisp-program "sbcl")

(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)

(add-hook 'before-save-hook
	  #'delete-trailing-whitespace)
(add-hook 'server-after-make-frame-hook
	  (lambda () (select-frame-set-input-focus (selected-frame))))

(global-set-key (kbd "C-c f") 'find-name-dired)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-O") 'previous-window-any-frame)
