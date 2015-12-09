(defpackage :software-evolution-utility
  (:use
   :common-lisp
   :alexandria
   :metabang-bind
   :curry-compose-reader-macros
   :split-sequence
   :trivial-shell
   :cl-ppcre
   :cl-store)
  (:export
   :infinity
   ;; OS
   :file-to-string
   :file-to-bytes
   :string-to-file
   :bytes-to-file
   :temp-file-name
   :with-temp-file
   :with-temp-file-of
   ;; :from-bytes
   ;; :to-bytes
   :*work-dir*
   :*shell-debug*
   :shell
   :parse-number
   ;; forensic
   :show-it
   :equal-it
   :count-cons
   ;; simple utility
   :repeatedly
   :range
   :indexed
   :different-it
   :plist-get
   :plist-drop
   :counts
   :proportional-pick
   :random-elt-with-decay
   :random-hash-table-key
   :apply-replacements
   :replace-all
   :json-string-escape
   :json-string-unescape
   :aget
   :getter
   :transpose
   :interleave
   :mapconcat
   :drop
   :drop-while
   :drop-until
   :take
   :take-while
   :take-until
   :levenshtein-distance
   :intercalate
   :unlines
   :keep-lines-after-matching
   :resolve-function-headers
   :merge-hash-tables
   ;; debugging
   :*note-level*
   :*note-out*
   :note
   ;; gdb functions
   :gdb-disassemble
   :addrs
   :function-lines
   :calculate-addr-map
   ;; oprofile
   :samples-from-oprofile-file
   :samples-from-tracer-file))

#+allegro
(set-dispatch-macro-character #\# #\_
                              #'(lambda (s c n) (declare (ignore s c n)) nil))

