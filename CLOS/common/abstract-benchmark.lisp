(in-package #:cl-user)

#-:cormanlisp
(defpackage #:oobench-common
  (:use cl))

#+:comanlisp
(defpackage "OOBENCH-COMMON"
  (:use "CL"))

(in-package #:oobench-common)

(defconstant *space* "...............")
(defconstant *back* "................")

(defun get-current-time-millis () 
    (* (get-internal-real-time) (/ 1000 INTERNAL-TIME-UNITS-PER-SECOND)))

(defclass abstract-benchmark ()
  ((internal-count :initform 0)
   (refresh-counter :initform 0)
   (watermark :initform 0)
   (then)
   (verify :initform NIL)
   (slow)
   (accurate :initform T)
   (test-only :initform NIL)
   (timer :initform (make-instance 'stop-watch))
   (memory-at-begin)
   (small-scale)))

(defmethod get-major-number ((b abstract-benchmark))
  (error "Must be overridden in subclass!~%"))

(defmethod get-minor-number ((b abstract-benchmark))
  (error "Must be overridden in subclass!~%"))

(defmethod reset ((b abstract-benchmark))
  (setf (slot-value b 'slow) (not (slot-value b 'accurate)))
  (if (slot-value b 'accurate)
    (return-from reset))
  (setf (slot-value b 'internal-count) 0
	(slot-value b 'refresh-counter) 0
	(slot-value b 'then) (get-current-time-millis)
	(slot-value b 'watermark) 99))

(defmethod action ((b abstract-benchmark) sub-number
		   message count comment)
  ;memory-at-begin
  (format T "Lisp: [~A.~A.~A] ~A (~A)~@[-- ~A~]: "
	  (get-major-number b) (get-minor-number b)
	  sub-number message count comment)
  (start (slot-value 'timer) (reset (slot-value 'timer)))
  ; command here.
  (stop (slot-value 'timer))
  (format T "~A ms (~A)~%" (get-elapsed-time (slot-value 'timer))
	  (beautify-bytes (- (get-used-memory()))
			  (slot-value 'memory-at-begin))))

(defmethod action ((b abstract-benchmark) sub-number message count)
  (action (b sub-number message count NIL)))
  

(defconstant *measure-names*
  `("B" "KB" "M" "GB" "TB"))

(defun beautify-bytes (byte-count)
  (let ((f byte-count)
	(m 0))
    (loop while (> f 1024) do
      (progn
	(incf m)
	(setf f (truncate (/ f 1024)))))
    (loop while (< f -1024) do
      (progn
	(incf m)
	(setf f (truncate (/ f 1024)))))
    (return-from beautify-bytes
      (format nil "~A ~A" f (nth m *measure-names*)))))
     
	  
(defmethod count-with-default ((b abstract-benchmark) count)
  (if (slot-value b 'test-only)
      (return-from count-with-default 1)
    (return-from count-with-default count)))
