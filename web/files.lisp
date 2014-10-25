(in-package :cl-user)
(defpackage rock-web.files
  (:use :cl)
  (:export :index))
(in-package :rock-web.files)

(defparameter +index+
  (asdf:system-relative-pathname :rock #p"index.html"))
(defparameter +stylesheet+
  (asdf:system-relative-pathname :rock #p"web/style.lass"))

(defun write-file (pathname content)
  (with-open-file (stream pathname
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (write-string content stream)))

(write-file +index+ (rock-web.tmpl:index))
(lass:generate +stylesheet+)
