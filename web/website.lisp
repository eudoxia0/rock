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

(defun index ()
  (page
   (:main
    (:p :class "desc"
        "Rock as an "
        (:strong "asset manager")
        " and "
        (:strong "compiler")
        " for Common Lisp web applications. It downloads different versions of
the most popular web development libraries (Bootstrap, jQuery, FontAwesome,
etc.) and lets you compile them to single files."))))
