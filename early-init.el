(setq package-enable-at-startup nil) ;; Recommended by straight.el
(dolist (var '(default-frame-alist initial-frame-alist))
  (add-to-list var '(right-divider-width . 20))
  (add-to-list var '(internal-border-width . 20)))

