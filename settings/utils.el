;; Дополнительное действие на С-w, удаление региона сзади.
(defun backward-kill-word-or-kill-region (arg)
  (interactive "p")
  (if (region-active-p)
      (kill-region (region-beginning)
                   (region-end))
    (backward-kill-word arg)))

(defun my-mark-current-word (&optional arg allow-extend)
  "Put point at beginning of current word, set mark at end."
  (interactive "p\np")
  (setq arg (if arg arg 1))
  (if (and allow-extend
           (or (and (eq last-command this-command) (mark t))
               (region-active-p)))
      (set-mark
       (save-excursion
         (when (< (mark) (point))
           (setq arg (- arg)))
         (goto-char (mark))
         (forward-word arg)
         (point)))
    (let ((wbounds (bounds-of-thing-at-point 'word)))
      (unless (consp wbounds)
        (error "No word at point"))
      (if (>= arg 0)
          (goto-char (car wbounds))
        (goto-char (cdr wbounds)))
      (push-mark (save-excursion
                   (forward-word arg)
                   (point)))
      (activate-mark))))




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

(provide 'utils)
