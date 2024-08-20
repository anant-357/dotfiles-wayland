;; -*- lexical-binding: t -*- 
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(line-number-mode +1)
(global-hl-line-mode t)
(setq user-full-name "Anant Sharma")
(setq user-mail-address "anantsh.88@gmail.com")
(blink-cursor-mode -1)
(global-display-line-numbers-mode +1)
(column-number-mode t)
(size-indication-mode t)
(setq-default tab-width 4
              indent-tabs-mode nil)
(desktop-save-mode 1)
