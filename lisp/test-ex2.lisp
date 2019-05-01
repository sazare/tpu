;; ex2.lisp
(test
  "Example2"
  '((8 4 6 1)(21 3 8 1)(30 2 21 1)(32 30 7 2)(42 3 32 1)(55 1 42 1) (62 55 6 1)(112 5 62 3)(130 3 112 1)(CONTRADICTION 2 130))
  (tpu
   '((1 (X) ((P E X X)))
     (2 (X) ((P X E X)))
     (3 (X) ((P X X E)))
     (4 ()  ((P A B C))))
   '((5 ()  ((NOT P B A C))))
   '((6 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
     (7 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W))))
   '((4) NIL)
   7
   4
   5
   0)
)

;; OUTPUT
;; ((8 4 6 1)(21 3 8 1)(30 2 21 1)(32 30 7 2)(42 3 32 1)(55 1 42 1) (62 55 6 1)(112 5 62 3)(130 3 112 1)(CONTRADICTION 2 130))

