
(in-package :zfs-snapshot)

(opts:define-opts
  (:name :help
   :description "print this help text"
   :short #\h
   :long "help")
  (:name :frequency
   :description "snapshots marked for a frequency (quarterly, hourly, daily, weekly, monthly, annually)"
   :short #\f
   :long "frequency"
   :arg-parser #'identity
   :meta-var "FREQUENCY"))

(defparameter *frequency-options* '("quarterly" "hourly" "daily" "weekly" "monthly" "annually"))

(defun unknown-option (condition)
  (format t "warning: ~s option is unknown!~%" (opts:option condition))
  (invoke-restart 'opts:skip-option))

(defun -main (&rest args)
  (v:start v:*global-controller*)
  (setf (v:repl-level) :debug)
  (v:output-here *standard-output*)
  ;;(v:output-here (open #p"some-file.log" :direction :output))
  (multiple-value-bind (options args)
      (handler-case
          (handler-bind ((opts:unknown-option #'unknown-option))
            (opts:get-opts))
        (opts:missing-arg (condition)
          (format t "option ~s needs an argument!~%" (opts:option condition)))
        (opts:arg-parser-failed (condition)
          (format t "Cannot parse  ~s as argum,ent of ~s~%"
                  (opts:raw-arg condition)
                  (opts:option condition))))
    (cond ((getf options :help) (progn (opts:describe
                                        :prefix (format nil "zfs-snapshot manages ZFS snapshots.")
                                        :usage-of "zfs-snapshot")
                                       (opts:exit 1)))
          ((getf options :frequency) (if (member (getf options :frequency) *frequency-options* :test #'string=)
                                         (format t "~A~%" (getf options :frequency))
                                         (format t "'~A' is not one of ~{~A ~}~%" (getf options :frequency) *frequency-options*)))
          (t (format t "NO OPTIONS")))))
