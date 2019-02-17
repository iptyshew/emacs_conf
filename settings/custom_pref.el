;; Визуал
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;; Загружаем каталог с темами оформления

(setq-default cursor-type 'bar) ;; Тонкий курсор
(set-cursor-color "#f9e796") ;; Цвет курсора


;; на маке размер шрифта больше нужен
(if (eq system-type 'darwin)
	(set-default-font "consolas 15")
  (set-default-font "consolas 12"))

(global-linum-mode 1) ;; Включение нумерации

(tool-bar-mode -1) ;; Отлючение тул бара
(scroll-bar-mode -1) ;; Отлючение скрола
(menu-bar-mode -1) ;; Отключении меню бара

(setq redisplay-dont-pause t) ;; лучшая отрисовка буфера

(show-paren-mode 1) ;; Включить выделение выражений между {},[],()

(setq search-highlight        t ;; Подсветка результатов поиска
      query-replace-highlight t ;; Подсветка замены
      auto-window-vscroll     nil)


;; Общие удобства
(setq scroll-step 1) ;; Ограничение прокрутки
(setq scroll-margin 10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы
(fset 'yes-or-no-p 'y-or-n-p) ;; Простое потверждение.
(setq compilation-scroll-output t) ;; прокрутка окна компиляции

(windmove-default-keybindings 'meta) ;; Включаем переключение между окнами через Meta

(delete-selection-mode t) ;; Автоудаление выделеного.

(electric-pair-mode t) ;; Автозакрытие скобок

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Директория для бэкапов.
(setq backup-directory-alist '(("" . "~/.emacs.d/files-backup")))


(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(setq max-lisp-eval-depth 100000)
(setq max-specpdl-size 100000)


;; Переход по словам целиком
(global-superword-mode)


;; Подтягивание переменных окружения в emacs
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; smoot scroll
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)


;; Нормальный выбор окна в gdb-many-windows
(defadvice gud-display-line (around do-it-better activate)
  (let* ((last-nonmenu-event t)	 ; Prevent use of dialog box for questions.
	 (buffer
	  (with-current-buffer gud-comint-buffer
	    (gud-find-file true-file)))
         (window (and buffer
          (or (get-buffer-window buffer)
          (if (eq gud-minor-mode 'gdbmi)
              (or (if (get-buffer-window buffer 'visible)
                  (display-buffer buffer nil 'visible))
              (unless (gdb-display-source-buffer buffer)
                (gdb-display-buffer buffer nil 'visible))))
          (display-buffer buffer))))
	 (pos))
    (when buffer
      (with-current-buffer buffer
	(unless (or (verify-visited-file-modtime buffer) gud-keep-buffer)
	  (if (yes-or-no-p
	       (format "File %s changed on disk.  Reread from disk? "
		       (buffer-name)))
	      (revert-buffer t t)
	    (setq gud-keep-buffer t)))
	(save-restriction
	  (widen)
	  (goto-char (point-min))
	  (forward-line (1- line))
	  (setq pos (point))
	  (or gud-overlay-arrow-position
	      (setq gud-overlay-arrow-position (make-marker)))
	  (set-marker gud-overlay-arrow-position (point) (current-buffer))
	  ;; If they turned on hl-line, move the hl-line highlight to
	  ;; the arrow's line.
	  (when (featurep 'hl-line)
	    (cond
	     (global-hl-line-mode
	      (global-hl-line-highlight))
	     ((and hl-line-mode hl-line-sticky-flag)
	      (hl-line-highlight)))))
	(cond ((or (< pos (point-min)) (> pos (point-max)))
	       (widen)
	       (goto-char pos))))
      (when window
	(set-window-point window gud-overlay-arrow-position)
	(if (eq gud-minor-mode 'gdbmi)
	    (setq gdb-source-window window))))))


;; Debug commands
(defun start-debug-project()
  (interactive)
  (funcall-interactively 'gdb (concat "gdb -i=mi --args " projectile-project-run-cmd)))

(global-set-key (kbd "<f3>") 'start-debug-project)
(global-set-key (kbd "<f7>") 'gud-step)
(global-set-key (kbd "<f8>") 'gud-next)
(global-set-key (kbd "<f9>") 'gud-cont)


;; Удалять лишние пробелы при сохранении
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq default-input-method 'cyrillic-jis-russian)

(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char) ;; Возможность удалять символы в режиме isearch

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c b") #'switch-to-previous-buffer)
(global-set-key (kbd "C-c C-b") #'switch-to-previous-buffer)

(provide 'custom_pref)
