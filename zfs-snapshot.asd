(defsystem "zfs-snapshot"
  :version "0.1.0"
  :author "Tim Hawes"
  :license "MIT"
  :depends-on ("cl-ppcre"
               "unix-opts"
               "local-time"
               "verbose"
               "json-mop")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "CLI tool for managing zfs snapshots from a config file."
  :in-order-to ((test-op (test-op "zfs-snapshot/tests")))
  :build-operation "asdf:program-op"
  :build-pathname "target/zfs-snapshot"
  :entry-point "zfs-snapshot:-main")

(defsystem "zfs-snapshot/tests"
  :author "Tim Hawes"
  :license "MIT"
  :depends-on ("zfs-snapshot"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for zfs-snapshot"
  :perform (test-op (op c) (symbol-call :rove :run c)))
