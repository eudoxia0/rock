(in-package :cl-user)
(defpackage rock-test
  (:use :cl :fiveam))
(in-package :rock-test)

(def-suite tests)
(in-suite tests)

(rock:defenv :rock-test
  :assets ((:jquery :2.1.0)
           (:jquery :1.9.1)
           (:composer.js :1.0))
  :bundles ((;; Old jquery, standalone
             :js
             :assets ((:jquery :2.1.0))
             :destination #p"js/old.js")))

(test simple
  (is (equal 1 1)))

(run! 'tests)
