;; -*- lexical-binding: t -*- 
(load-file "~/.emacs.d/settings.el")
(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/fonts.el")
(load-file "~/.emacs.d/litigature.el")
(load-file "~/.emacs.d/theme.el")
(load-file "~/.emacs.d/completion.el")
(load-file "~/.emacs.d/modeline.el")
(load-file "~/.emacs.d/tab-bar.el")
(load-file "~/.emacs.d/gp.el")
(load-file "~/.emacs.d/custom.el")
(load-file "~/.emacs.d/org.el")

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((rust-mode) . lsp)
  :commands lsp
  )

(setq make-backup-files nil)

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

(set-frame-parameter nil 'alpha-background 100)

(add-to-list 'default-frame-alist '(alpha-background . 100))
