;;; Example 9
(print
(tpu 
  '((1 (X)((L X (F X)))))
  '((2 (X)((NOT L X X))))
  '((3 (X Y)((NOT L X Y)(NOT L Y X)))
    (4 (X Y)((NOT D X (F Y))(L Y X)))
    (5 (X)((P X)(D (H X) X)))
    (6 (X)((P X)(P (H X))))
    (7 (X)((P X)(L (H X) X)))
    (8 (X)((NOT P X)(NOT L A X)(L (F A) X)))
   )
  '((1 2)(1 2)(1 2)(1 2)(1 2)(1 2))
   8
   20
   21
   0)
)

;;; OUTPUT
;; ((14 2 8 3)(16 1 14 2)(17 16 5 1)(18 16 6 1)(19 16 7 1)(20 19 3 1)(23 17 4 1)(24 23 8 2)(28 20 24 2)(contradiction 18 28))

