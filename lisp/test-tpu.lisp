(load "test.lisp")

(load "tpu.lisp")

(deftest test-rename () "for rename"
  (test "simple" '(1 (u v)(P u v))  (rename '(1 (x y) ((P x y))) '(u v)))
  (test "2literals" '(1 (x1 x2) ((P x1)(neg P x2))) 
         (rename '(1 (x y) ((P x)(neg P y))) '(x1 x2)))
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
  (test "disag tail dis" '(y h w) (disagree '(f z y) '(f z (h w))) )
)

(deftest test-unification () "for uification"

)

(deftest test-deletev () "for deletev"

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

