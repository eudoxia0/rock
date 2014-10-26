Rock is an asset manager for Common Lisp. It's basically a combination of
[Bower][bower] and [webassets][webassets].

Rock takes care of downloading specific versions of libraries -- jQuery,
Bootstrap, FontAwesome -- and bundling their files together so you can compile
all your JavaScript and CSS into single files.

## Features

* **Library Manager**: Download specific versions of the most common
  libraries. You can have multiple versions of the same library, for example,
  for migrating an application one subset at a time.
* **Asset Bundling**: Compile the JS/CSS files of different libraries and your
  own files into a single file.

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

When the assets are built, you can start serving them using your favorite web
framework.

## Defining Custom Assets

Sometimes you need to use a custom asset, like a small library that's not
included in Rock's known assets. Rock makes it simple to add new assets before
defining an environment.

Assets are defined with the `defasset` macro. The first argument is the name of
the asset (A symbol, not a keyword), and the second is the name of the asset
class, and then the keyword arguments describing the asset.

The following asset classes are defined:

* `<google-asset>`: Assets from [Google's CDN][googlecdn].
* `<bootstrap-cdn-asset>`: Assets from the [Bootstrap CDN][bscdn].
* `<cdnjs-asset>`: Assets from [cdnjs][cdnjs].
* `<github-asset>`: Assets extracted from GitHub repos.

All assets share the following keyword arguments:

`:name`
: The asset's internal name. This is what will go in the file download URL, so
for example for `:angular.js` it's `"angularjs"` because that how Google's CDN
likes it.

`:versions`
: In most assets, this is simply a list of keywords, where each keyword
represents a version, like `:1.2.3` or `:1.2-beta`. In the case of GitHub
assets, this is a list of `(version-keyword . commit-string)` pairs.

`:js`, `:css`
: A list of paths to the JS and CSS files the asset provides. For most
JavaScript libraries, this is usually just a `.min.js` file.

For GitHub assets, `:name` refers to the name of the repository, and you have to
provide a value to the `:username` argument, the GitHub username in which the
library is stored.

You can also read Rock's [built-in assets list][asset-list] to know how actual
assets are defined.

## Getting It

Until Rock is available on the [Quicklisp][ql] repository, simply clone the repo
to your `local-projects` directory:

```
$ cd quicklisp/local-projects
$ git clone https://github.com/eudoxia0/rock
```

## Available Assets

This is a list of assets that come built in with Rock. If you have a custom
asset you use often, or an asset that's not included in Rock by default, you
should [open an issue][issues] asking for its addition, or make a pull request
including the asset definition.

Click on an asset's name to see the list of versions.

[bower]: http://bower.io/
[webassets]: http://webassets.readthedocs.org/en/latest/index.html
[googlecdn]: https://developers.google.com/speed/libraries/devguide
[bscdn]: http://www.bootstrapcdn.com/
[cdnjs]: https://cdnjs.com/
[asset-list]: https://github.com/eudoxia0/rock/blob/master/src/known-assets.lisp
[ql]: http://www.quicklisp.org/
[issues]: https://github.com/eudoxia0/rock/issues
