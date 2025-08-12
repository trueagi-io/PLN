;; INFERENCE RULES

;Revision
(= (|- ($T $T1) ($T $T2)) ($T (Truth_Revision $T1 $T2)))

;;NAL-1
;;!Syllogistic rules for Inheritance:
(= (|- ((Inheritance $a $b) $T1) ((Inheritance $b $c) $T2)) ((Inheritance $a $c) (Truth_Deduction $T1 $T2)))
(= (|- ((Inheritance $a $b) $T1) ((Inheritance $a $c) $T2)) ((Inheritance $c $b) (Truth_Induction $T1 $T2)))
(= (|- ((Inheritance $a $c) $T1) ((Inheritance $b $c) $T2)) ((Inheritance $b $a) (Truth_Abduction $T1 $T2)))
;(= (|- ((Inheritance $a $b) $T1) ((Inheritance $b $c) $T2)) ((Inheritance $c $a) (Truth_Exemplification $T1 $T2)))

;;NAL-2
;;!Rules for Similarity:
;(= (|- ((Similarity $S $P) $T)) ((Similarity $P $S) (Truth_StructuralIntersection $T)))
;(= (|- ((Similarity $M $P) $T1) ((Similarity $S $M) $T2)) ((Similarity $S $P) (Truth_Resemblance $T1 $T2)))
;(= (|- ((Inheritance $P $M) $T1) ((Inheritance $S $M) $T2)) ((Similarity $S $P) (Truth_Comparison $T1 $T2)))
;(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M $S) $T2)) ((Similarity $S $P) (Truth_Comparison $T1 $T2)))
;(= (|- ((Inheritance $M $P) $T1) ((Similarity $S $M) $T2)) ((Inheritance $S $P) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance $P $M) $T1) ((Similarity $S $M) $T2)) ((Inheritance $P $S) (Truth_Analogy $T1 $T2)))
;;!Dealing with properties and instances:
;(= (|- ((Inheritance $S (ExtSet $P)) $T)) ((Similarity $S (ExtSet $P)) (Truth_StructuralIntersection $T)))
;(= (|- ((Inheritance (IntSet $S) $P) $T)) ((Similarity (IntSet $S) $P) (Truth_StructuralIntersection $T)))
;(= (|- ((Inheritance (ExtSet $M) $P) $T1) ((Similarity $S $M) $T2)) ((Inheritance (ExtSet $S) $P) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance $P (IntSet $M)) $T1) ((Similarity $S $M) $T2)) ((Inheritance $P (IntSet $S)) (Truth_Analogy $T1 $T2)))
;(= (|- ((Similarity (ExtSet $A) (ExtSet $B)))) ((Similarity $A $B) (Truth_StructuralIntersection $T)))
;(= (|- ((Similarity (IntSet $A) (IntSet $B)))) ((Similarity $A $B) (Truth_StructuralIntersection $T)))

;;NAL-3
;;!Set decomposition:
(= (|- ((Inheritance (ExtSet $A $B) $M) $T)) ((Inheritance (ExtSet $A) $M) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance (ExtSet $A $B) $M) $T)) ((Inheritance (ExtSet $B) $M) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance M (IntSet $A $B)) $T)) ((Inheritance M (IntSet $A)) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance M (IntSet $A $B)) $T)) ((Inheritance M (IntSet $B)) (Truth_StructuralDeduction $T)))
;;!Extensional and intensional intersection decomposition:
(= (|- ((Inheritance (IntInt $S $P) $M) $T)) ((Inheritance $S $M) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance $M (ExtInt $S $P)) $T)) ((Inheritance $M $S) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance (IntInt $S $P) $M) $T)) ((Inheritance $P $M) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance $M (ExtInt $S $P)) $T)) ((Inheritance $M $P) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance (IntDiff $A $S) $M) $T)) ((Inheritance $A $M) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance $M (ExtDiff $B $S)) $T)) ((Inheritance $M $B) (Truth_StructuralDeduction $T)))
(= (|- ((Inheritance (IntDiff $A $S) $M) $T)) ((Inheritance $S $M) (Truth_StructuralDeductionNegated $T)))
(= (|- ((Inheritance $M (ExtDiff $B $S)) $T)) ((Inheritance $M $S) (Truth_StructuralDeductionNegated $T)))
;;!Extensional and intensional intersection composition: (sets via reductions)
;;(= (|- ((Inheritance $P $M) $T1) ((Inheritance $S $M) $T2)) ((Inheritance (IntInt $P $S) $M) (Truth_Intersection $T1 $T2)))
;;(= (|- ((Inheritance $P $M) $T1) ((Inheritance $S $M) $T2)) ((Inheritance (ExtInt $P $S) $M) (Truth_Union $T1 $T2)))
;;(= (|- ((Inheritance $P $M) $T1) ((Inheritance $S $M) $T2)) ((Inheritance (IntDiff $P $S) $M) (Truth_Difference $T1 $T2)))
;;(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M $S) $T2)) ((Inheritance $M (ExtInt $P $S)) (Truth_Intersection $T1 $T2)))
;;(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M $S) $T2)) ((Inheritance $M (IntInt $P $S)) (Truth_Union $T1 $T2)))
;;(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M $S) $T2)) ((Inheritance $M (ExtDiff $P $S)) (Truth_Difference $T1 $T2)))
;;!Extensional and intensional intersection decomposition:
(= (|- ((Inheritance $S $M) $T1) ((Inheritance (IntInt $S $P) $M) $T2)) ((Inheritance $P $M) (Truth_DecomposePNN $T1 $T2)))
(= (|- ((Inheritance $P $M) $T1) ((Inheritance (IntInt $S $P) $M) $T2)) ((Inheritance $S $M) (Truth_DecomposePNN $T1 $T2)))
(= (|- ((Inheritance $S $M) $T1) ((Inheritance (ExtInt $S $P) $M) $T2)) ((Inheritance $P $M) (Truth_DecomposeNPP $T1 $T2)))
(= (|- ((Inheritance $P $M) $T1) ((Inheritance (ExtInt $S $P) $M) $T2)) ((Inheritance $S $M) (Truth_DecomposeNPP $T1 $T2)))
(= (|- ((Inheritance $S $M) $T1) ((Inheritance (IntDiff $S $P) $M) $T2)) ((Inheritance $P $M) (Truth_DecomposePNP $T1 $T2)))
(= (|- ((Inheritance $S $M) $T1) ((Inheritance (IntDiff $P $S) $M) $T2)) ((Inheritance $P $M) (Truth_DecomposeNNN $T1 $T2)))
(= (|- ((Inheritance $M $S) $T1) ((Inheritance $M (ExtInt $S $P)) $T2)) ((Inheritance $M $P) (Truth_DecomposePNN $T1 $T2)))
(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M (ExtInt $S $P)) $T2)) ((Inheritance $M $S) (Truth_DecomposePNN $T1 $T2)))
(= (|- ((Inheritance $M $S) $T1) ((Inheritance $M (IntInt $S $P)) $T2)) ((Inheritance $M $P) (Truth_DecomposeNPP $T1 $T2)))
(= (|- ((Inheritance $M $P) $T1) ((Inheritance $M (IntInt $S $P)) $T2)) ((Inheritance $M $S) (Truth_DecomposeNPP $T1 $T2)))
(= (|- ((Inheritance $M $S) $T1) ((Inheritance $M (ExtDiff $S $P)) $T2)) ((Inheritance $M $P) (Truth_DecomposePNP $T1 $T2)))
(= (|- ((Inheritance $M $S) $T1) ((Inheritance $M (ExtDiff $P $S)) $T2)) ((Inheritance $M $P) (Truth_DecomposeNNN $T1 $T2)))

