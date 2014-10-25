(in-package :rock)

(defun concatenate-files (files target)
  "Concatenate the files in `files` (A list of pathnames) into `target`. Ensure
the parent directories of `target` exist."
  (let ((dir (fad:pathname-directory-pathname target)))
    (ensure-directories-exist dir))
  (with-open-file (output-stream target
                                 :direction :output
                                 :if-exists :supersede
                                 :if-does-not-exist :create)
    (loop for file in files do
      (with-open-file (input-stream file
                                    :direction :input
                                    :if-does-not-exist :error)
        (cl-fad:copy-stream input-stream output-stream)))))

(defun download (url destination)
  (unless (probe-file destination)
    (trivial-download:download url destination)))
