;;; packages.el --- Spacemacs Editing Visual Layer packages File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq spacemacs-editing-visual-packages
      '(
        ;; default
        adaptive-wrap
        column-enforce-mode
        (hide-comnt :location local)
        highlight-numbers
        ;; waiting for an overlay bug to be fixed
        ;; see https://github.com/syl20bnr/spacemacs/issues/2529
        (hl-anything :excluded t)
        volatile-highlights
        ))

;; Initialization of packages

(defun spacemacs-editing-visual/init-adaptive-wrap ()
  (use-package adaptive-wrap
    :config
    (progn
      (add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode))))

(defun spacemacs-editing-visual/init-column-enforce-mode ()
  (use-package column-enforce-mode
    :commands (column-enforce-mode global-column-enforce-mode)
    :init
    (progn
      (spacemacs|add-toggle highlight-long-lines
        :status column-enforce-mode
        :prefix columns
        :on (column-enforce-n (or columns column-enforce-column))
        :on-message (format "long-lines enabled for %s columns." (or columns column-enforce-column))
        :off (column-enforce-mode -1)
        :documentation "Highlight the characters past the 80th column."
        :evil-leader "t8")
      (spacemacs|add-toggle highlight-long-lines-globally
        :mode global-column-enforce-mode
        :documentation "Globally Highlight the characters past the 80th column."
        :evil-leader "t C-8"))
    :config (spacemacs|diminish column-enforce-mode "⑧" "8")))

(defun spacemacs-editing-visual/init-hide-comnt ()
  (use-package hide-comnt
    :commands hide/show-comments-toggle
    :init (spacemacs/set-leader-keys "ch" 'hide/show-comments-toggle)))

(defun spacemacs-editing-visual/init-highlight-numbers ()
  (use-package highlight-numbers
    :defer t
    :init
    (progn
      (add-hook 'prog-mode-hook 'highlight-numbers-mode)
      (add-hook 'asm-mode-hook (lambda () (highlight-numbers-mode -1))))))

(defun spacemacs-editing-visual/init-hl-anything ()
  (use-package hl-anything
    :init
    (progn
      (hl-highlight-mode)
      (setq-default hl-highlight-save-file
                    (concat spacemacs-cache-directory ".hl-save"))
      (spacemacs/set-leader-keys
        "hc"  'hl-unhighlight-all-local
        "hC"  'hl-unhighlight-all-global
        "hh"  'hl-highlight-thingatpt-local
        "hH"  'hl-highlight-thingatpt-global
        "hn"  'hl-find-next-thing
        "hN"  'hl-find-prev-thing
        "hr"  'hl-restore-highlights
        "hs"  'hl-save-highlights))
    :config (spacemacs|hide-lighter hl-highlight-mode)))

(defun spacemacs-editing-visual/init-volatile-highlights ()
  (use-package volatile-highlights
    :config
    (progn
      ;; additional extensions
      ;; evil
      (vhl/define-extension 'evil
                            'evil-move
                            'evil-paste-after
                            'evil-paste-before
                            'evil-paste-pop)
      (with-eval-after-load 'evil
        (vhl/install-extension 'evil)
        (vhl/load-extension 'evil))
      ;; undo-tree
      (vhl/define-extension 'undo-tree
                            'undo-tree-move
                            'undo-tree-yank)
      (with-eval-after-load 'undo-tree
        (vhl/install-extension 'undo-tree)
        (vhl/load-extension 'undo-tree))
      (volatile-highlights-mode)
      (spacemacs|hide-lighter volatile-highlights-mode))))
