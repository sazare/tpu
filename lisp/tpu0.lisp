;; TPU almost original code

(defvar xlist '(nil x1 x2 x3 x4 x5 x6 x7))
(defvar ylist '(nil y1 y2 y3 y4 y5 y6 y7))
(defvar zlist '(nil zz1 zz2 zz3 zz4 zz5 zz6 zz7))

(defun rename (c xy)
  (let (var z)
    (tagbody 
      (setf z zlist)
      (setq var (cadr c))
(format t "~a:~a" zlist var)

 #:B1 (if (null var) (go #:B1))
      (setq c (subst (car z) (car var) c))
      (setq z (cdr z))
      (setq var (cdr var))
      (go #:B1)
 #:B2 (set z xy)
      (setq var (cadr c))
 #:B3 (if (null var) (return c))
      (setq c (subst (car z)(car var) c))
      (setq z (cdr z))
      (setq var (cdr var))
      (go #:B3))
   )
 )

      

