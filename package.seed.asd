(asdf:defsystem #:package.seed
  :description "Provides define-seed-package."
  :author "Peter von Etter"
  :license "LGPL-3.0"
  :version "0.0.1"
  :serial t
  :components ((:file "package.seed"))
  :depends-on (#:alexandria
               #:trivial-package-local-nicknames
               #:capitalized-export
               #:util.package.seed))
