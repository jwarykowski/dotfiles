;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jonathan Warykowski"
      user-mail-address "jonathan@warykowski.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq
 doom-font (font-spec :family "JetBrains Mono" :size 18 :weight 'Regular)
 doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 18 :weight 'Regular)
)

;; prevent killing emacs
(setq confirm-kill-emacs nil)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; key bindings
(map!
 ;; evil
 :n "RET"     #'evil-goto-line

 ;; directory navigation
 :n "-"       #'deer

 ;; window navigation
 :n "C-h"     #'evil-window-left
 :n "C-j"     #'evil-window-down
 :n "C-k"     #'evil-window-up
 :n "C-l"     #'evil-window-right

 ;; leader key mappings
 (:leader
        :desc "Workspace 1"             :nv "1"  #'+workspace/switch-to-0
        :desc "Workspace 2"             :nv "2"  #'+workspace/switch-to-1
        :desc "Workspace 3"             :nv "3"  #'+workspace/switch-to-2
        :desc "Workspace 4"             :nv "4"  #'+workspace/switch-to-3
        :desc "Workspace 5"             :nv "5"  #'+workspace/switch-to-4
        :desc "Workspace 6"             :nv "6"  #'+workspace/switch-to-5
        :desc "Workspace 7"             :nv "7"  #'+workspace/switch-to-6
        :desc "Workspace 8"             :nv "8"  #'+workspace/switch-to-7
        :desc "Workspace 9"             :nv "9"  #'+workspace/switch-to-8
        :desc "Project search"          :nv "/"  #'+default/project-search
        :desc "M-x"                     :nv ";"  #'execute-extended-command
        :desc "list projects"           :nv "l"  #'+workspace/display
        (:desc "file" :prefix "f"
                :desc "save"     :n "S" #'save-buffer
                :desc "save all" :n "s" (lambda() (interactive) (save-some-buffers t) ))
        (:desc "project" :prefix "p"
                :desc "switch project" :n "l" #'projectile-switch-project)
        (:desc "open" :prefix "o"
                :desc "personal" :n "n" (lambda() (interactive) (find-file "~/org/personal.org"))
                :desc "work" :n "w" (lambda() (interactive) (find-file "~/org/lighthouse.org"))
                :desc "scratch" :n "s" (lambda() (interactive) (find-file "~/org/scratch.org")))
        )
)

;; which-key
(setq which-key-idle-delay 0.1)

;; tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; company aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; org mode
(setq org-agenda-files (list "~/org/lighthouse.org" "~/org/personal.org"))
