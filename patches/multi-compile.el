(defun multi-compile-run ()
  "Choice target and start compile."
  (interactive)
  (let* ((template (multi-compile--get-command-template))
         (command (or (car-safe template) template))
         (default-directory (if (listp template) (eval-expression (cadr template)) default-directory)))
	(progn (setq compile-command command)
		   (compilation-start
			(multi-compile--fill-template command)))))
