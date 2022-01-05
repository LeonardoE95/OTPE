;; Author: Leonardo Tamiano
;; Date: 2021-12-06

;; This file defines a function ip that returns a list of all the IPv4
;; addresses of the interfaces activated on the host machine using the
;; command `ip a` and the package `ivy`.
;;
;; From the computed list the user can then choose the specific IP to
;; be copied over the kill-ring, which can later be yanked with `C-y`.

(require 'subr-x)

;; This is set to `nil` to make sure that when executing
;; `shell-command` the output is always sent in the
;; `*Shell Output Buffer*`.
(setq resize-mini-windows nil)

;; -----

(defun list-of-IPs()
  (interactive)
  (shell-command "ip a")
  (switch-to-buffer "*Shell Command Output*")
  (let ((done nil)
	(start-p -1)
	(end-p -1)
	(list-of-ips nil))

    (while (not done)
      (condition-case ex
	  (search-forward "inet ")
	('error (setq done 't)))

      (when (not done)
	(setq start-p (point))
	(search-forward "/")
	(setq end-p (- (point) 1))
	;; (message "%s" (buffer-substring start-p end-p))
	(setq list-of-ips (cons (string-trim (buffer-substring start-p end-p))
				list-of-ips))))
    (kill-current-buffer)
    (delete-other-window)
    list-of-ips))

;; -----

(defun ip()
  (interactive)
  (ivy-read "Choose IP: " (list-of-IPs) :action (lambda (x) (kill-new x))))
