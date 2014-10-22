(in-package :rock)

(defmacro make-asset (asset-name version)
  `(make-instance '<asset-version>
                  :asset (find-asset ,asset-name)
                  :version ,version))

(defmacro make-bundle (kind &key assets destination)
  `(make-instance '<bundle>
                  :kind ,kind
                  :assets (list
                           ,@(loop for asset in assets collecting
                               `(make-asset ,@asset)))
                  :destination ,destination))

(defmacro defenv (system-name &key assets bundles
                                (assets-directory #p"assets/"))
  `(setf (gethash ,system-name *environments*)
         (make-instance '<environment>
                        :system-name ,system-name
                        :assets-directory ,assets-directory
                        :dependencies
                        (list
                         ,@(loop for asset in assets collecting
                             `(make-asset ,@asset)))
                        :bundles
                        (list
                         ,@(loop for bundle in bundles collecting
                             `(make-bundle ,@bundle))))))

(defun build (system-name)
  "Build the environment associated with `system-name`."
  (build-env (get-env system-name)))
