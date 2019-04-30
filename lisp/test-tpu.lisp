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

 (test "unify wierd" '((x1 a)(x2 (h (g a) (k a)))(y2 (g a))(y3 (k a))) (unification '(P x1 x2 (g x1) (k x1)) '(P a (h y2 y3) y2 y3)))
 (test "unify wierd" '((x1 a)(x2 (h y2 y3))(y2 (g a))(y3 (k a))) (unification '(P x1 x2 (g x1)(k x1)) '(P a (h y2 y3) y2 y3)))
)

(deftest test-deletev () "for deletev"
 (test "deletev nnv" '() (deletev '() '() '(x y)))
 (test "deletev vnv" '() (deletev '(x) '() '(x y)))
 (test "deletev nvv" '() (deletev '() '(y) '(x y)))
 (test "deletev vwv" '() (deletev '(x) '(y) '(x y)))
 (test "deletev vvv2" '(z) (deletev '(x) '(y z) '(x y)))
 (test "deletev vwvwvw" '(x z) (deletev '(x y z) '(w u) '(y w u)))
 (test "deletev vwvwvw" '(y) (deletev '(x y) '(w z) '(x w z)))
 (test "deletev v2v2v3" '(n w u) (deletev '(x y w) '(n z u) '(x y z)))
)

