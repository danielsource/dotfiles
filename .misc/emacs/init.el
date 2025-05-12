;; Theme
(setq modus-operandi-tinted-palette-overrides
      '((bg-main "#f7f1e3")
        (bg-dim "#e8dbcc")
        (bg-mode-line-active "#bfefff")))
(load-theme 'modus-operandi-tinted t)
;; Different theme at night:
(run-at-time "21:00" (* 60 60 24)
             (lambda () (modus-themes-select 'modus-vivendi)))

;; Remove useless GUI stuff
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; Set UTF-8 in case it is not already set
(set-language-environment "UTF-8")

;; Load Emacs X Window Manager if it is installed
(let ((exwm-file (expand-file-name "exwm.el" user-emacs-directory)))
  (and (package-installed-p 'exwm)
       (file-exists-p exwm-file)
       (load exwm-file nil t)))

;; Simulation of the Vim equivalent "set ts=4 sw=4 et"
(defvar d/tabstop 4)
(defvar d/expandtab t)
(setq-default c-basic-offset d/tabstop
              sh-basic-offset d/tabstop
              tab-width d/tabstop
              indent-tabs-mode (not d/expandtab))

(defvar d/compilation-font-scale 0)

;; Basic settings
(setq inhibit-startup-screen t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      use-short-answers t
      ring-bell-function 'ignore
      scroll-conservatively 101
      compilation-ask-about-save nil
      compilation-scroll-output t
      disabled-command-function nil
      tab-always-indent 'complete
      display-line-numbers-type 'relative
      display-line-numbers-grow-only t
      create-lockfiles nil
      history-length 1000)

;; ==== FUNCTIONS ====
;; The prefix "d/" indicates that these functions are from here.

(defun d/at-emacs-dir (path)
  "Ensure a file or directory exists at PATH relative to
`user-emacs-directory'. Creates directories as needed, and
returns the absolute path."
  (let ((expanded (expand-file-name path user-emacs-directory)))
    (unless (file-exists-p expanded)
      (if (string-suffix-p "/" path)
          (make-directory expanded t)
        (make-directory (file-name-directory expanded) t)
        (write-region "" nil expanded)))
    expanded))

(defun d/duplicate-line ()
  (interactive)
  (save-excursion
    (let ((line (buffer-substring
                 (line-beginning-position)
                 (line-end-position))))
      (end-of-line)
      (newline)
      (insert line))))

(defun d/insert-timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M %Z")))

(defun d/put-buffer-name-on-clipboard ()
  (interactive)
  (kill-new (buffer-name))
  (message (buffer-name)))

(defun d/put-file-name-on-clipboard ()
  (interactive)
  (let ((file-name (expand-file-name
                    (cond ((buffer-file-name))
                          (default-directory)))))
    (kill-new file-name)
    (message file-name)))

(defun d/set-compilation-scroll ()
  (interactive)
  (let ((opt (yes-or-no-p "compilation-scroll-output: ")))
    (if opt
        (setq compilation-scroll-output t)
      (setq compilation-scroll-output
            (if (yes-or-no-p "On first error?")
                'first-error
              nil)))))

(defun d/set-compilation-font-scale ()
  (interactive)
  (setq d/compilation-font-scale (read-number "d/compilation-font-scale: " -1)))

(defun d/revert-buffer ()
  (interactive)
  (revert-buffer nil t))

(defun d/other-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

;; ==== END FUNCTIONS ====

;; A saner file backup in ~/.emacs.d/ to avoid cluttering directories
(setq auto-save-file-name-transforms `((".*" ,auto-save-list-file-prefix t))
      backup-directory-alist `((".*" . ,(d/at-emacs-dir "backup/")))
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2
      version-control t)

;; If on Windows...
(when (eq system-type 'windows-nt)
  (require 'grep)
  (setq shell-file-name "cmdproxy.exe")
  (grep-apply-setting 'grep-command "findstr -n -s -i ")
  (set-frame-font "Consolas 10" nil t))

;; Delete useless space on save
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(add-hook 'prog-mode-hook
          (lambda ()
            (setq case-fold-search nil)))

;; Smaller font in the compilation buffer
(add-hook 'compilation-mode-hook
          (lambda ()
            (text-scale-adjust d/compilation-font-scale)))

;; Enable fast completion in the minibuffer
(require 'ido)
(ido-everywhere)

;; Save a list of recently opened files
(recentf-mode t)
(setq recentf-max-menu-items recentf-max-saved-items)

(savehist-mode t)                    ; Save minibuffer history
(column-number-mode t)               ; Show columns in the mode line
(delete-selection-mode t)
(windmove-default-keybindings 'meta) ; Enable basic "pane" movement with Alt/Ctrl
(windmove-swap-states-default-keybindings 'control)
(blink-cursor-mode -1)

;; Keyboard shortcuts
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c n") 'global-display-line-numbers-mode)
(global-set-key (kbd "C-c s") 'sort-lines)
(global-set-key (kbd "C-c $") 'toggle-truncate-lines)
(global-set-key (kbd "C-c f") 'find-file-at-point)
(global-set-key (kbd "C-c m") 'imenu)
(global-set-key (kbd "C-c =") 'describe-char)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-x m") 'man)
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)
(global-set-key (kbd "C-,") 'd/duplicate-line)
(global-set-key (kbd "C-c k s") 'd/set-compilation-scroll)
(global-set-key (kbd "C-c k z") 'd/set-compilation-font-scale)
(global-set-key (kbd "C-c i t") 'd/insert-timestamp)
(global-set-key (kbd "C-c p n") 'd/put-buffer-name-on-clipboard)
(global-set-key (kbd "C-c p f") 'd/put-file-name-on-clipboard)
(global-set-key (kbd "C-c R") 'd/revert-buffer)
(global-set-key (kbd "<f9>") 'd/other-buffer)
(global-set-key (kbd "<f12>") 'run-scheme)
(global-set-key (kbd "M-o") 'other-window)

;; Put "custom" settings in ~/.emacs.d/custom.el
(setq custom-file (d/at-emacs-dir "custom.el"))
(load custom-file nil t)
