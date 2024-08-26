(toggle-frame-fullscreen)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   '(company-bbdb company-eclim company-cmake company-capf company-files
                  (company-dabbrev-code company-etags company-keywords)
                  company-oddmuse company-dabbrev))
 '(company-dabbrev-downcase 0)
 '(lsp-headerline-breadcrumb-enable nil)
 '(mouse-wheel-progressive-speed nil)
 '(org-M-RET-may-split-line '((default)))
 '(package-selected-packages
   '(evil fancy-compilation use-package-ensure-system-package yasnippet pdf-tools tramp yaml-mode clang-format all-the-icons projectile-ripgrep base16-theme aggressive-completion spinner flycheck vterm counsel-tramp ivy-xref amx flx counsel swiper ivy treemacs-icons-dired treemacs-projectile treemacs bison-mode dashboard solarized-theme use-package exec-path-from-shell cmake-mode powerline magit markdown-mode company projectile))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build" ".cquery_cached_index" ".cmake-build-release" ".cmake-build-debug"))
 '(projectile-ignored-projects nil)
 '(projectile-mode t nil (projectile))
 '(projectile-project-root-files-bottom-up
   '(".projectile" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs"))
 '(ring-bell-function 'ignore)
 '(tramp-default-host "kate")
 '(tramp-default-method "ssh")
 '(tramp-default-user "dmitry.iptyshev")
'(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-type-hint-face ((t (:inherit nil))))))

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)

(setq-default cursor-type '(bar . 3))

(set-cursor-color "#f9e796") ;; Цвет курсора

(require 'custom_pref)
(require 'my_keybindings)
(require 'package)
(require 'plugins)
(require 'hooks)
