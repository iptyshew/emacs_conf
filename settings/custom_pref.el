;; Визуал
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;; Загружаем каталог с темами оформления

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'doom-vibrant)

(setq-default cursor-type 'bar) ;; Тонкий курсор
(set-cursor-color "#f9e796") ;; Цвет курсора


;; на маке размер шрифта больше нужен
(if (eq system-type 'darwin)
	(set-default-font "consolas 15")
  (set-default-font "consolas 11"))

(global-linum-mode 1) ;; Включение нумерации

(tool-bar-mode -1) ;; Отлючение тул бара
(scroll-bar-mode -1) ;; Отлючение скрола

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
			  indent-tabs-mode t)

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


(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)


(provide 'custom_pref)
