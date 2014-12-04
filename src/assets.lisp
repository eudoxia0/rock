(in-package :rock)

;;; Assets

(defclass <asset> () ()
  (:documentation "The base class of all assets."))

(defclass <common-asset> (<asset>)
  ((name :reader name
         :initarg :name
         :type string
         :documentation "The name of the asset as a string.")
   (js :reader js
       :initarg :js
       :type (proper-list string)
       :documentation "A list of JavaScript files.")
   (css :reader css
        :initarg :css
        :type (proper-list string)
        :documentation "A list of CSS files.")
   (files :reader files
          :initarg :files
          :type (proper-list string)
          :documentation "A list of general assets.")
   (versions :reader versions
             :initarg :versions
             :type list
             :documentation "A list of versions (Each a keyword like `:1.2.3`)."))
  (:documentation "The most common kind of asset: A collection of files with
  multiple versions."))

;;; Assets + Providers

(defclass <google-asset> (<common-asset>) ())

(defclass <bootstrap-cdn-asset> (<common-asset>) ())

(defclass <cdnjs-asset> (<common-asset>) ())

(defclass <github-asset> (<common-asset>)
  ((username :reader username
             :initarg :username
             :type string)))

(defmethod version-commit ((asset <github-asset>) version)
  (rest (assoc version (versions asset))))

(defclass <web-asset> (<asset>)
  ((base-url :reader base-url
             :initarg :base-url
             :type string
             :documentation "The base URL for the files in the file slot.")
   (files :reader files
          :initarg :files
          :type (proper-list string)
          :documentation "A list of general assets."))
  (:documentation "A collection of files to download from some base URL. Useful
  for downloading images, etc."))

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
  (aif (gethash name *assets*)
       it
       (error "No such asset: ~A." name)))

;;; Asset versions

(defclass <asset-version> ()
  ((asset :reader asset
          :initarg :asset
          :type <asset>)
   (version :reader version
            :initarg :version
            :type keyword))
  (:documentation "A particular version of an asset."))

(defun version-string (version)
  (string-downcase (symbol-name version)))

(defmethod file-url ((asset-v <asset-version>) filepath)
  "The URL to a `filepath` in an asset version `asset-v`."
  (let ((version
            (if (typep (asset asset-v) '<github-asset>)
                (version-commit (asset asset-v)
                              (version asset-v))
                (version asset-v))))
    (format nil (format-string (asset asset-v)) version filepath)))
