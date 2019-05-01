;;; example 3
(test
 "Example3"
 '((13 3 5 4)(16 2 13 2)(17 1 16 2)(18 17 4 4)(23 2 18 3)(24 1 23 2) (30 24 5 4)(46 2 30 2)(56 2 46 1)(CONTRADICTION 1 56))
  (tpu 
   '((1 (X)((P E X X)))
     (2 (X)((P (I X) X E))))
   '((3 () ((NOT P A E A))))
   '((4 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
     (5 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W))))
   '((3)(3))
   5
   4
   5
   0)
)

;;; OUTPUT 
;; ((13 3 5 4)(16 2 13 2)(17 1 16 2)(18 17 4 4)(23 2 18 3)(24 1 23 2) (30 24 5 4)(46 2 30 2)(56 2 46 1)(CONTRADICTION 1 56))

