
;; ----------------------------------------------------------------------------------
;;
;;
;; ----------------------------------------------------------------------------------
(defun gx/alt-forward (&optional n)
  (interactive "P") 
  (if (thing-at-point 'word)
      (forward-to-word 1)
      (forward-word)
    ))

;;
;; (defun gx/scroll-view-backward-line (&optional lines)
;;   (interactive "P")
;;   ;;(view-scroll-lines lines t 1 t)
;;   (scroll-up-line))

;;
;; (defun gx/scroll-view-forward-line (&optional lines)
;;   (interactive "P") 
;;   (view-scroll-lines lines nil 1 t)
;;   (scroll-down-line))

;;
(defun gx/scroll-view-forward-line (&optional lines)
  (interactive "P") 
  (view-scroll-lines lines nil 1 t))


;;
(defun gx/scroll-view-backward-line (&optional lines)
  (interactive "P")
  (view-scroll-lines lines t 1 t))





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

(defun gx/is-char-num (c)
  (and  (>=  c  ?0)  (<=  c  ?9)))
      

(defun gx/is-char-alpha (c)
  (or (and (>=  c  ?a) (<= c ?z))
      (and (>=  c  ?A) (<= c ?Z))))
      

(defun gx/is-char-alnum (c)
  (or (gx/is-char-alpha c)
      (gx/is-char-num c)))

;;
(defun gx/kill-whitespace ()
  (while (gx/is-whitespace (char-after))
    (delete-char 1)))

;;
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

;;
;;
;; (defun gx/backward-kill-word (arg)
;;   "kill backward more like windows"
;;   (interactive "p")
;;   (if (gx/is-whitespace (char-before))
;;     ;;  
;;       (gx/backward-kill-whitespace)
;;     ;;
;;     (while (not (gx/is-whitespace (char-before)))
;;       (backward-delete-char 1)) ))

;;
;; (defun gx/backward-kill-word (arg)
;;   "kill backward more like windows"
;;   (interactive "p")
;;   (cond ((gx/is-whitespace (char-before)) (gx/backward-kill-whitespace))
;; 	((gx/is-char-alnum  (char-before)) (while (gx/is-char-alnum (char-before)) (backward-delete-char 1)) )
;; 	(t (backward-delete-char 1))) )


(defun gx/backward-kill-word (arg)
  "kill backward more like windows"
  (interactive "p")
  (cond ((gx/is-whitespace (char-before)) (gx/backward-kill-whitespace))
	((gx/is-char-alnum  (char-before))  (backward-kill-word arg))
	(t (backward-delete-char 1))) )

