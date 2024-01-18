(load-file "~/.emacs.d/settings.el")
(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/fonts.el")
(load-file "~/.emacs.d/litigature.el")
(load-file "~/.emacs.d/theme.el")
(load-file "~/.emacs.d/completion.el")
(load-file "~/.emacs.d/bison-mode.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" default))
 '(package-selected-packages
   '(auctex nerd-icons-dired company nerd-icons lsp-ui lsp-mode magit ## rust-mode gruvbox-theme))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((rust-mode) . lsp)
  :commands lsp
  )

(use-package lsp-ui :commands lsp-ui-mode)

(require 'rust-mode)
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))
(use-package nerd-icons)
(add-hook 'after-init-hook 'global-company-mode)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
