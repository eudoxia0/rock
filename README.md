# Rock: Assets for Common Lisp web apps

[![Build Status](https://travis-ci.org/eudoxia0/rock.svg?branch=master)](https://travis-ci.org/eudoxia0/rock)

Rock is an asset manager for Common Lisp. It's basically a combination of
[Bower][bower] and [webassets][webassets].

Rock takes care of downloading specific versions of libraries -- jQuery,
Bootstrap, FontAwesome -- and bundling their files together so you can compile
all your JavaScript and CSS into single files.

[bower]: http://bower.io/
[webassets]: http://webassets.readthedocs.org/en/latest/index.html

# Features

* **Library Manager**: Download specific versions of the most common
  libraries. You can have multiple versions of the same library, for example,
  for migrating an application one subset at a time.
* **Asset Bundling**: Compile the JS/CSS files of different libraries and your
  own files into a single file. You can produce many bundles per application,
  for example, a bundle with an old version of different libraries, and a bundle
  with newer versions, for migrating a large application one subset at a time.

# License

Copyright (c) 2014 Fernando Borretti (eudoxiahp@gmail.com)

Licensed under the MIT License.
