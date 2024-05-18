(require 'use-package)

(use-package swiper
  :ensure t
  :bind
  ("M-o s" . swiper))

(use-package ivy
  :ensure t
  :after (swiper)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-subdir t
        ivy-initial-inputs-alist nil))

(global-set-key (kbd "<f2>") 'counsel-ibuffer) ;; In use-package not work with 2C
(global-set-key (kbd "<f3>") 'counsel-ibuffer)

(use-package counsel
  :ensure t
  :bind
  ("C-x C-f" . counsel-find-file)
  ("C-x g"   . counsel-git-grep)
  ("C-x C-g" . counsel-git-grep))

(use-package projectile
   :ensure t
   :init
   (setq projectile-enable-caching t
         projectile-indexing-method 'hybrid
         projectile-completion-system 'ivy)
   :bind
   ("C-x p p" . projectile-switch-project)
   ("C-x C-p p" . projectile-switch-project)
   ("C-x p f" . projectile-find-file)
   ("C-x C-p f" . projectile-find-file)
   ("C-x C-p g" . projectile-ripgrep)
   ("C-x p g" . projectile-ripgrep))


(use-package magit
  :bind
  ([f1] . magit-status))


(use-package company
  :ensure t
  :init
  (setq company-transformers nil
        company-dabbrev-downcase 0
        company-idle-delay 0)
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-h" . nil)
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous)))


(use-package multi-compile
  :load-path (lambda () (concat user-emacs-directory "thirdparty/emacs-multi-compile"))
  :bind (([f5] . multi-compile-run)
         ([f6] . multi-compile-rerun))
  :init
  (setq multi-compile-alist '(
		              ("\\.*" .
                               (("gen-cmake-clang-full" "CXX=clang++ CC=clang cmake -B build -H. -G \"Ninja\" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=yes -DDPDK_KERN_BYPASS=yes && mv build/compile_commands.json ." (locate-dominating-file buffer-file-name ".projectile-full"))
                                ("gen-cmake" "PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig cmake -B build -H. -G \"Ninja\" -DCMAKE_BUILD_TYPE=Debug -DGATESPATTERN=binance -DCMAKE_EXPORT_COMPILE_COMMANDS=yes -DDPDK_KERN_BYPASS=yes && mv build/compile_commands.json ." (locate-dominating-file buffer-file-name ".projectile-full"))
			        ("build" "ninja -C build" (locate-dominating-file buffer-file-name ".projectile-full"))
			        ("build-md" "ninja -C build md_gate" (locate-dominating-file buffer-file-name ".projectile-full"))
			        ("build-robot" "ninja -C build -w dupbuild=warn mdlog_processor md_gate trade_gate proxy_gate strategy head shm_storage_agent mdlog_server mdlog_storage" (locate-dominating-file buffer-file-name ".projectile-full"))
				("test" "ninja -C build master_gtest" (locate-dominating-file buffer-file-name ".projectile"))
                                ("clear" "rm -rf build" (locate-dominating-file buffer-file-name ".projectile-full"))))))
  (setq multi-compile-completion-system 'ivy))



(use-package lsp-mode
  :init (setq lsp-clients-clangd-executable "clangd"
              lsp-enable-indentation nil
              lsp-enable-snippet nil
              lsp-enable-symbol-highlighting t
              lsp-enable-on-type-formatting nil)
  :config (setq gc-cons-threshold 100000000 ;; perfomance
                read-process-output-max (* 1024 1024)) ;; perfomance
  :hook (c-mode . lsp)
        (c++-mode . lsp)
        (python-mode . lsp)
  :commands lsp)

(global-unset-key (kbd "C-."))
(global-set-key (kbd "C-.") 'xref-find-definitions)
(global-set-key (kbd "C-.") 'xref-find-definitions)
(global-set-key (kbd "M-.") 'lsp-find-implementation)
(global-set-key (kbd "M-;") 'xref-find-references)
(global-set-key (kbd "C-8") 'xref-pop-marker-stack)


(use-package powerline
  :init (powerline-center-theme))


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t))

(use-package bison-mode
  :ensure t
  :mode ("\\.re\\'" . bison-mode))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         45)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))


(use-package amx
  :ensure t
  :config
  (amx-mode 1)
  (setq amx-backend (quote ivy))
  (define-key amx-map (kbd "C-h") nil)
  :bind
  ("C-x C-m" . amx)
  ("C-x m" . amx))


(use-package ivy-xref
  :ensure t
  :config (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package avy
  :ensure t
  :bind (("C-c C-;" . avy-goto-char-2)
         ("C-;"     . avy-goto-word-1)))

;; (require 'vterm)
;; (define-key vterm-mode-map (kbd "<f2>") nil)
;; (define-key vterm-mode-map (kbd "M-h") nil)
;; (define-key vterm-mode-map (kbd "M-l") nil)
;; (define-key vterm-mode-map (kbd "M-k") nil)
;; (define-key vterm-mode-map (kbd "M-j") nil)
;; (define-key vterm-mode-map (kbd "C-h")
;;   (lambda () (interactive) (vterm-send-key (kbd "DEL"))))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-solarized-dark t))

(use-package all-the-icons
  :ensure t)

(require 'dap-cpptools)
(dap-auto-configure-mode 1)

(provide 'plugins)
