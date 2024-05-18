(toggle-frame-fullscreen)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   '(company-bbdb company-eclim company-cmake company-capf company-files
                  (company-dabbrev-code company-etags company-keywords)
                  company-oddmuse company-dabbrev))
 '(company-dabbrev-downcase 0)
 '(custom-safe-themes
   '("5b01334cb330cd69e5f3d6214521c9f9d703d1c31ca0f4f04f36b6cf9f4870c8" "146061a7ceea4ccc75d975a3bb41432382f656c50b9989c7dc1a7bb6952f6eb4" "1f538e3de6aa8711e3ad8f297a57ee8210ade0f46f411c06343d126a4fea72c6" "d2bd16a8bcf295dce0b70e1d2b5c17bb34cb28224a86ee770d56e6c22a565013" "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "e4d17ca481ddf5a7a5f4604159895203866db262134ed83dbc3b62e4158edf38" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "ae9c7673002bcdb54da20a04eec7ab6591ded38d1141a3110f3d662eef130157" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "4e21fb654406f11ab2a628c47c1cbe53bab645d32f2c807ee2295436f09103c6" "a866134130e4393c0cad0b4f1a5b0dd580584d9cf921617eee3fd54b6f09ac37" "53d1bb57dadafbdebb5fbd1a57c2d53d2b4db617f3e0e05849e78a4f78df3a1b" "b5ecb5523d1a1e119dfed036e7921b4ba00ef95ac408b51d0cd1ca74870aeb14" "0846e3b976425f142137352e87dd6ac1c0a1980bb70f81bfcf4a54177f1ab495" "2a1b4531f353ec68f2afd51b396375ac2547c078d035f51242ba907ad8ca19da" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "3f1dcd824a683e0ab194b3a1daac18a923eed4dba5269eecb050c718ab4d5a26" "08141ce5483bc173c3503d9e3517fca2fb3229293c87dc05d49c4f3f5625e1df" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "306793051a1bd8e3859783c9bbb7335ddbd8349fcaab1c7c2c6aad3d86c99b46" "268ffe7d42e6732185770ff9a2940e11c996dd47843336e5a227a0a06dc432b5" default))
 '(mouse-wheel-progressive-speed nil)
 '(package-selected-packages
   '(dap-mode telega yaml-mode clang-format all-the-icons projectile-ripgrep base16-theme aggressive-completion lsp-jedi spinner flycheck vterm counsel-tramp ivy-xref amx flx counsel swiper ivy treemacs-icons-dired treemacs-projectile treemacs bison-mode dashboard solarized-theme use-package lsp-mode exec-path-from-shell cmake-mode powerline magit markdown-mode company projectile))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".cquery_cached_index" ".cmake-build-release" ".cmake-build-debug"))
 '(projectile-ignored-projects nil)
 '(projectile-mode t nil (projectile))
 '(projectile-project-root-files-bottom-up
   '(".projectile" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs"))
 '(ring-bell-function 'ignore)
 '(safe-local-variable-values
   '((projectile-project-run-cmd . "/home/iptyshew/buildSource/work/ptrc/build/bin/rcc -t /home/iptyshew/WorkData/kb/taxonomy.json -l n /home/iptyshew/WorkData/tests/text.xp")
     (encoding . utf-8)
     (projectile-project-compilation-cmd . "bash build.sh"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)

(setq-default cursor-type '(bar . 3))

(set-cursor-color "#f9e796") ;; Цвет курсора

(require 'custom_pref)
(require 'my_keybindings)
(require 'package)
(require 'plugins)
(require 'hooks)
