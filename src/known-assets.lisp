(in-package :rock)

;;; Asset database

(defparameter *assets* (make-hash-table))

(defmacro defasset (name class &rest params)
  `(setf (gethash ,(intern (symbol-name name) :keyword) *assets*)
         (make-instance ',class ,@params)))

;;; Google CDN

(defasset angular.js <google-cdn>
  :name "angularjs"
  :js (list "angular.min.js")
  :versions (list :1.2.26
                  :1.2.25
                  :1.2.24
                  :1.2.23
                  :1.2.22
                  :1.2.21
                  :1.2.20
                  :1.2.19
                  :1.2.18
                  :1.2.17
                  :1.2.16
                  :1.2.15
                  :1.2.14
                  :1.2.13
                  :1.2.12
                  :1.2.11
                  :1.2.10
                  :1.2.9
                  :1.2.8
                  :1.2.7
                  :1.2.6
                  :1.2.5
                  :1.2.4
                  :1.2.3
                  :1.2.2
                  :1.2.1
                  :1.2.0
                  :1.0.8
                  :1.0.7
                  :1.0.6
                  :1.0.5
                  :1.0.4
                  :1.0.3
                  :1.0.2
                  :1.0.1
                  :1.3.0-rc.5
                  :1.3.0-rc.4
                  :1.3.0-rc.3
                  :1.3.0-rc.2
                  :1.3.0-rc.1
                  :1.3.0-rc.0
                  :1.3.0-beta.19
                  :1.3.0-beta.18
                  :1.3.0-beta.17
                  :1.3.0-beta.16
                  :1.3.0-beta.15
                  :1.3.0-beta.14
                  :1.3.0-beta.13
                  :1.3.0-beta.12
                  :1.3.0-beta.11
                  :1.3.0-beta.10
                  :1.3.0-beta.9
                  :1.3.0-beta.8
                  :1.3.0-beta.7
                  :1.3.0-beta.6
                  :1.3.0-beta.5
                  :1.3.0-beta.4
                  :1.3.0-beta.3
                  :1.3.0-beta.2
                  :1.3.0-beta.1))

(defasset jquery <google-cdn>
  :name "jquery"
  :js (list "jquery.min.js")
  :versions (list :2.1.1
                  :2.1.0
                  :2.0.3
                  :2.0.2
                  :2.0.1
                  :2.0.0
                  :1.11.1
                  :1.11.0
                  :1.10.2
                  :1.10.1
                  :1.10.0
                  :1.9.1
                  :1.9.0
                  :1.8.3
                  :1.8.2
                  :1.8.1
                  :1.8.0
                  :1.7.2
                  :1.7.1
                  :1.7.0
                  :1.6.4
                  :1.6.3
                  :1.6.2
                  :1.6.1
                  :1.6.0
                  :1.5.2
                  :1.5.1
                  :1.5.0
                  :1.4.4
                  :1.4.3
                  :1.4.2
                  :1.4.1
                  :1.4.0
                  :1.3.2
                  :1.3.1
                  :1.3.0
                  :1.2.6
                  :1.2.3))

(defasset jquery-ui <google-cdn>
  :name "jqueryui"
  :js (list "jquery-ui.min.js")
  :css (list "jquery-ui.css")
  :versions (list :1.11.2
                  :1.11.1
                  :1.11.0
                  :1.10.4
                  :1.10.3
                  :1.10.2
                  :1.10.1
                  :1.10.0
                  :1.9.2
                  :1.9.1
                  :1.9.0
                  :1.8.24
                  :1.8.23
                  :1.8.22
                  :1.8.21
                  :1.8.20
                  :1.8.19
                  :1.8.18
                  :1.8.17
                  :1.8.16
                  :1.8.15
                  :1.8.14
                  :1.8.13
                  :1.8.12
                  :1.8.11
                  :1.8.10
                  :1.8.9
                  :1.8.8
                  :1.8.7
                  :1.8.6
                  :1.8.5
                  :1.8.4
                  :1.8.2
                  :1.8.1
                  :1.8.0
                  :1.7.3
                  :1.7.2
                  :1.7.1
                  :1.7.0
                  :1.6.0
                  :1.5.3
                  :1.5.2))

(defasset mootools <google-cdn>
  :versions (list :1.5.1
                  :1.5.0
                  :1.4.5
                  :1.4.4
                  :1.4.3
                  :1.4.2
                  :1.4.1
                  :1.4.0
                  :1.3.2
                  :1.3.1
                  :1.3.0
                  :1.2.5
                  :1.2.4
                  :1.2.3
                  :1.2.2
                  :1.2.1
                  :1.1.2
                  :1.1.1))

(defasset prototype <google-cdn>
  :versions (list :1.7.2.0
                  :1.7.1.0
                  :1.7.0.0
                  :1.6.1.0
                  :1.6.0.3
                  :1.6.0.2))

(defasset prototype <google-cdn>
  :versions (list :r67))

(defasset dojo <google-cdn>
  :versions (list :1.10.1
                  :1.10.0
                  :1.9.4
                  :1.9.3
                  :1.9.2
                  :1.9.1
                  :1.9.0
                  :1.8.7
                  :1.8.6
                  :1.8.5
                  :1.8.4
                  :1.8.3
                  :1.8.2
                  :1.8.1
                  :1.8.0
                  :1.7.6
                  :1.7.5
                  :1.7.4
                  :1.7.3
                  :1.7.2
                  :1.7.1
                  :1.7.0
                  :1.6.2
                  :1.6.1
                  :1.6.0
                  :1.5.3
                  :1.5.2
                  :1.5.1
                  :1.5.0
                  :1.4.5
                  :1.4.4
                  :1.4.3
                  :1.4.1
                  :1.4.0
                  :1.3.2
                  :1.3.1
                  :1.3.0
                  :1.2.3
                  :1.2.0
                  :1.1.1))

;;; MaxCDN

(defasset bootstrap <maxcdn>
  :library "bootstrap"
  :versions (list :3.2.0
                  :3.1.1
                  :3.1.0
                  :3.0.3
                  :3.0.2
                  :3.0.1
                  :3.0.0
                  :2.3.2
                  :2.3.1
                  :2.3.0
                  :2.2.2
                  :2.2.1
                  :2.2.0
                  :2.1.1
                  :2.1.0
                  :2.0.4)
  :js (list "bootstrap.min.js")
  :css (list "bootstrap.min.css"))

(defasset fontawesome <maxcdn>
  :library "font-awesome"
  :versions (list :4.2.0)
  :css (list "font-awesome.min.css"))

;;; cdnjs

(defasset leaflet <cdnjs>
  :library "leaflet"
  :versions (list :0.7.3
                  :0.7.2
                  :0.7.1
                  :0.7.0)
  :files (list "leaflet.js"
               "leaflet.css"))

(defasset backbone.js <cdnjs>
  :library "backbone.js"
  :versions (list :1.1.2
                  :1.1.1
                  :1.1.0
                  :1.0.0)
  :files (list "backbone.min.js"))

;;; GitHub

(defasset composer.js <github>
  :user "lyonbros"
  :repo "composer.js"
  :versions (list (cons :1.0 "170c0cc96a99e375818f91567043ced53d5cf734"))
  :files (list "composer.min.js"))
