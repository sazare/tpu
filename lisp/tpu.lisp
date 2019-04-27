;; TPU Common Lisp without go

(defvar xlist '(x1 x2 x3 x4 x5 x6 x7))
(defvar ylist '(y1 y2 y3 y4 y5 y6 y7))
(defvar zlist '(zz1 zz2 zz3 zz4 zz5 zz6 zz7))

(defun rename (cc xy)
 (let (var z c)
  (setf c cc)
  (setf z zlist)
  (setf var (cadr c))
  (loop while var do
   (setf c (subst (car z) (car var) c))
   (setf z (cdr z))
   (setf var (cdr var))
  )
  (setf z xy)
  (setf var (cadr c))
  (loop while var do
   (setf c (subst (car z) (car var) c))
   (setf z (cdr z))
   (setf var (cdr var))
  )
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

(defun unification (e1 e2)
 (let (d u d1 d2)
  (unless (equal (length e1)(length e2)) (return-from unification 'NO))
  (loop while (setf d (disagree e1 e2))
    do
    (setf d1 (car d))
    (setf d2 (cadr d))
    (cond 
      ((or (member d1 xlist)(member d1 ylist)) 
       (when (inside d1 d2) (return-from unification 'NO))
       (setf u (cons d u))
       (setf e1 (subst d2 d1 e1))
       (setf e2 (subst d2 d1 e2))
      )
      ((or (member d2 xlist)(member d2 ylist))
       (when (inside d2 d1) (return-from unification 'NO))
       (setf u (cons (reverse d) u))
       (setf e1 (subst d1 d2 e1))
       (setf e2 (subst d1 d2 e2))
      )
     ) 
  )
  (return-from unification (reverse u))
 )
)

(defun deletev (x y var)
;(format t "deletev:~a,~a,~a~%" x y var)
 (let (var1 tx tx1 x1)
  (setf x (append x y))
  (loop for vard on var do
    (setf var1 (car vard))
    (setf tx x)
    (setf x1 nil)
    (loop for dtx on tx do
      (setf tx1 (car dtx))
      (when (eq tx1 var1) (setf x (append x1 dtx))(return))
      (setf x1 (cons tx1 x1))
    )
  finally (return x)
  )
 )
) 


















  
(format t "end of loading tpu.lisp~%")

