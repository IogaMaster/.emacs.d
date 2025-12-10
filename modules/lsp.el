(use-package eglot
  :ensure nil
  :defer t
  :hook (prog-mode . eglot-ensure))

(use-package eldoc
  :ensure nil                                ;; This is built-in, no need to fetch it.
  :config
  (setq eldoc-idle-delay 0)                  ;; Automatically fetch doc help
  (setq eldoc-echo-area-use-multiline-p nil) ;; We use the "K" floating help instead
                                             ;; set to t if you want docs on the echo area
  (setq eldoc-echo-area-display-truncation-message nil)
  :init
  (global-eldoc-mode))

(use-package eldoc-box)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))


(use-package nix-mode
  :defer t
  :mode "\\.nix\\'")

(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t))
(add-hook 'rust-mode-hook 'eglot-ensure)
