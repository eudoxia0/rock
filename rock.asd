(in-package :cl-user)
(defpackage rock-asd
  (:use :cl :asdf))
(in-package :rock-asd)

(defsystem rock
  :version "0.1"
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:trivial-download
               :trivial-extract
               :trivial-types
               :asdf
               :anaphora)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "files")
                 (:file "assets")
                 (:file "known-assets")
                 (:file "environments")
                 (:file "interface"))))
  :description "Asset manager for Common Lisp."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op rock-test))))
