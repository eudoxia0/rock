(in-package :rock)

(defclass <source> ()
  ((js :reader js
       :initarg :js
       :type (list-of string))
   (css :reader css
        :initarg :css
        :type (list-of string))
   (files :reader files
          :initarg :files
          :type (list-of string))))

(defclass <google-cdn> (<source>)
  ((name :reader name
         :initarg :name
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
             :type list)))

(defclass <cdnjs> (<source>)
  ((library :reader library
            :initarg :library
            :type string)
   (versions :reader versions
             :initarg :versions
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
             :type list)))
