(set-language-environment "UTF-8")

(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(height . 28))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
        (write-region "" nil custom-file))
(load custom-file nil t)

(if (not custom-enabled-themes)
    (load-theme 'modus-vivendi t))

(setq inhibit-startup-screen t
      initial-scratch-message ""
      ring-bell-function 'ignore
      tab-always-indent 'complete
      compilation-ask-about-save nil
      compilation-scroll-output t
      disabled-command-function nil
      completion-show-help nil
      read-file-name-completion-ignore-case t
      dired-listing-switches "-al --group-directories-first"
      global-auto-revert-non-file-buffers t
      vc-follow-symlinks t
      history-length 1000
      inferior-lisp-program "sbcl")

(setq-default tab-width 4
              indent-tabs-mode nil
              c-basic-offset 4)
(setq-default confirm-nonexistent-file-or-buffer nil)

(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(blink-cursor-mode -1)
(ffap-bindings)
(windmove-default-keybindings 'shift)
(windmove-swap-states-default-keybindings '(ctrl shift))

(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-use-filename-at-point 'guess
      ido-create-new-buffer 'always)
(ido-mode 1)

(add-hook 'before-save-hook
          #'delete-trailing-whitespace)
(add-hook 'server-after-make-frame-hook
          (lambda () (select-frame-set-input-focus (selected-frame))))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(global-set-key (kbd "<f1>") 'save-buffer)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "<f8>") (lookup-key global-map (kbd "C-x b")))
(global-set-key (kbd "<f9>") 'imenu)
(global-set-key (kbd "C-c f") 'find-name-dired)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-c a k") 'kill-other-buffers)
(global-set-key (kbd "C-x m") 'man)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-O") 'previous-window-any-frame)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-4") (lookup-key global-map (kbd "C-x 4")))
(global-set-key (kbd "M-5") (lookup-key global-map (kbd "C-x 5")))
(global-set-key (kbd "M--") (lookup-key global-map (kbd "C-x t")))
(global-set-key (kbd "M-- -") 'other-tab-prefix)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "C-,") 'duplicate-dwim)
