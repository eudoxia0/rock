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

;;; Available assets

(defmethod version-list ((asset rock::<asset>))
  (rock::versions asset))

(defmethod version-list ((asset rock::<github-asset>))
  (loop for pair in (rock::versions asset) collecting
    (first pair)))

(defun available-assets ()
  (markup
   (:div :class "list-group"
     (loop for asset-name being the hash-key of rock::*assets*
           using (hash-value asset) collecting
       (markup
        (:div :class "list-group-item"
          (:h4 :class "list-group-item-heading"
            (:code asset-name))
          (:p :class "list-group-item-text"
            "Versions: "
            (format nil "~{~A~#[~:;, ~]~}"
                    (loop for version in (version-list asset) collecting
                      (rock::version-string version))))))))))

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
    (raw +desc+)
    (:section :id "assets"
              (:h1 "Available Assets")
              (raw (available-assets))))))
