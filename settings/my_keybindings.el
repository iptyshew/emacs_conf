;; настройки клавиш
(require 'utils)

(global-unset-key (kbd "<f2>")) ;; For ibuffer
(global-unset-key (kbd "<f3>")) ;; For ibuffer
(global-unset-key (kbd "C-z")) ;; Мешает работе
(global-unset-key (kbd "C-x m")) ;; Мешает работе
(global-unset-key (kbd "C-x C-c")) ;; Мешает работе
(global-unset-key (kbd "C-x C-p")) ;; Мешает работе
(global-set-key (kbd "<backspace>") 'ignore) ;; Ибо нефиг

(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word-or-kill-region)
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "C-w") 'ido-delete-backward-word-updir)))

(global-set-key (kbd "C-=") 'my-mark-current-word)

;;mac os only
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; compilation
(global-set-key (kbd "C-<f5>") 'kill-compilation)

;; Прыгаем по окнам, аки воробей
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)

(provide 'my_keybindings)
