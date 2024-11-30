(if (eq system-type 'darwin)
	(set-frame-font "monaco 14")
  (set-frame-font "source code pro 10"))

(tool-bar-mode -1) ;; Отлючение тул бара
(scroll-bar-mode -1) ;; Отлючение скрола
(menu-bar-mode -1) ;; Отключении меню бара

(setq redisplay-dont-pause t) ;; лучшая отрисовка буфера

(show-paren-mode 1) ;; Включить выделение выражений между {},[],()

(setq search-highlight        t ;; Подсветка результатов поиска
      query-replace-highlight t ;; Подсветка замены
      auto-window-vscroll     nil)

;; Общие удобства
(setq scroll-step 1 ;; Ограничение прокрутки
      scroll-margin 10 ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы
      scroll-conservatively 10000 ;; Плавный скроллинг
      scroll-preserve-screen-position 1)

;; smoot scroll
;;(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(fset 'yes-or-no-p 'y-or-n-p) ;; Простое потверждение.
(setq compilation-scroll-output t) ;; прокрутка окна компиляции

(delete-selection-mode t) ;; Автоудаление выделеного.

(electric-pair-mode t) ;; Автозакрытие скобок

;; Директория для бэкапов.
(setq backup-directory-alist '(("" . "~/.emacs.d/files-backup")))

(setq gdb-many-windows t  ;; use gdb-many-windows by default
      gdb-show-main t)  ;; Non-nil means display source file containing the main routine at startup)

(setq max-lisp-eval-depth 100000)
(setq max-specpdl-size 100000)

;; Переход по словам целиком
(global-superword-mode)

;; Удалять лишние пробелы при сохранении
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Дефолтная русская раскладка при переключениии языка
(setq default-input-method 'russian-computer)

(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char) ;; Возможность удалять символы в режиме isearch

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(add-hook 'c++-mode-hook (lambda () (local-unset-key (kbd "C-c C-b"))))
(global-set-key (kbd "C-c b") #'switch-to-previous-buffer)
(global-set-key (kbd "C-c C-b") #'switch-to-previous-buffer)

(setq mac-pass-command-to-system nil)

(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)

(setq org-agenda-files '("~/org"))
(setq org-log-done 'time)
(setq org-return-follows-link  t)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'org-indent-mode)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-hide-emphasis-markers t)
(add-hook 'org-mode-hook 'visual-line-mode)
(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "DONE")))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-h") 'windmove-left))

(provide 'custom_pref)
