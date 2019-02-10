(require 'use-package)

(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper))

(use-package ivy
  :ensure t
  :after (swiper)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-subdir t)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil))

(global-set-key (kbd "<f2>") 'counsel-ibuffer) ;; In use-package not work with 2C


(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper))


(use-package counsel
  :ensure t
  :bind
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file))


(use-package projectile
   :init
   (setq projectile-enable-caching t)
   (setq projectile-indexing-method 'native)
   (setq projectile-completion-system 'ivy)
   :bind
   ("C-x p p" . projectile-switch-project)
   ("C-x C-p p" . projectile-switch-project)
   ("C-x p f" . projectile-find-file)
   ("C-x C-p f" . projectile-find-file)
   ("C-x p g" . projectile-grep)
   ("C-x C-p g" . projectile-grep))


(use-package magit
  :bind ([f1] . magit-status))


(use-package company
  :ensure t
  :hook (after-init-hook global-company-mode)
  :init
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-lsp))
  (setq company-transformers nil)
  (setq company-lsp-async t)
  (setq company-lsp-cache-candidates nil)
  (setq company-lsp-enable-snippet nil)
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-h" . nil)
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous)))


;; Mac os only. Подхватывание переменных окружения
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defun source-file-and-get-envs (filename)
  (let* ((cmd (concat ". " filename "; env"))
         (env-str (shell-command-to-string cmd))
         (env-lines (split-string env-str "\n"))
         (envs (mapcar (lambda (s) (replace-regexp-in-string "=.*$" "" s)) env-lines)))
    (delete "" envs)))

(exec-path-from-shell-copy-envs (source-file-and-get-envs "~/.profile"))


(use-package multi-compile
  :bind([f5] . multi-compile-run)
  :init
  (setq multi-compile-alist '(
		("\\.*" . (("gen-cmake" "cmake -B build -H. -G \"Ninja\" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=yes -DWITH_TESTS=yes" (locate-dominating-file buffer-file-name ".projectile"))
				   ("build" "cmake --build build" (locate-dominating-file buffer-file-name ".projectile"))
				   ("test" "cmake --build build && ninja -C build test" (locate-dominating-file buffer-file-name ".projectile"))))))
  (setq multi-compile-completion-system 'ivy))


(use-package clang-format
  :bind(("C-c i" . clang-format-region)
		("C-c u" . clang-format-buffer)))


(require 'cquery)
(setq cquery-executable "/home/iptyshew/util/cquery/build/cquery")
(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :completion (:detailedLabel t)))

(setq lsp-enable-snippet nil)

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(defun lsp-keybindings ()
  (local-unset-key (kbd "C-."))
  (local-unset-key (kbd "C-;"))
  (local-set-key (kbd "C-.") 'xref-find-definitions)
  (local-set-key (kbd "M-.") 'lsp-goto-implementation)
  (local-set-key (kbd "M-;") 'xref-find-references)
  (local-set-key (kbd "C-8") 'xref-pop-marker-stack))

(add-hook 'c++-mode-hook 'lsp-keybindings)
(add-hook 'c-mode-hook 'lsp-keybindings)

;;(use-package helm-xref
;;  :init (setq xref-show-xrefs-function 'helm-xref-show-xrefs))


(use-package powerline
  :init (powerline-center-theme))


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5))))

(use-package
  bison-mode
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-git-command-pipe           ""
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-no-delete-other-windows    t
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
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

(provide 'plugins)
