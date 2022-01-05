;; Author: Leonardo Tamiano
;; Date: 2021-05-04

;; This function splits the window to create space for a little vterm
;; buffer.

(defun my/vterm-window-split ()
  (interactive)
  (split-window-below -15)
  (other-window 1)
  (switch-to-buffer "*vterminal<1>*"))
