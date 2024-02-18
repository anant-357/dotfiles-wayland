(load-file "~/.emacs.d/settings.el")
(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/fonts.el")
(load-file "~/.emacs.d/litigature.el")
(load-file "~/.emacs.d/theme.el")
(load-file "~/.emacs.d/completion.el")
(load-file "~/.emacs.d/modeline.el")
(load-file "~/.emacs.d/tab-bar.el")
(load-file "~/.emacs.d/bison-mode.el")
(load-file "~/.emacs.d/gp.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi")
     (output-pdf "Zathura") (output-html "xdg-open")))
 '(custom-safe-themes
   '("80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242"
     "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961"
     "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569"
     "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4"
     "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe"
     "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7"
     "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20"
     default))
 '(package-selected-packages
   '(## auctex bash-completion catppuccin-theme company dracula-theme ein
        emmet-mode gnuplot gruvbox-theme lsp-mode lsp-ui lua-mode
        magit monochrome-theme nerd-icons nerd-icons-dired python-mode
        rust-mode typescript-mode))
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

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))
