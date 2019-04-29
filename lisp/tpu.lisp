;; TPU Common Lisp without go
(load "tools.lisp")

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
  (tagbody
;(dex (format t "unif0:~a ~a~%" e1 e2))
   (unless (equal (length e1)(length e2)) (return-from unification 'NO))
B1 ;(dex (format t "unif1:~a ~a~%" e1 e2))
   (setf d (disagree e1 e2))
   (unless d (return-from unification (reverse u)))
   (setf d1 (car d))
   (setf d2 (cadr d))
;(dex (format t "unif1.5 d1,d2=~a ~a~%" d1 d2))
   (if (or (member d1 xlist)(member d1 ylist)) (go B3))
   (if (or (member d2 xlist)(member d2 ylist)) (go B4))
B2 (return-from unification 'NO)
B3 ;(dex (format t "unif3 d1=~a~%" d1))
   (if (inside d1 d2) (return-from unification 'NO))
   (setf u (cons d u))
   (setf e1 (subst d2 d1 e1))
   (setf e2 (subst d2 d1 e2))
   (go B1)
B4 ;(dex (format t "unif4 d2=~a~%" d2))
   (if (inside d2 d1) (return-from unification 'NO))
   (setf u (cons (reverse d) u))
   (setf e1 (subst d1 d2 e1))
   (setf e2 (subst d1 d2 e2))
   (go B1) 
  )
 )
)

;;; prerequisites: x y has no common vars
(defun deletev (x y var)
 (let (var1 tx tx1 x1)
  (tagbody 
;   (dex (format t "deletev:~a,~a,~a~%" x y var))
   (setf x (append x y))
B1 (if (null var) (return-from deletev x))
   (setf var1 (car var))
   (setf tx x)
   (setf x1 nil)
B2 (if (null tx) (go B4))
   (setf tx1 (car tx))
   (if (eq tx1 var1) (go B3))
   (setf x1 (cons tx1 x1))
   (setf tx (cdr tx))
   (go B2)
B3 (setf x (append x1 (cdr tx)))
B4 (setf var (cdr var))
   (go B1)
  )
 )
) 

(defun uresolve (c1 c2 n)
 (prog (l1 l2 vc1 vc2 x y sign unif r res var v1 v2 h hist tc2)
  (tagbody 
   (setf c1 (rename c1 xlist))
   (setf c2 (rename c2 ylist))
;(dex (format t "ures0:c1,c2=~a,~a~%" c1 c2))
   (setf l1 (car c1))
   (setf l2 (car c2))
;(dex (format t "ures0:l1,l2=~a,~a~%" l1 l2))
   (setf vc1 (cadr c1))
   (setf vc2 (cadr c2))
;(dex (format t "ures0:vc1,vc2=~a,~a~%" vc1 vc2))
   (setf c2 (caddr c2))
;(dex (format t "ures0:c2=~a~%" c2))
   (setf x (car (caddr c1)))
;(dex (format t "ures0:x=~a~%" x))
   (setf sign -1)
;(dex (format t "ures0:c1,c2,l1,l2,vc1,vc2,c2,x=~a,~a,~a,~a,~a,~a,~a,~a~%" c1 c2 l1 l2 vc1 vc2 c2 x))
   (if (eq (car x) 'NOT) (go B7))
   (setf sign 1)
B1 ;(dex (format t "ures1:~a ~a ~%" c1 c2))
   (if (null c2) (return-from uresolve (list (reverse res)(reverse hist) n)))   
   ;(dex (format t "ures1.1:c2=~a~%" c2))
   (setf y (car c2))
   (if (eq (car y) 'NOT) (go B2) (go B6))
B2 ;(dex (format t "ures2:~a ~a ~a ~%" c1 c2 sign))
   ;(dex (format t "ures x,y:~a ~a ~%" x (cdr y)))
   (setf unif (unification x (cdr y)))
B3 ;(dex (format t "ures3:c1,c2,sign,unif=~a ~a ~a ~a ~%" c1 c2 sign unif))
   (if (equal unif 'NO) (go B6))
   (setf r (append (reverse tc2) (cdr c2)))
;   (dex (format t "ures3.1: r=~a~%" r))
   (unless r ;(format t "ures3.2:return []~%")
     (return-from uresolve (list 'CONTRADICTION l1 l2)))
;   (dex (format t "ures3.2: r=~a~%" r))
   (setf var nil)
B4 ;(dex (format t "ures4:~a ~a ~a ~%" c1 c2 sign))
;;  apply unif to r in B4 to B5
   (if (null unif) (go B5))
   (setf v1 (caar unif))
   (setf v2 (cadar unif))
   (setf var (cons v1 var))
   (setf r (subst v2 v1 r))
   (setf unif (cdr unif))
B5 ;(dex (format t "ures5:~a ~a ~a ~%" c1 c2 sign))
    (setf n (1+ n))
    (setf h (list n l1 l2 (1+ (length tc2))))
    (setf r (list n (deletev vc1 vc2 var) r))
    (setf res (cons r res))
    (setf hist (cons h hist))
B6 ;(dex (format t "ures6:~a ~a ~a ~%" c1 c2 sign))
    (setf tc2 (cons y tc2))
    (setf c2 (cdr c2))
    (if (equal sign 1) (go b1))
B7 ;(dex (format t "ures7:~a ~a,~a ~%" c1 c2 sign))
    (if (null c2) (return-from uresolve (list (reverse res)(reverse hist) n)))
    (setf y (car c2))
    (if (eq (car y) 'NOT) (go B6))
    (setf unif (unification (cdr x) y))
    (go B3)
  ) 
 )
)

(defun gunit (s1 s2 w c n)
 (prog (L s3 ss3 w1 v u res hist m x)
  (tagbody
(dex (format t "gunit0:res,hist,n = ~a,~a,~a~%" res hist n))
   (if (null w) (return-from gunit (list res hist n)))
   (setf L (length (caddr c)))
   (setf s3 (list (list 10000 c)))
   (setf ss3 s3)
B1 ;(dex (format t "gunit1:L,s3,ss3 = ~a,~a,~a~%" L s3 ss3))
   (if (null w) (go B7))
   (setf w1 (car w))
B2 ;(dex (format t "gunit2:ss3= ~a~%" ss3))
   (if (null ss3) (go B4))
   (setf v (car ss3))
;(dex (format t "gunit21:v,w1= ~a,~a~%" v w1))
   (if (> (car w1)(car v)) (go B3))
   (setf u (uresolve w1 (cadr v) n))
;(dex (format t "gunit22:u= ~a~%" u))
   (if (null (car u)) (go B3))
   (setf res (append res (car u)))
   (setf hist (append hist (cadr u)))
   (setf n (caddr u))
;(dex (format t "gunit22:res,hist,n= ~a,~a,~a~%" res hist n))
B3 ;(dex (format t "gunit3: ss3=~a~%" ss3))
   (setf ss3 (cdr ss3))
   (go B2)
B4 ;(dex (format t "gunit4: L=~a~%" L))
   (if (equal (1- L) 1) (go B6)) 
   (setf m (car w1))
B5 ;(dex (format t "gunit5: res=~a~%" res))
   (if (null res) (go B6))
   (setf x (cons (list m (car res)) x))
   (setf res (cdr res))
;(dex (format t "gunit51: res,x=~a,~a~%" res x))
   (go B5)

B6 ;(dex (format t "gunit6: w,s3=~a,~a~%" w s3))
   (setf w (cdr w))
   (setf ss3 s3)
   (go B1)

B7 ;(dex (format t "gunit7: L=~a~%" L))
   (setf L (1- L))
   (if (equal L 1)(return-from gunit (list res hist n)))
   (setf s3 x)
   (setf ss3 s3)
   (setf x nil)
   (setf w (append s1 s2))
;(dex (format t "gunit71: ss3,x,w=~a,~a,~a~%" ss3 x w))
   (go B1)
  )
 )
)

(defun pnsort (res)
 (prog (c pos neg)
  (tagbody
B1 ;(dex (format t "pnsort:pos,neg=~a,~a~%" pos neg))
   (if (null res) (return-from pnsort (list (reverse pos)(reverse neg))))
   (setf c (caar (cddar res))) 
   (if (equal (car c) 'NOT) (go B3))
   (setf pos (cons (car res) pos))
B2
   (setf res (cdr res))
   (go B1)
B3
   (setf neg (cons (car res) neg))
   (go B2)
  )
 )
)


(defun fdepth (c)
 (prog (n u)
  (tagbody
   (setf c (car (caddr c)))
   (if (equal (car c) 'not) (go B1))
   (setf c (cdr c))
   (go B2)
B1 (setf c (cddr c))
B2 (setf n 0)
B3 (if (null c) (go B5))
   (if (atom (car c)) (go B4))
   (setf u (append (cdar c) u))
B4 (setf c (cdr c))
   (go B3)
B5 (if (null u) (return-from fdepth n))
   (setf n (1+ n))
   (setf c u)
   (setf u nil)
   (go B3)
  )
 )
)

(defun ftest (res n4)
 (prog (c u)
  (tagbody 
B1 (if (null res)(return-from ftest (reverse u)))
   (setf c (car res))
   (if (> (fdepth c) n4) (go B2))
   (setf u (cons c u))
B2 (setf res (cdr res))
   (go B1)
  )
 )
) 

(defun subsume (c1 c2)
 (prog (z var u)
  (tagbody
   (setf c1 (rename c1 xlist))
   (setf c1 (car (caddr c1)))
   (setf z zlist)
   (setf var (cadr c2))
   (setf c2 (car (caddr c2)))
B1 (if (null var) (go B2))
   (setf c2 (subst (car z)(car var) c2))
   (setf var (cdr var))
   (go B1)
B2 (setf u (unification c1 c2))
   (if (equal u 'NO) (return-from subsume nil))
   (return-from subsume T)
  )
 )
)

(defun stest (u res)
 (prog (r v w x1 y z)
  (tagbody
B1 (if (null res) (go B5))
   (setf r (car res))
   (setf z (append u v))
B2 (if (null z) (go B3))
   (if (subsume (car z) r) (go B4))
   (setf z (cdr z))
   (go B2)
B3 (setf v (cons r v))
B4 (setf res (cdr res))
   (go B1)
B5 (if (null v) (return-from stest w))
   (setf x1 (car v))
   (setf z (cdr v))
B6 (if (null z) (go B8))
   (if (subsume x1 (car z)) (go B7))
   (setf y (cons (car z) y))
B7 (setf z (cdr z))
   (go B6)
B8 (setf w (cons x1 w))
   (setf v (reverse y))
   (setf y nil)
   (go B5)
  )
 )
)

(defun contradict (u v)
 (prog (x1 y res)
  (tagbody
B1 (if (or (null u)(null v)) (return-from contradict nil))
   (setf x1 (car u))
   (setf y v)
B2 (if (null y) (go B3))
   (setf res (uresolve x1 (car y) -1))
   (if (equal (car res) 'CONTRADICTION) (return-from contradict res))
   (setf y (cdr y))
   (go B2)
B3 (setf u (cdr u))
   (go B1)
  )
 )
)

(defun dtree (z hist n1)
 (prog (x tx x1 h m1 m2 m n)
   (tagbody
    (setf hist (reverse hist))
    (setf x (cdr z))
    (setf z (list z))
    (if (> (car x)(cadr x)) (go B0))
    (setf x (reverse x))
B0  (if (> (cadr x) n1)(go B1))
    (setf x (list (car x)))
B1  (if (null x) (return-from dtree z))
    (setf x1 (car x))
B2  (if (equal x1 (caar hist)) (go B3))
    (setf hist (cdr hist))
    (go B2)
B3  (setf x (cdr x))
    (setf h (car hist))
    (setf z (cons h z))
    (setf hist (cdr hist))
    (setf m1 (cadr h))
    (setf m2 (caddr h))
    (if (> m1 n1) (go B5))
B4  (if (> m2 n1) (go B6))
    (go B1)
B5  (setf n 1)
    (setf m m1)
    (go B7)
B6  (setf n 2)
    (setf m m2)
B7  (if (null x) (go B8))
    (setf x1 (car x))
    (if (equal x1 m) (go B10))
    (if (> x1 m) (go B9))
B8  (setf x (append (reverse tx)(cons m x)))
    (go B11)
B9  (setf tx (cons x1 tx))
    (setf x (cdr x))
    (go B7)
B10 (setf x (append (reverse tx) x))
B11 (setf tx nil)
    (if (equal  n 2)(go B1))
    (go B4)
  )
 )
)

(defun tpu (s1 s2 s3 w n1 n2 n3 n4)
 (prog (s w1 ts u1 u n k ck wck v pos neg hist y x1 x)
  (tagbody
   (setf s (append s1 s2))
   (setf s (reverse s))
B1 (dex (format t "tpu1:s=~a~%" s))
   (if (null w) (go B6))
   (setf w1 (car w))
B2 (dex (format t "tpu2:w1=~a~%" w1))
   (setf ts s)
   (if (null w1)(go B5))
B3 (dex (format t "tpu3:w1,ts=~a,~a~%" w1 ts))
   (if (eq (car w1)(caar ts)) (go B4))
   (setf ts (cdr ts))
   (go B3)
B4 (dex (format t "tpu4:w1,ts=~a,~a~%" w1 ts)) 
   (setf u1 (cons (car ts) u1))
   (setf w1 (cdr w1))
   (go B2)
B5 (dex (format t "tpu5:u1,u,w=~a,~a,~a~%" u1 u w))
   (setf u (cons u1 u))
   (setf w (cdr w))
   (setf u1 nil)
   (go B1)
B6 (dex (format t "tpu6:w,n,s1,s2=~a,~a,~a,~a~%" w n s1 s2))
   (setf w (reverse u))
   (setf n n1)
   (setf u (contradict s1 s2))
(dex (format t "tpu6.1:u=~a~%" u))
   (if (not (null u)) (return-from tpu u))
   (setf k 1)
B7 (dex (format t "tpu7:k,n2=~a,~a~%" k n))
   (if (> k n2)(return-from tpu '(S is not proved)))
   (dex (format t "tpu7.1:s3 w,s1 s2=~a,~a,~a,~a~%" s3 w s1 s2))
   (setf ck (car s3))
   (setf wck (car w))
   (setf v (gunit s1 s2 wck ck n))
   (if (null (car v)) (go B12))
   (setf n (caddr v))
   (setf hist (append hist (cadr v)))
   (setf v (car v))
   (if (< k n3) (go B8))
   (setf v (ftest v n4))
B8 (dex (format t "tpu8:~%" ))
   (setf v (pnsort v))
   (setf pos (stest s1 (car v)))
   (setf neg (stest s2 (cadr v)))
   (if (null (append pos neg)) (go B12))
   (setf u (contradict s1 neg))
   (if (not (null u)) (return-from tpu (dtree u hist n1)))
(dex (format t "after 1st dtree~%"))
   (setf u (contradict pos s2))
   (if (not (null u)) (return-from tpu (dtree u hist n1)))
(dex (format t "after 2nd dtree~%"))
   (setf s1 (append s1 pos))
   (setf s2 (append s2 neg))
   (setf w (cdr w))
   (setf y (append pos neg))
B9 (dex (format t "tpu9:~%" )) 
   (if (null w) (go B10))
   (setf x1 (append y (car w)))
   (setf x (cons x1 x))
   (setf w (cdr w))
   (go B9)
B10(dex (format t "tpu10:~%" )) 
   (setf w (append (reverse x)(list y)))
   (setf x nil)
B11(dex (format t "tpu11:~%" )) 
   (setf s3 (append (cdr s3)(list ck)))
   (setf k (1+ k))
   (go B7)
B12(dex (format t "tpu12:~%" )) 
   (setf w (append (cdr w)(list nil)))
   (go B11)
  )
 )
)

(format t "end of loading tpu.lisp~%")

