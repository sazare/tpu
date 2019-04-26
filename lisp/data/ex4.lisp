;;; Example 4

(tpu 
  '((1 (X)((P E X X)))
    (2 (X)((P (I X) X E))) )
  '((3 (X)((NOT P A X E))) )
  '((4 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
    (5 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W))))
  '((3)(3))
  5
  4
  5
  0)

;;; OUTPUT
;; ((6 3 4 4)(11 2 6 3)(12 1 11 2)(20 12 5 4)(42 2 20 2)(62 2 42 1)(CONTRADICTION 1 62))
1
