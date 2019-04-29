# tpu
I'd like to translate tpu to Commonlisp and Julia

TPU is a program written in Symbolic Logic and Mechanical Theorem Proving by Chn-Liang Chang and Richard Char-Tung Lee

The original code is written as..
1) define functions with defprop not defun
2) define variables with defprop not defvar
3) used cond and go/tag for control flow
and so on.

I will rewrite..
1) defun for function definition.
2) defvar for variable defninition.
3) Commonlisp constructs for control flows.

