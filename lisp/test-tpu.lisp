(load "test.lisp")

(load "tpu.lisp")

(deftest test-rename () "for rename"
 (test "simple" '(1 (u v)((P u v)))  (rename '(1 (x y) ((P x y))) '(u v)))
 (test "2literals" '(2 (x1 x2) ((P x1)(neg P x2))) 
        (rename '(2 (x y) ((P x)(neg P y))) '(x1 x2)))
)

(deftest test-inside () "for inside"
 (test "inside aa" t (inside 'a 'a))
 (test "inside ac" t (inside 'a '(f a)))
 (test "inside not" nil (inside 'a '(f (g x y))))
 (test "inside acc" t (inside 'g '(f (g x y))))
)

(deftest test-disagree () "for disagree"
 (test "disag aa" nil (disagree 'a 'a))
 (test "disag ab" '(a b) (disagree 'a 'b) )
 (test "disag ff" nil (disagree '(f x) '(f x)) )
 (test "disag fxb" '(x b) (disagree '(f x) '(f b)) )
 (test "disag fg" '(f g) (disagree '(f x) '(g y)) )
 (test "disag first dis" '((g x) z) (disagree '(f (g x) y) '(f z (h w))) )
 (test "disag flong" nil (disagree '(f (g x) y x) '(f (g x y x)) ))
 (test "disag tail dis" '(y (h w)) (disagree '(f z y) '(f z (h w))) )
)

(deftest test-unification () "for uification"
 (test "unify diff len" 'NO (unification '(P X Y) '(P X)))
 (test "unify same" '() (unification '(P X) '(P X)))
 (test "unify vc" '((x1 x)) (unification '(P X1) '(P X)))
 (test "unify cv" '((x2 b)) (unification '(P B) '(P X2)))
 (test "unify ident" '() (unification '(P X (G Y)) '(P X (G Y))))
 (test "unify 1pair" '((X1 a)) (unification '(P a (G Y1)) '(P X1 (G Y1))))
 (test "unify 2pair" '((X1 a)(Y1 B)) (unification '(P a (G Y1)) '(P X1 (G B))))

 (test "unify inside" 'NO (unification '(P X1) '(P (f X1))))
 (test "unify inside" 'NO (unification '(P X1 (G Y1)) '(P (f X1) (G B))))

 (test "unify circle" '((x1 (f y1))(y1 (g a))) (unification '(P X1 (G A)) '(P (f Y1) Y1)))
 (test "unify infinite" 'NO (unification '(P X1 (G X1)) '(P (f Y1) Y1)))

 (test "unify twisted" '((x1 a)(y1 (h a))(y2 (g a))(x2 (k (h a)(g a)))) (unification '(P x1 (h x1) (g x1) x2) '(P a y1 y2 (k y1 y2))))

;; (test "unify wierd" '((x1 a)(x2 (h (g a) (k a)))(y2 (g a))(y3 (k a))) (unification '(P x1 x2 (g x1) (k x1)) '(P a (h y2 y3) y2 y3)))
 (test "unify wierd" '((x1 a)(x2 (h y2 y3))(y2 (g a))(y3 (k a))) (unification '(P x1 x2 (g x1)(k x1)) '(P a (h y2 y3) y2 y3)))
)

(deftest test-deletev () "for deletev"
; (test "deletev varnull" '(p x1 p y1) (deletev '(p x1) '(p y1) '()))

)
(deftest test-uresolve () "for uresolve"

)

(deftest test-gunit () "for gunit"

)

(deftest test-pnsort () "for pnsort"

)

(deftest test-fdepth () "for fdepth"

)

(deftest test-ftest () "for ftest"

)

(deftest test-subsume () "for subsume"

)

(deftest test-stest () "for stest"

)

(deftest test-contradict () "for contradict"

)

(deftest test-dtree () "for dtree"

)

(deftest test-tpu () "for tpu"

)


(deftest test-all ()
 (test-set "tests for tpu"
  (test-rename)
  (test-inside)
  (test-disagree)
  (test-unification)
  (test-deletev)
  (test-uresolve)
  (test-gunit)
  (test-pnsort)
  (test-fdepth)
  (test-ftest)
  (test-subsume)
  (test-stest)
  (test-contradict)
  (test-dtree)
  (test-tpu)

 )
)

(test-all)

