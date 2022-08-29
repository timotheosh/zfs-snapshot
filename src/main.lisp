(defpackage zfs-snapshot
  (:use :cl)
  (:export :-main))
(in-package :zfs-snapshot)


(defun -main (&rest args)
  (v:start v:*global-controller*)
  (format t "Hello, world!~%"))
