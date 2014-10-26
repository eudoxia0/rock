Rock is an asset manager for Common Lisp. It's basically a combination of
[Bower][bower] and [webassets][webassets].

Rock takes care of downloading specific versions of libraries -- jQuery,
Bootstrap, FontAwesome -- and bundling their files together so you can compile
all your JavaScript and CSS into single files.

[bower]: http://bower.io/
[webassets]: http://webassets.readthedocs.org/en/latest/index.html

## Features

* **Library Manager**: Download specific versions of the most common
  libraries. You can have multiple versions of the same library, for example,
  for migrating an application one subset at a time.
* **Asset Bundling**: Compile the JS/CSS files of different libraries and your
  own files into a single file. You can produce many bundles per application,
  for example, a bundle with an old version of different libraries, and a bundle
  with newer versions, for migrating a large application one subset at a time.

## How it Works

Here's the Rock environment definition for this website:

```
;; We define an environment for the 'rock' ASDF system
(defenv :rock
  ;; These are our dependencies
  :assets ((:jquery :2.1.1)
           (:bootstrap :3.2.0)
           (:highlight-lisp :0.1))
  :bundles ((:js
             ;; This is a JS bundle. It compiles the JS files
             ;; of the dependencies below:
             :assets ((:jquery :2.1.1)
                      (:bootstrap :3.2.0)
                      (:highlight-lisp :0.1))
             ;; Our custom JS: assets/js/scripts.js
             :files (list #p"js/scripts.js")
             ;; Combined JS file: assets/build/js/scripts.js
             :destination #p"js/scripts.js")
            (:css
             ;; This is a CSS bundle. Note that we don't
             ;; include jQuery
             :assets ((:bootstrap :3.2.0)
                      (:highlight-lisp :0.1))
             :files (list #p"css/style.css")
             :destination #p"css/style.css")))

;; Download the assets and compile the bundles for this
;; environment. Dependencies are only downloaded when
;; they're needed.
(build :rock)
```
