;;; Example 7
(print
(tpu 
  '((1 ()((P a)))
    (2 ()((M A (S C)(S B))))
    (3 (X)((M X X (S X))))
   )
  '((4 ()((NOT D A B))))
  '((5 (X Y Z)((NOT M X Y Z)(M Y X Z)))
    (6 (X Y Z)((NOT M X Y Z)(D X Z)))
    (7 (X Y Z U)((NOT P X)(NOT M Y Z U)(NOT D X U)(D X Y)(D X Z)))
   )
  '((1 2 3 4) (1 2 3 4)(1 2 3 4))
   7
   4
   5 
   0)
)

;;; OUTPUT
;; ((13 2 6 1)(16 13 7 3)(43 4 16 3)(66 4 43 3)(73 3 66 2)(contradiction 1 75))

