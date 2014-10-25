(in-package :cl-user)
(defpackage rock-web-asd
  (:use :cl :asdf))
(in-package :rock-web-asd)

(defsystem rock-web
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:rock
               :cl-markup
               :lass)
  :components ((:module "web"
                :serial t
                :components
                ((:file "templates")
                 (:file "files")))))
