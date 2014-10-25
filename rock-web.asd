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
  :components ((:module "assets/css"
                :components
                ((:static-file "style.lass")))
               (:module "web"
                :serial t
                :components
                ((:file "website")
                 (:file "files")
                 ;;; Assets are compiled last, the LASS has to be converted to
                 ;;; CSS first
                 (:file "assets")))))
