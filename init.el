;; Обыкновенный курсор.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))
(add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "3f1dcd824a683e0ab194b3a1daac18a923eed4dba5269eecb050c718ab4d5a26" "08141ce5483bc173c3503d9e3517fca2fb3229293c87dc05d49c4f3f5625e1df" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "306793051a1bd8e3859783c9bbb7335ddbd8349fcaab1c7c2c6aad3d86c99b46" "268ffe7d42e6732185770ff9a2940e11c996dd47843336e5a227a0a06dc432b5" default)))
 '(package-selected-packages
   (quote
	(company-lsp cquery lsp-mode clang-format multi-compile exec-path-from-shell helm-projectile cmake-mode powerline magit helm markdown-mode company projectile)))
 '(projectile-enable-caching t)
 '(projectile-ignored-projects nil)
 '(projectile-mode t nil (projectile))
 '(projectile-project-root-files-bottom-up
   (quote
	(".projectile" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs")))
 '(safe-local-variable-values
   (quote
	((projectile-project-compilation-cmd . "bash build.sh")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)


(require 'custom_pref)
(require 'my_keybindings)
(require 'package)
(require 'plugins)


