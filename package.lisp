;;;; package.lisp

(defpackage #:hajovonta
  (:use #:cl)
  (:export
           #:*local-projects-dir*
           #:*registry-url*
           #:fetch-registry
           #:pin
           #:unpin))
