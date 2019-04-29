(defvar dexmode nil)

(defmacro dex (x) `(when ,dexmode ,x))
;(defmacro dex (&rest x) `(when ,dexmode ,@x))

