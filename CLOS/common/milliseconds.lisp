
(defun current-time-millis () 
    (* (get-internal-real-time) (/ 1000 INTERNAL-TIME-UNITS-PER-SECOND)))

(setf start-time (current-time-millis))
;(format t "~A~%" (current-time-millis))

(do ((x 0 (+ 1 x)))
        ((> x 99999))
    ;(print x))
    )

(setf end-time (current-time-millis))

(format t "~A ms elapsed~%" (- end-time start-time))
(quit)
