(in-package #:hajovonta)

(defun find-in-registry (system-name)
  "Look up a system name in the registry. Returns the plist entry or NIL."
  (find system-name (fetch-registry)
        :key (lambda (entry) (getf entry :name))
        :test #'string-equal))
(defun fetch-registry (&optional force)
  "Fetch and parse the registry from *registry-url*. Caches the result.
If FORCE is non-nil, re-fetches even if cached."
  (when (or force (null *registry-cache*))
    (let ((body (dexador:get *registry-url*)))
      (setf *registry-cache*
            (with-input-from-string (s body)
              (read s)))))
  *registry-cache*)
(defvar *registry-cache* nil
  "Cached registry entries (list of plists).")
(defvar *registry-url* "https://hajovonta.srht.site/registry/systems.sexp"
  "URL of the remote Hajovonta registry file.")
