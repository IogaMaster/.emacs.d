(use-package drag-stuff
  :after evil
  :config
  (define-key evil-visual-state-map (kbd "J") 'drag-stuff-down)
  (define-key evil-visual-state-map (kbd "K") 'drag-stuff-up))

(defun my/evil-window-split-and-focus ()
  "Split the window and focus the new window."
  (interactive)
  (evil-window-split)
  (other-window 1)) 

(defun my/evil-window-vsplit-and-focus ()
  "Vertical split and focus the new window."
  (interactive)
  (evil-window-vsplit)
  (other-window 1)) 

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "SPC w") 'evil-window-map)
  (define-key evil-window-map (kbd "h") 'evil-window-left)
  (define-key evil-window-map (kbd "j") 'evil-window-down)
  (define-key evil-window-map (kbd "k") 'evil-window-up)
  (define-key evil-window-map (kbd "l") 'evil-window-right)
  (define-key evil-window-map (kbd "d") 'evil-window-delete)
  (define-key evil-window-map (kbd "s") 'my/evil-window-split-and-focus)
  (define-key evil-window-map (kbd "v") 'my/evil-window-vsplit-and-focus))

(with-eval-after-load 'evil 
  (define-key evil-normal-state-map (kbd "SPC f d") 'dired-jump)
  (define-key evil-normal-state-map (kbd "SPC b i") 'ibuffer))

(use-package pretty-mode
  :config
  (global-pretty-mode t))
