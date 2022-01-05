;; Author: Leonardo Tamiano

;; This function is used to construct the string binary representation
;; of a given number.

;; (int2bin 1337) --> "10100111001"

(defun int2bin (i)
  (defun int2bin-rec (i res)
    (cond ((= i 0) (concat "0" res))
	  ((= i 1) (concat "1" res))
	  ('t
	   (int2bin-rec (lsh i -1)
			 (concat (format "%s" (logand i 1))
				 res)))))
  (int2bin-rec i ""))
