
(require 'use-package)

(use-package helm
  :bind (("C-x C-m" . helm-M-x)
		 ("C-x C-m" . helm-M-x)
		 ("C-x m" . helm-M-x)
		 ("C-x C-f" . helm-find-files)
		 ("<f2>" . helm-buffers-list)
		 ("M-s o" . helm-occur))
  :init
  (setq helm-M-x-fuzzy-match t)
  (setq helm-display-function ;; helm всегда разделяет экран!
		 (lambda (buf tmp)
		   (split-window-vertically)
		   (other-window 1)
		   (switch-to-buffer buf))))

(use-package projectile
  :bind (("C-x p p" . helm-projectile-switch-project)
		 ("C-x C-p p" . helm-projectile-switch-project)
		 ("C-x p h" . helm-projectile)
		 ("C-x C-p h" . helm-projectile)
		 ("C-x p f" . helm-projectile-find-file)
		 ("C-x C-p f" . helm-projectile-find-file)
		 ("C-x p g" . helm-projectile-grep)
		 ("C-x C-p g" . helm-projectile-grep))
  :init
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'native))

(use-package magit
  :bind ([f1] . magit-status))

;; company mode
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-lsp))

(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
(setq company-lsp-enable-snippet nil)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-h") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") (lambda () (interactive) (company-complete-common-or-cycle 1)))
  (define-key company-active-map (kbd "C-p") (lambda () (interactive) (company-complete-common-or-cycle -1))))


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
		("\\.*" . (("gen-cmake" "(cd build && cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=yes -DWITH_TESTS=yes && mv compile_commands.json ../)" (locate-dominating-file buffer-file-name ".projectile"))
					 ("build" "(cd build && ninja -j 4)" (locate-dominating-file buffer-file-name ".projectile"))
					 ("test" "(cd build && ninja -j 4 && ninja test)" (locate-dominating-file buffer-file-name ".projectile"))))))
  (setq multi-compile-completion-system 'helm))

(use-package clang-format
  :bind(("C-c i" . clang-format-region)
		("C-c u" . clang-format-buffer)))

(require 'cquery)
(setq cquery-executable "/home/diptyshev/Util/cquery/build/release/bin/cquery")

(defun cquery//enable ()
  (condition-case nil
      (lsp-cquery-enable)
    (user-error nil)))
(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :completion (:detailedLabel t)))

(add-hook 'c-mode-hook #'cquery//enable)
(add-hook 'c++-mode-hook #'cquery//enable)

(defun cquery-keybindings ()
  (local-unset-key (kbd "C-."))
  (local-unset-key (kbd "C-;"))
  (local-set-key (kbd "C-.") 'xref-find-definitions)
  (local-set-key (kbd "M-;") 'xref-find-references)
  (local-set-key (kbd "C-8") 'xref-pop-marker-stack))

(add-hook 'c++-mode-hook 'cquery-keybindings)
(add-hook 'c-mode-hook 'cquery-keybindings)
(setq cquery-sem-highlight-method 'font-lock)

(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

(provide 'plugins)
