(load-theme 'modus-operandi)

(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(set-language-environment "UTF-8")

(setq inhibit-startup-screen t
      initial-scratch-message ""
      use-short-answers t
      ring-bell-function 'ignore
      compilation-ask-about-save nil
      disabled-command-function nil
      make-backup-files nil
      tab-always-indent 'complete)

(setq-default cursor-type 'bar
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

(if (eq system-type 'windows-nt)
    (progn (require 'grep)
           (setq shell-file-name "cmdproxy.exe")
           (grep-apply-setting 'grep-command "findstr -n -s -i ")
           (set-frame-font "Consolas 10" nil t))
  (add-to-list 'default-frame-alist '(font . "monospace-9")))

(require 'ido)
(ido-mode t)

(setq history-length 1000)
(savehist-mode t)

(show-paren-mode -1)
(column-number-mode t)
(delete-selection-mode t)

(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "C-c s") 'sort-lines)
(global-set-key (kbd "C-c w") 'whitespace-cleanup)
(global-set-key (kbd "C-c $") 'toggle-truncate-lines)
(global-set-key (kbd "C-j") 'join-line)
(global-set-key (kbd "C-x m") 'man)
(global-set-key (kbd "M-o") 'other-window)
