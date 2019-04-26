;;; example1

(tpu
  '((1 (X Y) ((P (G X Y) X Y)))
    (2 (X Y) ((P X (H X Y) Y))))
  '((3 (X) ((NOT P (K X) X (K X)))))
  '((4 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P X V W)(P U Z W)))
    (5 (X Y Z U V W)((NOT P X Y U)(NOT P Y Z V)(NOT P U Z W)(P X V W))) )
  '((3) NIL)
  5
  2
  3
  0)


