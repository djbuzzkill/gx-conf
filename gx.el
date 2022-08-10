
;; 
(defun gx/set-keyrate (lat rate)
  "set system kbd rate"
  (interactive "nkey latency(ms): \nnkey rate(chars/sec): ")
  (shell-command (format "xset r rate %d %d" lat rate)))

;; 
(defun gx/is-whitespace (c)
  (or (char-equal c 9)
      (char-equal c 10)
      (char-equal c 11)
      (char-equal c 12)
      (char-equal c 13)
      (char-equal c 32) ))


;;
(defun gx/kill-whitespace ()
  (while (gx/is-whitespace (char-after))
    (delete-char 1)))



(defun gx/kill-word (args)
  "die"
  (interactive "p")

  (if (gx/is-whitespace (char-after))
      (gx/kill-whitespace) 
    (kill-word args)))

;;
(defun gx/backward-kill-whitespace ()
  (while (gx/is-whitespace (char-before))
    (backward-delete-char 1)))
	      	      
(defun gx/backward-kill-word (arg)
  "kill backward more like windows"
  (interactive "p")
  (if (gx/is-whitespace (char-before))
      (gx/backward-kill-whitespace)
    (backward-kill-word arg)))
