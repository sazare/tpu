;; TPU Common Lisp without go

(defvar xlist '(x1 x2 x3 x4 x5 x6 x7))
(defvar ylist '(y1 y2 y3 y4 y5 y6 y7))
(defvar zlist '(zz1 zz2 zz3 zz4 zz5 zz6 zz7))

(defun rename (cc xy)
  (let (var z c)
    (setf c cc)
    (setf z zlist)
    (setf var (cadr c))
(format t "z,var=~a,~a~%" z var)
    (loop while var do
(format t "cars=~a,~a~%" (car z)(car var))
      (setf c (subst (car z) (car var) c))
(format t "c=~a~%" c)
      (setf z (cdr z))
      (setf var (cdr var))
    )
    (setf z xy)
    (setf var (cadr c))
(format t "z,var=~a,~a~%" z var)
    (loop while var do
(format t "cars=~a,~a~%" (car z)(car var))
      (setf c (subst (car z) (car var) c))
(format t "c=~a~%" c)
      (setf z (cdr z))
      (setf var (cdr var))
    )
(format t "c=~a~%" c)
    c
 )
)

(defun inside (a e)
  (cond ((atom e) (eq a e))
        ((inside a (car e)) t)
        (t (inside a (cdr e)))
        )
)


(defun disagree (e1 e2)
  (cond ((null e1) nil)
        ((or (atom e1) (atom e2))
          (cond ((equal e1 e2) nil) (t (list e1 e2))))
        ((equal (car e1)(car e2))(disagree (cdr e1)(cdr e2)))
        ((or (atom (car e1)) (atom (car e2))) (list (car e1)(car e2)))
        (t (disagree (car e1)(car e2)))
  )
)


(format t "end of loading tpu.lisp~%")

