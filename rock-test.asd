(in-package :cl-user)
(defpackage rock-test-asd
  (:use :cl :asdf))
(in-package :rock-test-asd)

(defsystem rock-test
  :author "Fernando Borretti"
  :license "MIT"
  :description "Rock tests"
  :depends-on (:rock
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "rock")))))
