(in-package :rock)

(defclass <environment> ()
  ((system-name :reader system-name
                :initarg :system-name
                :type keyword)
   (assets-directory :reader assets-directory
                     :initarg :assets-directory
                     :type pathname)))

(defmethod full-assets-pathname ((env <environment>))
  (asdf:system-relative-pathname (system-name env)
                                 (assets-directory env)))

(defmethod env-relative-pathname ((env <environment>) (path pathname))
  (merge-pathnames path
                   (full-assets-pathname env)))
