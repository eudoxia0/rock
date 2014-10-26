(in-package :cl-user)
(defpackage rock-web
  (:use :cl :cl-markup)
  (:export :index))
(in-package :rock-web)

;;; Templates

(defun head ()
  (markup
   (:head
    (:meta :charset "utf-8")
    (:meta :http-equiv "X-UA-Compatible" :content "IE=edge")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    (:title "Rock")
    (:link :rel "stylesheet" :href "assets/build/css/style.css"))))

(defun footer ()
  (markup
   (:footer
    (:ul
     (:li "Made by "
          (:a :href "https://github.com/eudoxia0" "eudoxia"))
     (:li :class "credit"
          "Images by "
          (:a :href "https://www.flickr.com/photos/superfamous/" "superfamous")
          ", licensed under the "
          (:a :href "http://creativecommons.org/licenses/by/3.0/"
              "CC Attribution 3.0")
          " license, via "
          (:a :href "http://thestocks.im/" "thestocks.im"))))
   (:script :src "assets/build/js/scripts.js" "")))

(defun header ()
  (markup
   (:header
    (:h1 :class "title"
         "Rock"))))

(defmacro page (&rest content)
  `(html5
    (raw (head))
    (:body
     (raw (header))
     ,@content
     (raw (footer)))))

;;; Pages

(setf 3bmd-code-blocks:*code-blocks* t
      3bmd:*smart-quotes* t)

(defun parse-markdown (pathname)
  (with-output-to-string (str)
    (3bmd:parse-string-and-print-to-stream
     (uiop:read-file-string pathname)
     str)))

(defparameter +desc+
  (parse-markdown (asdf:system-relative-pathname :rock #p"web/desc.md")))

(defun index ()
  (page
   (:main
    (raw +desc+))))
