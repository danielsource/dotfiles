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
      use-dialog-box nil
      compilation-ask-about-save nil
      compilation-scroll-output t
      disabled-command-function nil
      completion-show-help nil
      read-file-name-completion-ignore-case t
      confirm-nonexistent-file-or-buffer nil
      vc-follow-symlinks t
      history-length 1000
      dired-listing-switches "-alB --group-directories-first"
      inferior-lisp-program "sbcl"
      revert-without-query '(".*\\.tga")
      compile-command nil)

(setq-default tab-4 width
              indent-tabs-mode nil
              c-basic-offset 4
              tab-always-indent 'complete)

(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'visual)

(blink-cursor-mode -1)
(ffap-bindings)
(windmove-default-keybindings 'shift)
(windmove-swap-states-default-keybindings '(ctrl shift))

(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-use-filename-at-point 'guess
      ido-create-new-buffer 'always
      ido-use-url-at-point t)
(ido-mode 1)

(add-hook 'dired-mode-hook
          (lambda ()
            (when (bound-and-true-p ido-use-filename-at-point)
              (setq-local ido-use-filename-at-point nil))))
(add-hook 'before-save-hook
          #'delete-trailing-whitespace)
(add-hook 'before-save-hook
          (lambda () (setq-local imenu--index-alist nil)))
(add-hook 'server-after-make-frame-hook
          (lambda () (select-frame-set-input-focus (selected-frame))))

(defun kill-not-visible-buffers ()
  (interactive)
  (let ((visible-buffers (mapcar 'window-buffer (window-list))))
    (mapc (lambda (buf)
            (unless (or (eq buf (current-buffer))
                        (member buf visible-buffers))
              (kill-buffer buf)))
          (buffer-list))))

(defun delete-line ()
  "Delete whole line without modifying the kill ring."
  (interactive)
  (if (save-excursion
        (move-end-of-line 1)
        (eobp))
      (progn
        (delete-region (point-at-bol) (point-at-eol))
        (error "End of buffer")))
  (next-line)
  (save-excursion
    (previous-line)
    (delete-region (point-at-bol) (point-at-eol))
    (delete-char 1)))

(define-globalized-minor-mode global-dired-hide-details-mode dired-hide-details-mode
  dired-hide-details-mode
  :predicate '(dired-mode)
  :group 'dired)

(global-set-key (kbd "<f1>") 'execute-extended-command)
(global-set-key (kbd "<f2>") (lookup-key global-map (kbd "C-x C-f")))
(global-set-key (kbd "<f3>") 'compile)
(global-set-key (kbd "<f4>") 'recompile)
(global-set-key (kbd "<f5>") 'windmove-left)
(global-set-key (kbd "<f6>") 'windmove-down)
(global-set-key (kbd "<f7>") 'windmove-up)
(global-set-key (kbd "<f8>") 'windmove-right)
(global-set-key (kbd "S-<f5>") 'windmove-swap-states-left)
(global-set-key (kbd "S-<f6>") 'windmove-swap-states-down)
(global-set-key (kbd "S-<f7>") 'windmove-swap-states-up)
(global-set-key (kbd "S-<f8>") 'windmove-swap-states-right)
(global-set-key (kbd "<f9>") (lookup-key global-map (kbd "C-x b")))
(global-set-key (kbd "C-c f") 'find-name-dired)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-c a k") 'kill-not-visible-buffers)
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
(global-set-key (kbd "M-- M--") 'other-tab-prefix)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "C-,") 'duplicate-dwim)
(global-set-key (kbd "C-.") 'delete-line)
(global-set-key (kbd "C-;") 'dabbrev-expand)
(global-set-key (kbd "C-M-;") 'join-line)

(require 'dired)
(define-key dired-mode-map (kbd "(") 'global-dired-hide-details-mode)
(define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
