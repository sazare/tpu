;;; Example 5
(print
(tpu 
  '((1 (X)((P E X X)))
    (2 (X)((P X E X)))
    (3 (X)((P X (I X) E)))
    (4 (X)((P (I X) X E)))
    (5 ()((S A))) 
   )
  '((6 ()((NOT S E))))
  '((7 (X Y Z)((NOT S X)(NOT S Y)(NOT P X (I Y) Z)(S Z)))
    (8 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
    (9 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W)))
   )
  '((6) nil nil)
  9 
  4
  5
  0)
)

;;; OUTPUT
;; ((10 6 7 4)(14 5 10 2)(18 5 14 1)(contradiction 3 18))

