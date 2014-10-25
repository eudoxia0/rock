(in-package :cl-user)
(defpackage rock-web.tmpl
  (:use :cl :cl-markup)
  (:export :index))
(in-package :rock-web.tmpl)

(defun head ()
  (markup
   (:head
    (:meta :charset "utf-8")
    (:meta :http-equiv "X-UA-Compatible" :content "IE=edge")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    (:title "Rock")
    (:link :rel "stylesheet" :href "web/style.css"))))

(defmacro page (&rest content)
  `(html5
    (raw (head))
    (:body
     ,@content)))

(defun index ()
  (page
   (:h1 "Rock")))
