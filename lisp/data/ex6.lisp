;;; Example 6
(print
(tpu 
  '((1 (X)((P E X X)))
    (2 (X)((P X E X)))
    (3 (X)((P X (I X) E)))
    (4 (X)((P (I X) X E)))
    (5 ()((S B))) 
   )
  '((6 ()((NOT S (I B)))))
  '((7 (X Y Z)((NOT S X)(NOT S Y)(NOT P X (I Y) Z)(S Z)))
    (8 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
    (9 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W)))
   )
  '((5 6) nil nil)
  9 
  4
  5
  0)
)

;;; OUTPUT
;; ((11 5 7 1)(19 5 11 1)(23 3 19 1)(152 23 7 1)(169 6 152 3)(186 5 169 1)(contradiction 1 186))

