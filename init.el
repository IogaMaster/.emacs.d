;; IogaMaster's Emacxxing Config

;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'use-package)
(setq straight-use-package-by-default t)

;;; Core
(use-package emacs
  :init
  (setq use-short-answers t
        scroll-conservatively 101
        scroll-margin 4
	create-lockfiles nil
	line-wrap nil
	word-wrap nil))


(use-package evil ;; Emacs is unusable without this
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :demand t
  :config
  (evil-mode t))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package catppuccin-theme
  :demand t
  :config
  (load-theme 'catppuccin :no-confirm))

(use-package restart-emacs
  :demand t)

(load-file "modules/basic.el")

;;; Pretty Ui

;; Remove ugly gui stuff
(menu-bar-mode -1)  
(tool-bar-mode -1)  
(scroll-bar-mode -1) 
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")  
(fringe-mode 0)
(global-display-line-numbers-mode t)

(set-face-attribute 'default nil :font "JetBrains Mono Nerd Font-14")
(set-face-attribute 'variable-pitch nil :font "JetBrains Mono Nerd Font-14")

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 40))
(doom-modeline-def-modeline 'main
    '(bar modals matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes check input-method buffer-encoding major-mode process vcs)) 
(doom-modeline-set-modeline 'main t)


;;; Completion

(use-package vertico
  :custom
  (vertico-count 4) 
  (vertico-cycle t) 
  :init
  (vertico-mode))

(use-package corfu
  :init
  (global-corfu-mode) 
  :config
  (setq corfu-auto t)
  (setq corfu-auto-prefix 2)         
  (setq corfu-echo-documentation t)
  (setq corfu-cycle t)
  (setq corfu-position 'bottom)  
  (with-eval-after-load 'corfu
    (define-key corfu-map (kbd "TAB") 'corfu-next)
    (define-key corfu-map (kbd "<tab>") 'corfu-next) 
    (define-key corfu-map (kbd "S-TAB") 'corfu-previous)
    (define-key corfu-map (kbd "<backtab>") 'corfu-previous))
   (set-face-attribute 'corfu-default nil
                       :background (face-background 'default)
                       :foreground (face-foreground 'default))
   (set-face-attribute 'corfu-current nil
                       :background (face-background 'highlight)
                       :foreground (face-foreground 'highlight))
   (set-face-attribute 'corfu-border nil
                       :background (face-background 'shadow)))

(use-package nerd-icons-corfu
  :after (nerd-icons corfu)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Make completions feel better
(use-package prescient
  :config (prescient-persist-mode))
(use-package vertico-prescient
  :after vertico
  :init (vertico-prescient-mode 1))
(use-package corfu-prescient
  :after corfu
  :init (corfu-prescient-mode 1))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode))


(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;;; Lsp

(load-file "./modules/lsp.el")

;;; Misc
(use-package smartparens
  :hook (after-init . smartparens-global-mode)
  :defer t
  :config
  (require 'smartparens-config))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :config
  (setq dirvish-attributes
        (append
         '(vc-state subtree-state nerd-icons collapse)
         '(git-msg file-modes file-time file-size))))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package vterm)
