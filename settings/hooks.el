;; C++
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)
(setq indent-line-function 'insert-tab)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

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