(deftest test-uresolve () "for uresolve" 
 (test "ureso unmatch(??)" '(NIL NIL 3) (uresolve '(1 () ((P a))) '(2 () ((not P b))) 3))
 (test "ureso contradictvc" '(contradiction 1 2) (uresolve '(1 (x) ((P x))) '(2 () ((not P b))) 3))
 (test "ureso contradictcv" '(contradiction 1 2) (uresolve '(1 () ((P a))) '(2 (y) ((not P y))) 3))
 (test "ureso contradictnp" '(contradiction 1 2) (uresolve '(1 () ((not P a))) '(2 (y) ((P y))) 3))
 (test "ureso fail" '(NIL NIL 3) (uresolve '(1 () ((P a))) '(2 (y) ((not P (f y)))) 3))
 (test "ureso contradictvf" '(contradiction 1 2) (uresolve '(1 (x) ((P x))) '(2 (y) ((not P (f y)))) 3))

 (test  "book a1 ex1" '(((11 ()((p a)(p b)(q b)))(12 ()((p a)(q a)(p b)))) ((11 1 5 2)(12 1 5 4)) 12) (uresolve '(1 (x) ((not q x))) '(5 () ((p a)(q a)(p b)(q b))) 10))

) 

(deftest test-gunit () "for gunit" 
 (test "gunit..." '(NIL NIL 10) (gunit '((1 () ((P a)))) '((2 () ((not P a)))) '() '((3 (x) ((P x)(Q x)))(4 (x) ((not P x)(Q x)))) 10))
 (test "gunit..." '(NIL NIL 10) (gunit '((1 () ((P a)))) '((2 () ((not P a)))) '((3 (x) ((P x)))) '(4 (x) ((P x)(Q x))) 10))

 (test "gunit from ex2.lisp" 
   '(((25 NIL ((P A B C))) (26 NIL ((P A B C))) (27 NIL ((P A B C)))
         (28 NIL ((P C E C))) (29 NIL ((P C E C))) (30 NIL ((P C B A))))
        ((8 4 6 1) (9 4 6 2) (10 4 6 3) (11 1 10 2) (12 1 9 1) (13 1 9 2)
         (14 2 10 1) (15 2 10 2) (16 2 8 1) (17 2 8 2) (18 3 10 1) (19 3 9 1)
         (20 3 9 2) (21 3 8 1) (22 3 8 2) (23 4 10 1) (24 4 8 2) (25 1 14 1)
         (26 1 13 1) (27 1 12 1) (28 2 24 1) (29 2 23 1) (30 2 21 1))
        30)
    (gunit '((1 (X) ((P E X X))) (2 (X) ((P X E X))) (3 (X) ((P X X E))) (4 NIL ((P A B C))))
           ' ((5 NIL ((NOT P B A C)))) 
           '((4 NIL ((P A B C))))
           '(6 (X Y Z U V W) ((NOT P X Y U) (NOT P Y Z V) (NOT P X V W) (P U Z W))) 
           7)
 )
(format t "~%I can't understand gunit~%")
) 

(deftest test-pnsort () "for pnsort" 
 (test "pnsort1" '(((1()((P a)))(3()((Q c))))((2()((not P b)))(4()((not R d))))) (pnsort '((1()((P a))) (2()((not P b)))(3()((Q c)))(4()((not R d))))))
 (test "pnsort2" '(((1()((P a)))(3()((Q c))))((2()((not P b)))(4()((not R d))))) (pnsort '((2()((not P b))) (1()((P a))) (4()((not R d))) (3()((Q c))))))
)

(deftest test-fdepth () "for fdepth" )

(deftest test-ftest () "for ftest" )

(deftest test-subsume () "two clause subsume? "
  (test "subsume yes" T (subsume '(1 (X Y) ((P X (F Y)))) '(2 (U W) ((P U (F W))))))
  (test "subsume yes ech var" T (subsume '(1 (X Y) ((P X (F Y)))) '(2 (U W) ((P W (F U))))))
  (test "subsume yes xfx" T (subsume '(1 (X Y) ((P X (F Y)))) '(2 (U W) ((P W (F W))))))
  (test "subsume yes cv" T (subsume '(1 (X Y) ((P X Y))) '(2 (U) ((P U A)))))
  (test "subsume no " nil (subsume '(1 (X Y) ((P X (F Y)))) '(2 (W) ((P W (G W))))))
  (test "subsume no " nil (subsume '(1 (X Y) ((P (G X) (F X)))) '(2 (U W) ((P W W)))))
  (test "subsume no " nil (subsume '(1 (X Y) ((P (G X) (F Y)))) '(2 (U W) ((P (G W))))))
)

(deftest test-stest () "for stest" )

(deftest test-contradict () "for contradict" 
  (test "contradict nil nil" nil (contradict () ()))
  (test "contradict nil one" nil (contradict () '((1 () ((P a)))))) 
  (test "contradict one nil" nil (contradict '((1 () ((P a)))) ()))
  (test "contradict 1 1" '(contradiction 1 2) (contradict '((1 () ((P a)))) '((2 () ((not P a))))))
  (test "contradict 2 1" '(contradiction 3 2) (contradict '((1 () ((P a)))(3 () ((Q a)))) '((2 () ((not Q a)))(4 () ((not P b))))))
  (test "contradict 2 2" '(contradiction 3 4) (contradict '((1 () ((P a)))(3 () ((Q a)))) '((2 () ((not P b)))(4 () ((not Q a))))))
  (test "contradict no" '() (contradict '((1 () ((Q a)))(3()((P a)))) '((2 () ((not Q b)))(4 ()((not P b))))))
)

(deftest test-dtree () "for dtree" 
;; infinite loop  (test "dtree immediate contradiction" '((CONTRADICTION 1 2)) (dtree '(CONTRADICTION 1 2) '() 1))
  (test "dtree immediate contradiction weird" '((CONTRADICTION 1 2)) (dtree '(CONTRADICTION 1 2) '((2 1 1 1)) 2))

  (test "dtree from ex1" '((6 3 4 4) (11 2 6 2) (15 1 11 1) (CONTRADICTION 1 15))
         (dtree '(CONTRADICTION 1 15)
                '((6 3 4 4) (7 1 6 1) (8 1 6 2) (9 1 6 3) (10 2 6 1) (11 2 6 2)
                 (12 2 6 3) (13 1 12 1) (14 1 12 2) (15 1 11 1) (16 1 11 2)
                 (17 1 10 2) (18 1 9 1) (19 1 9 2) (20 1 8 1) (21 1 8 2) (22 1 7 1)
                 (23 1 7 2) (24 2 12 1) (25 2 10 2))
                 5))
)

(deftest test-tpu () "for tpu" )

(deftest test-all ()
 (test-set "tests for tpu"
(format t "some tests called  wierd are what I cant see what is it~%")
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

