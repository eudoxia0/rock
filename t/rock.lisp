(in-package :cl-user)
(defpackage rock-test
  (:use :cl :fiveam))
(in-package :rock-test)

(def-suite tests)
(in-suite tests)

(test define-environment
  (finishes
    (rock:defenv :rock-test
      :assets ((:jquery :2.1.0)
               (:jquery :1.9.1)
               (:composer.js :1.0))
      :bundles ((;; Old jquery, standalone
                 :js
                 :assets ((:jquery :2.1.0))
                 :destination #p"js/old.js")))))

(test setup
  (finishes
    (cl-fad:delete-directory-and-files
     (asdf:system-relative-pathname :rock #p"assets/"))))

(test build
  (finishes
    (rock:build :rock-test))
  (is-true
   (probe-file
    (asdf:system-relative-pathname :rock
                                   #p"assets/jquery-2.1.0/jquery.min.js")))
  (is-true
   (probe-file
    (asdf:system-relative-pathname :rock
                                   #p"assets/jquery-1.9.1/jquery.min.js")))
  (is-true
   (probe-file
    (asdf:system-relative-pathname :rock
                                   #p"assets/composer.js-1.0/composer.min.js"))))

(run! 'tests)
