(in-package :rock)

(defclass <source> () ())

(defclass <google-cdn> (<source>)
  ((name :reader name
         :initarg :name
         :type string)
   (js-filename :reader js-filename
                :initarg :js-filename
                :type string)
   (css-filename :reader css-filename
                 :initarg :css-filename
                 :type string)
   (versions :reader versions
             :initarg :versions
             :type list)))

(defclass <maxcdn> (<source>)
  ((library :reader library
            :initarg :library
            :type string)
   (versions :reader versions
             :initarg :versions
             :type list)
   (js-filename :reader js-filename
                :initarg :js-filename
                :type string)
   (css-filename :reader css-filename
                 :initarg :css-filename
                 :type string)))

(defclass <cdnjs> (<source>)
  ((library :reader library
            :initarg :library
            :type string)
   (versions :reader versions
             :initarg :versions
             :type list)
   (files :reader files
          :initarg :files
          :type list)))

(defclass <github> (<source>)
  ((user :reader user
         :initarg :user
         :type string)
   (repo :reader repo
         :initarg :repo
         :type string)
   (versions :reader versions
             :initarg :versions
             :type list)
   (path :reader path
         :initarg :path
         :type string)))
