
;; Speedbar
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images t)


;; Helm
(require 'helm)
(setq helm-M-x-fuzzy-match t) ;; нечеткий поиск

(setq helm-display-function ;; helm всегда разделяет экран!
      (lambda (buf tmp)
        (split-window-vertically)
        (other-window 1)
        (switch-to-buffer buf)))

(global-set-key (kbd "C-x C-m") 'helm-M-x)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "<f2>") 'helm-buffers-list)
(global-set-key (kbd "M-s o") 'helm-occur)


;; Projectile
(projectile-mode)
(setq projectile-enable-caching t)

(global-set-key (kbd "C-x p p") 'helm-projectile-switch-project)
(global-set-key (kbd "C-x C-p p") 'helm-projectile-switch-project)
(global-set-key (kbd "C-x p h") 'helm-projectile)
(global-set-key (kbd "C-x C-p h") 'helm-projectile)
(global-set-key (kbd "C-x p f") 'helm-projectile-find-file)
(global-set-key (kbd "C-x C-p f") 'helm-projectile-find-file)
(global-set-key (kbd "C-x p g") 'helm-projectile-grep)
(global-set-key (kbd "C-x C-p g") 'helm-projectile-grep)


;; magit
(global-unset-key [f1])
(global-set-key [f1] 'magit-status)


;; Rtags
(require 'rtags)
(defun rtags-keybindings ()
  (local-unset-key (kbd "C-."))
  (local-unset-key (kbd "C-;"))
  (local-set-key (kbd "C-.") 'rtags-find-symbol-at-point)
  (local-set-key (kbd "M-;") 'rtags-find-references-at-point)
  (local-set-key (kbd "C-8") 'rtags-location-stack-back)
  (local-set-key (kbd "M-n") 'rtags-next-match)
  (local-set-key (kbd "M-p") 'rtags-previous-match)
  (local-set-key (kbd "<f4>") 'rtags-taglist)
  )

(add-hook 'c++-mode-hook 'rtags-keybindings)
(add-hook 'c-mode-hook 'rtags-keybindings)
(setq rtags-display-result-backend 'helm)

;; Автодополнение rtags
(setq rtags-autostart-diagnostics t)
(setq rtags-completions-enabled t)


;; cmake ide
(require 'cmake-ide)
(cmake-ide-setup)


;; company mode
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-rtags))
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))




(provide 'plugins)
