(in-package :cl-user)
(defpackage rock-test
  (:use :cl :fiveam))
(in-package :rock-test)

(defparameter +assets-directory+
  (asdf:system-relative-pathname :rock #p"assets/"))

(defun asset-relative-path (path)
  (merge-pathnames path +assets-directory+))

(def-suite tests)
(in-suite tests)

(test define-environment
  (finishes
    (rock:defenv :rock-test
      :assets ((:jquery :2.1.0)
               (:jquery :1.9.1)
               (:composer.js :1.0))
      :bundles ((;; Old jquery + composer
                 :js
                 :assets ((:jquery :2.1.0)
                          (:composer.js :1.0))
                 :destination #p"js/old.js")))))

(defun destroy-assets-directory ()
  (when (cl-fad:directory-exists-p +assets-directory+)
     (cl-fad:delete-directory-and-files
      +assets-directory+)))

(test setup
  (finishes
    (destroy-assets-directory)))

(test build
  (finishes
    (rock:build :rock-test))
  (is-true
   (probe-file
    (asset-relative-path #p"jquery-2.1.0/jquery.min.js")))
  (is-true
   (probe-file
    (asset-relative-path #p"jquery-1.9.1/jquery.min.js")))
  (is-true
   (probe-file
    (asset-relative-path #p"composer.js-1.0/composer.min.js")))
  (is-true
   (probe-file
    (asset-relative-path #p"build/js/old.js"))))

(test cleanup
  (finishes
    (destroy-assets-directory)))

(run! 'tests)
