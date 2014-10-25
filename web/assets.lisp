(in-package :cl-user)
(defpackage rock-web.assets
  (:use :cl :rock))
(in-package :rock-web.assets)

(defenv :rock
  :assets ((:jquery :2.1.1)
           (:bootstrap :3.2.0))
  :bundles ((:js
             :assets ((:jquery :2.1.1)
                      (:bootstrap :3.2.0))
             :destination #p"js/scripts.js")
            (:css
             :assets ((:bootstrap :3.2.0))
             :files (list #p"css/style.css")
             :destination #p"css/style.css")))

(build :rock)