;; NAL-4
;;!Transformation rules between product and image:
;;(= (|- ((Inheritance (Product $A $B) $R) $T)) ((Inheritance $A (ExtImage1 $R $B)) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance (Product $A $B) $R) $T)) ((Inheritance $B (ExtImage2 $R $A)) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance $R (Product $A $B)) $T)) ((Inheritance (IntImage1 $R $B) $A) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance $R (Product $A $B)) $T)) ((Inheritance (IntImage2 $R $A) $B) (Truth_StructuralIntersection $T)))
;;other direction of same rules (as these are bi-directional)
;;(= (|- ((Inheritance $A (ExtImage1 $R $B)) $T)) ((Inheritance (Product $A $B) $R) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance $B (ExtImage2 $R $A)) $T)) ((Inheritance (Product $A $B) $R) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance (IntImage1 $R $B) $A) $T)) ((Inheritance $R (Product $A $B)) (Truth_StructuralIntersection $T)))
;;(= (|- ((Inheritance (IntImage2 $R $A) $B) $T)) ((Inheritance $R (Product $A $B)) (Truth_StructuralIntersection $T)))
;;!Optional rules for more efficient reasoning about relation components:
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance (Product $C $B) $R) $T2)) ((Inheritance $C $A) (Truth_Abduction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance (Product $A $C) $R) $T2)) ((Inheritance $C $B) (Truth_Abduction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $R (Product $C $B)) $T2)) ((Inheritance $C $A) (Truth_Induction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $R (Product $A $C)) $T2)) ((Inheritance $C $B) (Truth_Induction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance $C $A) $T2)) ((Inheritance (Product $C $B) $R) (Truth_Deduction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance $A $C) $T2)) ((Inheritance (Product $C $B) $R) (Truth_Induction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Similarity $C $A) $T2)) ((Inheritance (Product $C $B) $R) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance $C $B) $T2)) ((Inheritance (Product $A $C) $R) (Truth_Deduction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance $B $C) $T2)) ((Inheritance (Product $A $C) $R) (Truth_Induction $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Similarity $C $B) $T2)) ((Inheritance (Product $A $C) $R) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $A $C) $T2)) ((Inheritance $R (Product $C $B)) (Truth_Deduction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $C $A) $T2)) ((Inheritance $R (Product $C $B)) (Truth_Abduction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Similarity $C $A) $T2)) ((Inheritance $R (Product $C $B)) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $B $C) $T2)) ((Inheritance $R (Product $A $C)) (Truth_Deduction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $C $B) $T2)) ((Inheritance $R (Product $A $C)) (Truth_Abduction $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Similarity $C $B) $T2)) ((Inheritance $R (Product $A $C)) (Truth_Analogy $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance (Product $C $B) $R) $T2)) ((Similarity $A $C) (Truth_Comparison $T1 $T2)))
;(= (|- ((Inheritance (Product $A $B) $R) $T1) ((Inheritance (Product $A $C) $R) $T2)) ((Similarity $B $C) (Truth_Comparison $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $R (Product $C $B)) $T2)) ((Similarity $A $C) (Truth_Comparison $T1 $T2)))
;(= (|- ((Inheritance $R (Product $A $B)) $T1) ((Inheritance $R (Product $A $C)) $T2)) ((Similarity $B $C) (Truth_Comparison $T1 $T2)))

;;NAL-5
;;!Negation introduction and elimination
(= (|- ($x (stv $f $c)))
   (case $x (((Not $y) ($y (Truth_Negation (stv $f $c)))) ;eliminate if it is already a Not
             ;($z ((Not $z) (Truth_Negation (stv $f (* 0.5 $c)))))
             ))) ;penalize for now
