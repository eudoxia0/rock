(in-package :rock)

;;; Environment and bundle classes

(defclass <asset-instance> ()
  ((name :reader name
          :initarg :name
          :type keyword)
   (version :reader version
            :initarg :version
            :type keyword)))

(defmethod get-asset ((asset <asset-instance>))
  (find-asset (name asset)))

(defclass <bundle> ()
  ((kind :reader kind
         :initarg :kind
         :type keyword)
   (assets :reader assets
           :initarg :assets
           :type (list-of <asset-instance>))
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
   (assets :reader assets
           :initarg :assets
           :type (list-of <asset-instance>))
   (bundles :reader bundles
            :initarg :bundles
            :type (list-of <bundle>))))

;;; Methods for downloading the assets

(defmethod full-assets-pathname ((env <environment>))
  (asdf:system-relative-pathname (system-name env)
                                 (assets-directory env)))

(defmethod env-relative-pathname ((env <environment>) (path pathname))
  (merge-pathnames path
                   (full-assets-pathname env)))

(defmethod asset-directory ((asset <asset-instance>) (env <environment>))
  (let ((asset-name (string-downcase (symbol-name (name asset)))))
    (env-relative-pathname env
                           (make-pathname
                            :directory (list :relative asset-name)))))

(defmethod asset-local-pathname ((asset <asset-instance>) (env <environment>)
                                 (file string))
  (merge-pathnames (parse-namestring file)
                   (asset-directory asset env)))

(defmethod download-asset ((asset <asset-instance>) (env <environment>))
  (let ((base-asset (get-asset asset)))
    (loop for js-file in (js base-asset) do
      (let ((remote (file-url base-asset (version asset) js-file))
            (local (asset-local-pathname asset env js-file)))
        (print remote)
        (print local)))))

(defmethod build ((env <environment>))
  ;; Download all the dependencies
  (loop for asset in (assets env) do
    (download-asset asset env)))

;;; Macros

(defmacro make-asset (name version)
  `(make-instance '<asset-instance>
                  :name ,name
                  :version ,version))

(defun make-bundle (kind &key assets destination)
  `(make-instance '<bundle>
                  :kind ,kind
                  :assets (list
                           ,@(loop for asset in assets collecting
                               `(make-asset ,@asset)))
                  :destination ,destination))

(defmacro defenv (system-name &key assets bundles
                                (assets-directory #p"assets/"))
  `(make-instance '<environment>
                  :system-name ,system-name
                  :assets-directory ,assets-directory
                  :assets (list
                           ,@(loop for asset in assets collecting
                               `(make-asset ,@asset)))
                  :bundles (list
                            ,@(loop for bundle in bundles collecting
                                `(make-bundle ,@bundle)))))
