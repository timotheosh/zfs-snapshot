(defpackage zfs-snapshot/tests/main
  (:use :cl
        :zfs-snapshot
        :rove))
(in-package :zfs-snapshot/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :zfs-snapshot)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
