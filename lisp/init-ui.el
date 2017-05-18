(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default cursor-type 'bar)

(setq inhibit-splash-screen 1)

(global-company-mode 1)
(global-hl-line-mode t)

(setq initial-frame-alist (quote ((fullscreen . maximized))))

(provide 'init-ui)
