;; C++

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

(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode nil)

(add-to-list 'auto-mode-alist '("\\.hqt\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-to-list 'auto-mode-alist '("\\.ypp\\'" . bison-mode))

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



;;GYP
(define-derived-mode gyp-mode python-mode "GYP"
  "Major mode for editing Generate Your Project files."
  (setq indent-tabs-mode nil
        tab-width 4
        python-indent 4))

(add-to-list 'auto-mode-alist '("\\.gyp$" . gyp-mode))
(add-to-list 'auto-mode-alist '("\\.gypi$" . gyp-mode))

;; XP normalization
(setq xp-font-lock-keywords
      (let* (
            ;; define several category of keywords
             (x-keywords '("if" "not" "div"
                           "mod" "and" "or"
                           "switch" "else"
                           "elif" "then"
                           "endif" "summessage"
                           "subformula" "endsubformula"))
             (x-types '("CSV" "DATETIME" "DURATION"
                        "HOSTNAME" "IPV4" "KEYVALUE"
                        "LITERAL" "MACADDR" "NTUSER"
                        "NUMBER" "REST" "STRING" "UNTIL"
                        "WORD" "WORDDASH" "IPV6"))
             (x-constants '("TEXT" "JSON" "EVENTLOG" "TABULAR" "XML" "COND"))
             (x-functions '("datetime" "datetime_to_epoch"
                            "datetime_to_epoch_ms" "datetime_to_win_ticks"
                            "duration" "epoch_to_datetime" "epoch_ms_to_datetime"

                            "strip" "csv" "find_substr" "keyvalue" "length" "len"
                            "lower" "match" "substr" "upper"))

             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          )))

;;;###autoload
(define-derived-mode xp-mode fundamental-mode "xp mode"
  "Major mode for editing XP (Linden Scripting Language)…"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((xp-font-lock-keywords)))
  (add-to-list 'auto-mode-alist '("\\.xp\\'" . xp-mode)))

(add-to-list 'auto-mode-alist '("\\.xp\\'" . xp-mode))


(provide 'hooks)
