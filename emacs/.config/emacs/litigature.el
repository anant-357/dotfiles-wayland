;; -*- lexical-binding: t -*- 
(require 'cl-lib)

(defgroup ligature nil
  "Typographic Ligatures in Emacs."
  :group 'faces
  :prefix "ligature-")

(defcustom ligature-ignored-major-modes '(minibuffer-inactive-mode)
  "Major modes that will never have ligatures applied to them.

Unlike `ligature-generate-ligatures' the ignored major modes are
only checked when the minor mode command `ligature-mode' is enabled."
  :type '(repeat symbol)
  :group 'ligature)

(defvar ligature-composition-table nil
  "Alist of ligature compositions.

Each element in the alist is made up of (MODES
. LIGATURE-MAPPINGS) where LIGATURE-MAPPINGS is an alist
of (STR-CHAR . LIGATURE-PATTERN) and MODES is either:

  a. A major mode, such as `prog-mode' or `c-mode';

  b. A list of major modes;

  c. The value t, indicating the associated ligature mappings
  must apply to _all_ modes, even internal ones.

A STR-CHAR is a string consisting of a _single_ character that
defines the beginning of a ligature.  The LIGATURE-PATTERN is a
regexp that should match all the various ligatures that start
with STR-CHAR.  For instance, `!' as a STR-CHAR may have a two
ligatures `=' and `==' that together form `!=' and `!=='.")

;;;###autoload
(defun ligature-set-ligatures (modes ligatures)
  "Replace LIGATURES in MODES.

Converts a list of LIGATURES, where each element is either a cons
cell of `(STR-CHAR . REGEXP)' or a string to ligate, for all
modes in MODES.  As there is no easy way of computing which
ligatures were already defined, this function will replace any
existing ligature definitions in `ligature-composition-table'
with LIGATURES for MODES.


Some ligatures are variable-length, such as arrows and borders,
and need a regular expression to accurately represent the range
of characters needed to ligate them.  In that case, you must use a
cons cell of `(STR-CHAR . REGEXP)' where `STR-CHR' is the first
character in the ligature and `REGEXP' is a regular expression
that matches the _rest_ of the ligature range.

For examples, see the commentary in `ligature.el'."
  (let (grouped-ligatures)
    (dolist (ligature ligatures)
      (cond
       ;; the simplest case - we have a string we wish to ligate
       ((stringp ligature)
        (if (< (length ligature) 2)
            (error "Ligature `%s' must be 2 characters or longer" ligature)
          (let ((str-char (substring ligature 0 1)))
            (push (list 'literal (substring ligature 1))
                  (alist-get str-char grouped-ligatures nil nil #'equal)))))
       ;; cons of (STR-CHAR . REGEXP) where STR-CHR must be 1 char long
       ((consp ligature)
        (let ((str-char (car ligature))
              (ligature-regexp (cadr ligature)))
          (unless (= (length str-char) 1)
            (error "Ligature cons cell has a str-char of `%s' but must be a \
string of a single character" str-char))
          (push (list 'regex
                      ;; we can supply either a regexp string _or_ an unexpanded `rx' macro.
                      (if (stringp ligature-regexp) ligature-regexp
                        (macroexpand ligature-regexp)))
                (alist-get str-char grouped-ligatures nil nil #'equal))))))
    ;; given a grouped alist of ligatures, we enumerate each group and
    ;; update the `ligature-composition-table'.
    (dolist (group grouped-ligatures)
      ;; Sort the grouped ligatures - containing lists of either
      ;; `literal' or `regex' as the car of the type of atom in the
      ;; cdr - as we want the literal matchers _after_ the regex
      ;; matchers. It's likely the regex matchers supercede anything
      ;; the literal matchers may encapsulate, so we must ensure they
      ;; are checked first.
      (let ((regexp-matchers (cl-remove-if (apply-partially #'equal 'literal) (cdr group) :key #'car))
            ;; Additionally we need to ditch the `literal' symbol (and
            ;; just keep the cdr, which is the string literal), even
            ;; though it's a legitimate `rx' form, because `(group (|
            ;; (literal "a") (literal "aa") ...)' will NOT yield the
            ;; same automatic grouping of shortest-to-longest matches
            ;; like the canonical version that does _not_ use literal.
            (literal-matchers (mapcan 'cdr (cl-remove-if (apply-partially #'equal 'regex) (cdr group) :key #'car))))
        (setf (alist-get (car group)
                         (alist-get modes ligature-composition-table nil 'remove #'equal) nil 'remove #'equal)
              (macroexpand `(rx (|
                                 ;; `rx' does not like nils so we have
                                 ;; to filter them
                                 ;; manually. Furthermore, we prefer
                                 ;; regexp to literal matches and want
                                 ;; them to appear first.
                                 ,@(cl-remove-if 'null (list (if regexp-matchers `(group (| ,@regexp-matchers)) nil)
                                                             (if literal-matchers `(group (| ,@literal-matchers)) nil)))))))))))

;;;###autoload
(defun ligature-generate-ligatures ()
  "Ligate the current buffer using its major mode to determine ligature set.

The ligature generator traverses `ligature-composition-table' and
applies every ligature definition from every mode that matches
either t (indicating that a ligature mapping always applies);
or a major mode or list of major mode symbols that are
`derived-mode-p' of the current buffer's major mode.

The changes are then made buffer-local."
  (interactive)
  (let ((table (make-char-table nil)))
    (dolist (ligature-table ligature-composition-table)
      (let ((modes (car ligature-table)) ; `rst-mode', `html-mode', etc.
            (rules (cdr ligature-table))) ; alist of rules mapping a character to a regexp.
        ;; If `mode' is t we always apply the rules, regardless of
        ;; whether `derived-mode-p' matches or not.
        (when (or (eq modes t) (cl-some #'derived-mode-p (if (listp modes)
                                                             modes
                                                           (list modes))))
          (dolist (rule rules)
            (set-char-table-range table (string-to-char (car rule))
                                  ;; in order for Emacs to properly
                                  ;; understand the ligature mappings we
                                  ;; must include either a generic "match
                                  ;; any" metacharacter to represent the
                                  ;; character that we use to define the
                                  ;; beginning of a character table
                                  ;; range.
                                  `([,(concat "." (cdr rule)) 0 font-shape-gstring]))))))
    (set-char-table-parent table composition-function-table)
    (setq-local composition-function-table table)))

;;;###autoload
(define-minor-mode ligature-mode "Enables typographic ligatures."
  :init-value nil :lighter nil :keymap nil
  (if (= emacs-major-version 27)
      (warn "ligature-mode is currently broken in emacs `%s' due to a bug in
Emacs's core. For more information have a look at this ISSUE:
https://github.com/mickeynp/ligature.el/issues/28."
            emacs-major-version)
    (if (not ligature-mode)
        (setq-local composition-function-table (default-value 'composition-function-table))
      (unless (memq major-mode ligature-ignored-major-modes)
        (ligature-generate-ligatures)))))

(defun ligature-mode-turn-on ()
  "Turn on command `ligature-mode'."
  (ligature-mode t))

;;;###autoload
(define-globalized-minor-mode global-ligature-mode ligature-mode ligature-mode-turn-on)


(provide 'ligature)

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia and Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode
                        '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                          ;; =:= =!=
                          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                          ;; ;; ;;;
                          (";" (rx (+ ";")))
                          ;; && &&&
                          ("&" (rx (+ "&")))
                          ;; !! !!! !. !: !!. != !== !~
                          ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                          ;; ?? ??? ?:  ?=  ?.
                          ("?" (rx (or ":" "=" "\." (+ "?"))))
                          ;; %% %%%
                          ("%" (rx (+ "%")))
                          ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                          ;; |->>-||-<<-| |- |== ||=||
                          ;; |==>>==<<==<=>==//==/=!==:===>
                          ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                          "-" "=" ))))
                          ;; \\ \\\ \/
                          ("\\" (rx (or "/" (+ "\\"))))
                          ;; ++ +++ ++++ +>
                          ("+" (rx (or ">" (+ "+"))))
                          ;; :: ::: :::: :> :< := :// ::=
                          (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                          ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                          ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                          "="))))
                          ;; .. ... .... .= .- .? ..= ..<
                          ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                          ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                          ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                          ;; *> */ *)  ** *** ****
                          ("*" (rx (or ">" "/" ")" (+ "*"))))
                          ;; www wwww
                          ("w" (rx (+ "w")))
                          ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                          ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                          ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                          ;; << <<< <<<<
                          ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                          "-"  "/" "|" "="))))
                          ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                          ;; >> >>> >>>>
                          (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                          ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                          ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                       (+ "#"))))
                          ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                          ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                          ;; __ ___ ____ _|_ __|____|_
                          ("_" (rx (+ (or "_" "|"))))
                          ;; Fira code: 0xFF 0x12
                          ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                          ;; Fira code:
                          "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                          ;; The few not covered by the regexps.
                          "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" default))
 '(package-selected-packages '(gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
