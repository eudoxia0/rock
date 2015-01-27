(in-package :cl-user)
(defpackage rock-asd
  (:use :cl :asdf))
(in-package :rock-asd)

(defsystem rock
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :maintainer "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "MIT"
  :version "0.1"
  :homepage "http://eudoxia.me/rock/"
  :bug-tracker "https://github.com/eudoxia0/rock/issues"
  :source-control (:git "git@github.com:eudoxia0/rock.git")
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
