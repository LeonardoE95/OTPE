;; Author: Leonardo Tamiano

;; This snippet is used to show the hex bytes of the currently
;; selected text.

;; For example if we select the words `hello world` and execute `M-x
;; my/txt2hex` we get the following in the *out* buffer

;; ---------------------

;; h -> 0x68
;; e -> 0x65
;; l -> 0x6C
;; l -> 0x6C
;; o -> 0x6F
;;   -> 0x20
;; w -> 0x77
;; o -> 0x6F
;; r -> 0x72
;; l -> 0x6C
;; d -> 0x64

;; 0x68656C6C6F20776F726C64

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
