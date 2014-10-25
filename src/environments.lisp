(in-package :rock)

;;; Bundles and Environments

(defclass <bundle> ()
  ((kind :reader kind
         :initarg :kind
         :type keyword)
   (assets :reader assets
           :initarg :assets
           :type (list-of <asset-version>))
   (destination :reader destination
                :initarg :destination
                :type pathname)))

(defclass <environment> ()
  ((system-name :reader system-name
                :initarg :system-name
                :type keyword)
   (assets-directory :reader assets-directory
                     :initarg :assets-directory
                     :initform #p"assets/"
                     :type pathname)
   (dependencies :reader dependencies
                 :initarg :dependencies
                 :type (list-of <asset-version>))
   (bundles :reader bundles
            :initarg :bundles
            :type (list-of <bundle>))))

(defparameter *environments*
  (make-hash-table))

(defun get-env (system-name)
  (gethash system-name *environments*))

;;; Methods for downloading the assets

(defmethod full-assets-directory ((env <environment>))
  "The absolute path to an environment's assets directory."
  (asdf:system-relative-pathname (system-name env)
                                 (assets-directory env)))

(defmethod env-relative-pathname ((env <environment>) (path pathname))
  "A pathname relative to an environment's assets directory."
  (merge-pathnames path
                   (full-assets-directory env)))

(defmethod asset-directory-name ((asset-v <asset-version>))
  (concatenate 'string
               (name (asset asset-v))
               "-"
               (string-downcase (symbol-name (version asset-v)))))

(defmethod asset-directory ((asset-v <asset-version>) (env <environment>))
  "The directory of an asset version within an environment."
  (env-relative-pathname
   env
   (make-pathname
    :directory (list :relative (asset-directory-name asset-v)))))

(defmethod asset-local-pathname ((asset-v <asset-version>) (env <environment>)
                                 (file string))
  "The local pathname of an asset version's file in an environment."
  (merge-pathnames (parse-namestring file)
                   (asset-directory asset-v env)))

(defmethod download-asset ((asset-v <asset-version>) (env <environment>))
  "Download all the files in an asset."
  (let ((base-asset (asset asset-v)))
    (loop for js-file in (js base-asset) do
      (let ((remote (file-url asset-v js-file))
            (local (asset-local-pathname asset-v env js-file)))
        (trivial-download:download remote local)))))

(defmethod build-bundle ((bundle <bundle>)))

(defmethod build-env ((env <environment>))
  "Build an environment: Download all dependencies and build all its bundles."
  ;; Download all the dependencies
  (loop for asset-v in (dependencies env) do
    (download-asset asset-v env))
  ;; Build the bundles
  (loop for bundle in (bundles env) do
    (build-bundle bundle)))
