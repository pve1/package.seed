(eval-when (:compile-toplevel :load-toplevel :execute)
  (ignore-errors (make-package :package.seed :use '(:cl)))
  (in-package :package.seed)
  (setf *readtable* (capitalized-export:make-capitalized-export-readtable)))

(defmacro Define-seed-package (name &body rest &key capitalized-export
                                                    nicknames
                                                    clear-exports)
  (declare (ignore rest))
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (ignore-errors (make-package ',name :use '(:cl)))
     ;; Let's not confuse slime.
     #| blah |# (in-package ,name)
     ,@(when clear-exports
         `((unexport-all (find-package ',name))))
     ,@(when capitalized-export
         `((setf *readtable* (capitalized-export:make-capitalized-export-readtable
                              :package (find-package ',name)))))
     ,@(when nicknames
         (alexandria:with-gensyms (local-nick package-name)
           `((loop :for (,local-nick ,package-name) :in ',nicknames
                   :do (trivial-package-local-nicknames:add-package-local-nickname
                        ,local-nick ,package-name (find-package ',name))))))
     t))

(defun unexport-all (&optional (package *package*))
  (let (exported-symbols)
    (do-external-symbols (sym package)
      (push sym exported-symbols))
    (unexport exported-symbols package)))
