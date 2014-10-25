(in-package :rock)

;;; Bundles and Environments

(defclass <bundle> ()
  ((kind :reader kind
         :initarg :kind
         :type keyword
         :documentation "A `:js` bundle or a `:css` bundle.")
   (assets :reader assets
           :initarg :assets
           :type (list-of <asset-version>)
           :documentation "The assets from the environment that will be bundled.")
   (files :reader files
          :initarg :files
          :type (list-of pathname))
   (destination :reader destination
                :initarg :destination
                :type pathname
                :documentation "The pathname of the compiled bundle."))
  (:documentation "A bundle is a collection of assets and static files. Those
  files, and the files corresponding to the bundle's kind in each asset, will be
  concatenated together into the destination pathname."))

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

(defmethod env-build-directory ((env <environment>))
  (env-relative-pathname env #p"build/"))

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

(defmethod download-file-list ((asset-v <asset-version>) (env <environment>) files)
  (loop for file in files do
    (let ((remote (file-url asset-v file))
          (local (asset-local-pathname asset-v env file)))
      (trivial-download:download remote local))))

(defmethod download-asset ((asset-v <asset-version>) (env <environment>))
  "Download all the files in an asset."
  (let ((base-asset (asset asset-v)))
    (when (slot-boundp base-asset 'js)
      (download-file-list asset-v env (js base-asset)))
    (when (slot-boundp base-asset 'css)
      (download-file-list asset-v env (css base-asset)))
    (when (slot-boundp base-asset 'files)
      (download-file-list asset-v env (files base-asset)))))

(defmethod build-bundle ((bundle <bundle>) (env <environment>))
  (let* ((files-to-concatenate
           (loop for asset-v in (assets bundle) appending
             (case (kind bundle)
               (:js
                (loop for file in (js (asset asset-v)) collecting
                  (asset-local-pathname asset-v env file)))
               (:css
                (loop for file in (css (asset asset-v)) collecting
                  (asset-local-pathname asset-v env file)))
               (t
                (error "Unknown bundle kind."))))))
    (when (slot-boundp bundle 'files)
      (let* ((extra-files (files bundle))
             (full-file-pathnames
               (loop for file in extra-files collecting
                 (env-relative-pathname env file))))
        (setf files-to-concatenate
              (append files-to-concatenate
                      full-file-pathnames))))
    (concatenate-files files-to-concatenate
                       (merge-pathnames (destination bundle)
                                        (env-build-directory env)))))

(defmethod build-env ((env <environment>))
  "Build an environment: Download all dependencies and build all its bundles."
  ;; Download all the dependencies
  (loop for asset-v in (dependencies env) do
    (download-asset asset-v env))
  ;; Build the bundles
  (loop for bundle in (bundles env) do
    (build-bundle bundle env)))
