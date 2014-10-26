(in-package :cl-user)
(defpackage rock-web-asd
  (:use :cl :asdf))
(in-package :rock-web-asd)

(defsystem rock-web
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:rock
               :cl-markup
               :lass
               :3bmd
               :3bmd-ext-code-blocks
               :3bmd-ext-definition-lists)
  :serial t
  :components ((:module "assets"
                :components
                ((:module "css"
                  :components
                  ((:static-file "style.lass")))
                 (:module "js"
                  :components
                  ((:static-file "scripts.js")))))
               (:module "web"
                :serial t
                :components
                ((:static-file "desc.md")
                 (:file "website")
                 (:file "files")
                 ;;; Assets are compiled last, the LASS has to be converted to
                 ;;; CSS first
                 (:file "assets")))))
