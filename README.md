# tpu
A commonlisp translation from original TPU.

TPU is a program written in Symbolic Logic and Mechanical Theorem Proving by Chn-Liang Chang and Richard Char-Tung Lee.

no Julia version at 2021/03/21.

This repository has the TPU code with some example code.


The original program is written as..
1) define functions with defprop not defun
2) define variables with defprop not defvar
3) used cond and go/tag for control flow
and so on.

I rewrote them as..
1) defun for function definition.
2) defvar for variable defninition.
3) Commonlisp constructs for control flows.


* Whether the translation is correct was checked by comparing the result of examples whth the book's results, 

