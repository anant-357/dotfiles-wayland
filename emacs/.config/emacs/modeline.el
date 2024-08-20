;; -*- lexical-binding: t -*- 
(setq mode-line-position (list "󰧞%l,%c󰧞"))
(setq-default mode-line-format `("%e"
                                 x-mode-line-buffer-name
                                 x-mode-line-major-mode
                                 mode-line-format-right-align
                                 mode-line-position                           
                                 x-mode-line-git-branch
                                 ))

(defvar-local x-mode-line-buffer-name
    '(:eval
      (list
       (propertize " 󰈔 " 'face 'shadow)
       (if buffer-file-name
           (propertize (buffer-file-name) 'face 'warning)
         (propertize (buffer-name) 'face 'warning)
         )
       )
      )
  )

(defvar-local x-mode-line-major-mode
    '(:eval
      (list (propertize " 󰘧 " 'face 'shadow)
            (propertize
                (symbol-name major-mode) 'face 'success)
            )
      )
  )
(defvar-local x-mode-line-git-branch
    '(:eval (when vc-mode
              (list
               (propertize " 󰊢" 'face 'shadow)
               (propertize vc-mode 'face 'error)
               " "
               )
              )
            )
  )

(put 'x-mode-line-major-mode 'risky-local-variable t)
(put 'x-mode-line-buffer-name 'risky-local-variable t)
(put 'x-mode-line-git-branch 'risky-local-variable t)
