;;; Example 8
(test
  "Example8"
  '((10 2 6 2)(15 10 3 1)(16 10 4 1)(17 10 5 1)(23 17 8 2)(25 16 23 1)(26 17 9 2)(28 16 26 1)(32 25 6 1)(33 32 7 3)(47 28 33 1)(contradiction 15 47))
  (tpu 
    '((1 ()((L I A)))
      (2 (X)((D X X)))
     )
    NIL
    '((3 (X)((P X)(D (G X) X)))
      (4 (X)((P X)(L I (G X))))
      (5 (X)((P X)(L (G X) X)))
      (6 (X)((NOT P X)(NOT D X A)))
      (7 (X Y Z)((NOT D X Y)(NOT D Y Z)(D X Z))) 
      (8 (X)((NOT L I X)(NOT L X A)(P (F X))))
      (9 (X)((NOT L I X)(NOT L X A)(D (F X) X)))
     )
    '((1 2)(1 2)(1 2)(1 2)(1 2)(1 2)(1 2))
     9
     20
     21
     0)
)

;;; OUTPUT
;; ((10 2 6 2)(15 10 3 1)(16 10 4 1)(17 10 5 1)(23 17 8 2)(25 16 23 1)(26 17 9 2)(28 16 26 1)(32 25 6 1)(33 32 7 3)(47 28 33 1)(contradiction 15 47))

