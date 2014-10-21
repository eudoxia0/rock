(in-package :rock)

(defclass <asset-instance> ()
  ((asset :reader asset
          :initarg :asset
          :type keyword)
   (version :reader version
            :initarg :version
            :type keyword)))

(defclass <bundle> ()
  ((kind :reader kind
         :initarg :kind
         :type keyword)
   (assets :reader assets
           :initarg :assets
           :type (list-of keyword))
   (destination :reader destination
                :initarg :destination
                :type pathname)))

(defclass <environment> ()
  ((system-name :reader system-name
                :initarg :system-name
                :type keyword)
   (assets-directory :reader assets-directory
                     :initarg :assets-directory
                     :type pathname)
   (assets :reader assets
           :initarg :assets
           :type (list-of <asset-instance>))
   (bundles :reader bundles
            :initarg :bundles
            :type (list-of <bundle>))))

(defmethod full-assets-pathname ((env <environment>))
  (asdf:system-relative-pathname (system-name env)
                                 (assets-directory env)))

(defmethod env-relative-pathname ((env <environment>) (path pathname))
  (merge-pathnames path
                   (full-assets-pathname env)))
