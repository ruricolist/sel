;;; json.lisp --- Json software representation.
;;;
;;; Implements AST parsing for JSON software objects.  JSON software
;;; objects are a very thin customization on top of JavaScript
;;; software objects.
;;;
;;; @texi{json}
(defpackage :software-evolution-library/software/json
  (:nicknames :sel/software/json :sel/sw/json)
  (:use :common-lisp
        :alexandria
        :named-readtables
        :curry-compose-reader-macros
        :software-evolution-library
        :software-evolution-library/utility
        :software-evolution-library/software/source
        :software-evolution-library/software/parseable
        :software-evolution-library/software/javascript)
  (:shadowing-import-from :cl-json :decode-json-from-string)
  (:export :json))
(in-package :software-evolution-library/software/json)
(in-readtable :curry-compose-reader-macros)

(define-software json (javascript)
  ()
  (:documentation "JSON software representation."))

(defmethod parse-asts ((obj json))
  "Parse a JSON file (with acorn as JavaScript with a simple hack).
We do this by temporarily turning the JSON into a valid JavaScript
file by pre-pending the left hand side of an assignment.  We then
parse the resulting JavaScript into ASTs, extract the right hand side
of the assignment, and fix-up the :start and :end source range
pointers to adjust for the extra offset introduced by the added left
hand side."
  (with-temp-file-of (src-file (ext obj))
      (concatenate 'string "x=" (genome obj))
    (multiple-value-bind (stdout stderr exit)
        (shell "acorn ~a" src-file)
      (unless (zerop exit)
        (error
         (make-instance 'mutate
           :text (format nil "acorn exit ~d~%stderr:~s"
                         exit
                         stderr)
           :obj obj :op :parse)))
      (let* ((raw (decode-json-from-string stdout))
             (expr (aget :right (aget :expression (car (aget :body raw))))))
        (assert (and expr (string= "ObjectExpression" (aget :type expr)))
                (obj) "JSON object ~s isn't an ObjectExpression" obj)
        ;; Reduce every ::start and :end value by two to makeup for
        ;; the appended "x=" above.
        (labels ((push-back (value tree)
                   (cond
                     ((proper-list-p tree) (mapcar {push-back value} tree))
                     ((and (consp tree) (or (eql :start (car tree))
                                            (eql :end (car tree))))
                      (cons (car tree) (- (cdr tree) value)))
                     (t tree))))
          (push-back 2 expr))))))
