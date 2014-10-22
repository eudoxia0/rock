(in-package :rock)

;;; Assets

(defclass <asset> ()
  ((name :reader name
         :initarg :name
         :type string
         :documentation "The name of the asset as a string.")
   (js :reader js
       :initarg :js
       :type (list-of string)
       :documentation "A list of JavaScript files.")
   (css :reader css
        :initarg :css
        :type (list-of string)
        :documentation "A list of CSS files.")
   (files :reader files
          :initarg :files
          :type (list-of string)
          :documentation "A list of general assets.")
   (versions :reader versions
             :initarg :versions
             :type list
             :documentation "A list of versions (Each a keyword like `:1.2.3`)."))
  (:documentation "Represents an asset: A collection of files with multiple versions."))

;;; Assets + Providers

(defclass <google-asset> (<asset>) ())

(defclass <bootstrap-cdn-asset> (<asset>) ())

(defclass <cdnjs-asset> (<asset>) ())

(defclass <github-asset> (<asset>)
  ((username :reader username
             :initarg :username
             :type string)))

(defgeneric format-string (asset)
  (:documentation "The format string for a asset's URL with the library name,
  but without the version and filepath."))

(defmethod format-string ((asset <google-asset>))
  (format nil "https://ajax.googleapis.com/ajax/libs/~A/~~A/~~A"
          (name asset)))

(defmethod format-string ((asset <bootstrap-cdn-asset>))
  (format nil "https://maxcdn.bootstrapcdn.com/~A/~~A/~~A"
          (name asset)))

(defmethod format-string ((asset <cdnjs-asset>))
  (format nil "https://cdnjs.cloudflare.com/ajax/libs/~A/~~A/~~A"
          (name asset)))

(defmethod format-string ((asset <github-asset>))
  (format nil "https://raw.githubusercontent.com/~A/~A/~~A/~~A"
          (username asset) (name asset)))

;;; Asset database

(defparameter *assets* (make-hash-table))

(defmacro defasset (name class &rest params)
  `(setf (gethash ,(intern (symbol-name name) :keyword) *assets*)
         (make-instance ',class ,@params)))

(defun find-asset (name)
  (gethash name *assets*))

;;; Asset versions

(defclass <asset-version> ()
  ((asset :reader asset
          :initarg :asset
          :type <asset>)
   (version :reader version
            :initarg :version
            :type keyword))
  (:documentation "A particular version of an asset."))

(defmethod file-url ((asset-v <asset-version>) filepath)
  "The URL to a `filepath` in an asset version `asset-v`."
  (format nil (format-string (asset asset-v))
          (version asset-v) filepath))
