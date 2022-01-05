;; Author: Leonardo Tamiano

;; This snippet is used to show the binary digits of the various bytes
;; of the currently selected text.

;; For example if we select the words `hello world` and execute `M-x
;; my/txt2bin` we get the following in the *out* buffer

;; ---------------------

;; h -> 01101000
;; e -> 01100101
;; l -> 01101100
;; l -> 01101100
;; o -> 01101111
;;   -> 00100000
;; w -> 01110111
;; o -> 01101111
;; r -> 01110010
;; l -> 01101100
;; d -> 01100100

;; 01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100 01100100 

;; ---------------------

(defun my/txt2hex (beg end)
  "opens new buffer *out* which contains the selected text as
well as the hexadecimal bytes of the text."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list nil nil)))
  (if (and beg end)
      (progn
	(let ((word (buffer-substring-no-properties beg end)))
	  (switch-to-buffer-other-window "*out*")
	  (erase-buffer)	  

	  ;; -- first, for each word
	  (dotimes (i (length word))
	    ;; -- write char and hex
	    (insert (format "%c -> 0x%X\n" (aref word i) (aref word i))))
	  
	  (insert "\n")
	  
	  ;; -- then, write each hex byte in a row
	  (insert "0x")
	  (dotimes (i (length word))
	    (insert (format "%X" (aref word i))))

	  ))))
