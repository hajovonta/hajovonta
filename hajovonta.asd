;;;; hajovonta.asd

(asdf:defsystem #:hajovonta
  :description "Hajovonta ecosystem dependency manager for Common Lisp"
  :author "Hajovonta"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:dexador)
  :components ((:file "package")
               (:file "registry")
               (:file "pins")
               (:file "resolver")))
