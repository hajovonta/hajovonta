(in-package #:hajovonta)

(defun register-resolver ()
  "Register the Hajovonta resolver with ASDF. Called at load time."
  (pushnew 'search-hajovonta asdf:*system-definition-search-functions*))
(defun search-hajovonta (system-name)
  "ASDF system-definition-search function. If system is in our registry, clone it and return the .asd path."
  (let ((entry (find-in-registry (string system-name))))
    (when entry
      (let* ((name (getf entry :name))
             (repo (getf entry :repo))
             (pins (read-pins))
             (ref (cdr (assoc name pins :test #'string-equal)))
             (dir (ensure-cloned name repo ref))
             (asd (merge-pathnames (format nil "~A.asd" name) dir)))
        (when (probe-file asd)
          asd)))))
(defun ensure-cloned (name repo &optional ref)
  "Clone or pull a repo into *local-projects-dir*, optionally checking out a pinned ref."
  (let ((dir (merge-pathnames (format nil "~A/" name) *local-projects-dir*)))
    (if (probe-file (merge-pathnames ".git/" dir))
        (uiop:run-program (list "git" "-C" (namestring dir) "pull" "--ff-only")
                          :ignore-error-status t)
        (uiop:run-program (list "git" "clone" repo (namestring dir))))
    (when ref
      (uiop:run-program (list "git" "-C" (namestring dir) "checkout" ref)))
    dir))
(defvar *local-projects-dir*
  (first ql:*local-project-directories*)
  "Local directory where Hajovonta projects are cloned.")

;;; Auto-register on load
(register-resolver)
