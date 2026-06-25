(in-package #:hajovonta)

(defun unpin (system-name)
  "Remove a pin for a system."
  (let ((pins (remove system-name (read-pins) :key #'car :test #'string-equal)))
    (ensure-directories-exist *pins-file*)
    (with-open-file (s *pins-file* :direction :output :if-exists :supersede)
      (write pins :stream s :pretty t))
    pins))
(defun pin (system-name &key ref)
  "Pin a system to a specific git ref."
  (let ((pins (read-pins)))
    (setf (cdr (or (assoc system-name pins :test #'string-equal)
                   (car (push (cons system-name nil) pins))))
          ref)
    (ensure-directories-exist *pins-file*)
    (with-open-file (s *pins-file* :direction :output :if-exists :supersede)
      (write pins :stream s :pretty t))
    pins))
(defun read-pins ()
  "Read pins from *pins-file*. Returns alist of (name . ref)."
  (if (probe-file *pins-file*)
      (with-open-file (s *pins-file* :direction :input)
        (read s))
      nil))
(defvar *pins-file*
  (merge-pathnames ".config/hajovonta/pins.sexp" (user-homedir-pathname))
  "Path to the local pins file.")
