;; Визуал
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;; Загружаем каталог с темами оформления

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'doom-vibrant)

(setq-default cursor-type 'bar) ;; Тонкий курсор
(set-cursor-color "#f9e796") ;; Цвет курсора


;; на маке размер шрифта больше нужен
(if (eq system-type 'darwin)
	(set-default-font "consolas 15")
  (set-default-font "inconsolata 12"))

(global-linum-mode 1) ;; Включение нумерации

(tool-bar-mode -1) ;; Отлючение тул бара
(scroll-bar-mode -1) ;; Отлючение скрола
(menu-bar-mode -1) ;; Отключении меню бара

(setq redisplay-dont-pause t) ;; лучшая отрисовка буфера

(show-paren-mode 1) ;; Включить выделение выражений между {},[],()

(setq search-highlight        t ;; Подсветка результатов поиска
      query-replace-highlight t ;; Подсветка замены
      auto-window-vscroll     nil)
;; Визуал


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


;; Add a cc-mode style for editing LLVM C and C++ code
(c-add-style "llvm.org"
             '("gnu"
	       (fill-column . 80)
	       (c++-indent-level . 2)
	       (c-basic-offset . 2)
	       (indent-tabs-mode . nil)
	       (c-offsets-alist . ((arglist-intro . ++)
				   (innamespace . 0)
				   (member-init-intro . ++)))))

;; Files with "llvm" in their names will automatically be set to the
;; llvm.org coding style.
(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil
	     (if (string-match "llvm" buffer-file-name)
		 (progn
		   (c-set-style "llvm.org"))))))

(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode nil)

(add-to-list 'auto-mode-alist '("\\.hqt\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
			  c-indent-level 4         ; A TAB is equivilent to four spaces
			  c-argdecl-indent 0       ; Do not indent argument decl's extra
			  c-tab-always-indent t
			  backward-delete-function nil) ; DO NOT expand tabs when deleting

(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4
(defun my-c-mode-hook ()
  (c-set-style "my-c-style")
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-intro '++)       ; indent case labels by c-indent-level, too
  (c-set-offset 'innamespace '-)
  )


(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(setq max-lisp-eval-depth 100000)
(setq max-specpdl-size 100000)


;; Переход по словам целиком
(global-superword-mode)


;; Подтягивание переменных окружения в emacs
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

(define-derived-mode gyp-mode python-mode "GYP"
  "Major mode for editing Generate Your Project files."
  (setq indent-tabs-mode nil
        tab-width 4
        python-indent 4))

(add-to-list 'auto-mode-alist '("\\.gyp$" . gyp-mode))
(add-to-list 'auto-mode-alist '("\\.gypi$" . gyp-mode))

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


;; Команда для старта отладки
(defun start-debug-project()
  (interactive)
  (funcall-interactively 'gdb (concat "gdb -i=mi --args " projectile-project-run-cmd)))

(defun start-project()
  (interactive)
  (funcall-interactively 'async-shell-command projectile-project-run-cmd))

(defun manage-project-bindings()
  (local-unset-key (kbd "<f3>"))
  (local-unset-key (kbd "<f4>"))
  (local-set-key (kbd "<f3>") 'start-debug-project)
  (local-set-key (kbd "<f4>") 'start-project))

(add-hook 'c++-mode-hook 'manage-project-bindings)
(add-hook 'c-mode-hook 'manage-project-bindings)

;; Удалять лишние пробелы при сохранении
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Открывать на весь экран при старте
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(provide 'custom_pref)
