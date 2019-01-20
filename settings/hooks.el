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



(provide 'hooks)
