;; настройки клавиш
(require 'utils)

(global-unset-key (kbd "C-z")) ;; Мешает работе
(global-unset-key (kbd "C-x m")) ;; Мешает работе
(global-unset-key (kbd "C-x C-c")) ;; Мешает работе
(global-set-key (kbd "<backspace>") 'ignore) ;; Ибо нефиг

(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word-or-kill-region)
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "C-w") 'ido-delete-backward-word-updir)))

(global-set-key (kbd "<f6>") 'recompile)

(provide 'my_keybindings)

