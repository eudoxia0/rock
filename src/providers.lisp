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

(defgeneric file-url (source version filepath)
  (:documentation "The full URL of a file in a particular subclass of
  `<source>`."))

(defmethod file-url ((source <google-cdn>) version filepath)
  (format nil "https://ajax.googleapis.com/ajax/libs/~A/~A/~A"
          (name source) version filepath))

(defmethod file-url ((source <maxcdn>) version filepath)
  (format nil "https://maxcdn.bootstrapcdn.com/~A/~A/~A"
          (library source) version filepath))

(defmethod file-url ((source <cdnjs>) version filepath)
  (format nil "https://cdnjs.cloudflare.com/ajax/libs/~A/~A/~A"
          (library source) version filepath))

(defmethod file-url ((source <github>) version filepath)
  (format nil "https://raw.githubusercontent.com/~A/~A/~A/~A"
          (user source)
          (repo source)
          (cdr (assoc version (versions source)))
          filepath))
