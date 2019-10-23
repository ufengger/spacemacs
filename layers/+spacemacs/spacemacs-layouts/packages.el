;;; packages.el --- Spacemacs Layouts Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq spacemacs-layouts-packages
      '(eyebrowse
        ivy
        ))



(defun spacemacs-layouts/init-eyebrowse ()
  (use-package eyebrowse
    :init
    (progn
      (setq eyebrowse-wrap-around t)
      (eyebrowse-mode)
      ;; transient state
      (spacemacs|transient-state-format-hint workspaces
        spacemacs--workspaces-ts-full-hint
        "\n\n
 Go to^^^^^^                         Actions^^
 ─────^^^^^^───────────────────────  ───────^^──────────────────────
 [_0_.._9_]^^     nth/new workspace  [_d_] close current workspace
 [_C-0_.._C-9_]^^ nth/new workspace  [_R_] rename current workspace
 [_<tab>_]^^^^    last workspace     [_?_] toggle help\n
 [_l_]^^^^        layouts
 [_n_/_C-l_]^^    next workspace
 [_N_/_p_/_C-h_]  prev workspace\n")

      (spacemacs|define-transient-state workspaces
        :title "Workspaces Transient State"
        :hint-is-doc t
        :dynamic-hint (spacemacs//workspaces-ts-hint)
        :bindings
        ("?" spacemacs//workspaces-ts-toggle-hint)
        ("0" eyebrowse-switch-to-window-config-0 :exit t)
        ("1" eyebrowse-switch-to-window-config-1 :exit t)
        ("2" eyebrowse-switch-to-window-config-2 :exit t)
        ("3" eyebrowse-switch-to-window-config-3 :exit t)
        ("4" eyebrowse-switch-to-window-config-4 :exit t)
        ("5" eyebrowse-switch-to-window-config-5 :exit t)
        ("6" eyebrowse-switch-to-window-config-6 :exit t)
        ("7" eyebrowse-switch-to-window-config-7 :exit t)
        ("8" eyebrowse-switch-to-window-config-8 :exit t)
        ("9" eyebrowse-switch-to-window-config-9 :exit t)
        ("C-0" eyebrowse-switch-to-window-config-0)
        ("C-1" eyebrowse-switch-to-window-config-1)
        ("C-2" eyebrowse-switch-to-window-config-2)
        ("C-3" eyebrowse-switch-to-window-config-3)
        ("C-4" eyebrowse-switch-to-window-config-4)
        ("C-5" eyebrowse-switch-to-window-config-5)
        ("C-6" eyebrowse-switch-to-window-config-6)
        ("C-7" eyebrowse-switch-to-window-config-7)
        ("C-8" eyebrowse-switch-to-window-config-8)
        ("C-9" eyebrowse-switch-to-window-config-9)
        ("<tab>" eyebrowse-last-window-config)
        ("C-h" eyebrowse-prev-window-config)
        ("C-i" eyebrowse-last-window-config)
        ("C-l" eyebrowse-next-window-config)
        ("d" eyebrowse-close-window-config)
        ("l" spacemacs/layouts-transient-state/body :exit t)
        ("n" eyebrowse-next-window-config)
        ("N" eyebrowse-prev-window-config)
        ("p" eyebrowse-prev-window-config)
        ("R" spacemacs/workspaces-ts-rename :exit t)
        ("w" eyebrowse-switch-to-window-config :exit t))
      ;; note: we don't need to declare the `SPC l w' binding, it is
      ;; declare in the layout transient state
      (spacemacs/set-leader-keys "bW" 'spacemacs/goto-buffer-workspace)
      ;; vim-style tab switching
      (define-key evil-motion-state-map "gt" 'eyebrowse-next-window-config)
      (define-key evil-motion-state-map "gT" 'eyebrowse-prev-window-config))))



(defun spacemacs-layouts/post-init-ivy ()
  (spacemacs/set-leader-keys
    "Bb" 'spacemacs-layouts/non-restricted-buffer-list-ivy))

