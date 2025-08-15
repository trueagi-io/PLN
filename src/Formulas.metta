;; Truth functions
(= (Truth_c2w $c)
   (/ $c (- 1 $c)))

(= (Truth_w2c $w)
   (/ $w (+ $w 1)))

(= (Truth_Deduction (stv $f1 $c1)
                    (stv $f2 $c2))
   (stv (* $f1 $f2) (* (* $f1 $f2) (* $c1 $c2))))

(= (Truth_Abduction (stv $f1 $c1) 
                    (stv $f2 $c2))
   (stv $f2 (Truth_w2c (* (* $f1 $c1) $c2))))

(= (Truth_Induction $T1 $T2)
   (Truth_Abduction $T2 $T1))

(= (Truth_Exemplification (stv $f1 stv $c1) 
                          (stv $f2 $c2))
   (stv 1.0 (Truth_w2c (* (* $f1 $f2) (* $c1 $c2)))))

(= (Truth_StructuralDeduction $T)
   (Truth_Deduction $T (stv 1.0 0.9)))
  
(= (Truth_Negation (stv $f $c))
   (stv (- 1 $f) $c))

(= (Truth_StructuralDeductionNegated $T)
   (Truth_Negation (Truth_StructuralDeduction $T)))

(= (Truth_Intersection (stv $f1 $c1) 
                       (stv $f2 $c2))
   (stv (* $f1 $f2) (* $c1 $c2)))

(= (Truth_StructuralIntersection $T)
   (Truth_Intersection $T (stv 1.0 0.9)))

(= (Truth_or $a $b)
   (- 1 (* (- 1 $a) (- 1 $b))))

(= (Truth_Comparison (stv $f1 $c1)
                     (stv $f2 $c2))
   (let $f0 (Truth_or $f1 $f2) 
        (stv (if (== $f0 0.0)
                 0.0 
                 (/ (* $f1 $f2) $f0))
             (Truth_w2c (* $f0 (* $c1 $c2))))))
  
(= (Truth_Analogy (stv $f1 $c1)
                  (stv $f2 $c2))
   (stv (* $f1 $f2) (* (* $c1 $c2) $f2)))

(= (Truth_Resemblance (stv $f1 $c1)
                      (stv $f2 $c2))
   (stv (* $f1 $f2) (* (* $c1 $c2) (Truth_or $f1 $f2))))

(= (Truth_Union (stv $f1 $c1)
                (stv $f2 $c2))
   ((Truth_or $f1 $f2) (* $c1 $c2)))

(= (Truth_Difference (stv $f1 $c1)
                     (stv $f2 $c2))
   (stv (* $f1 (- 1 $f2)) (* $c1 $c2)))

(= (Truth_DecomposePNN (stv $f1 $c1)
                       (stv $f2 $c2))
   (let $fn (* $f1 (- 1 $f2))
        (stv (- 1 $fn) (* $fn (* $c1 $c2)))))

(= (Truth_DecomposeNPP (stv $f1 $c1)
                       (stv $f2 $c2))
   (let $f (* (- 1 $f1) $f2)
        (stv $f (* $f (* $c1 $c2)))))

(= (Truth_DecomposePNP (stv $f1 $c1)
                       (stv $f2 $c2))
   (let $f (* $f1 (- 1 $f2))
        (stv $f (* $f (* $c1 $c2)))))

(= (Truth_DecomposePPP $v1 $v2)
   (Truth_DecomposeNPP (Truth_Negation $v1) $v2))

(= (Truth_DecomposeNNN (stv $f1 $c1)
                       (stv $f2 $c2))
   (let $fn (* (- 1 $f1) (- 1 $f2))
        ((- 1 $fn) (* $fn (* $c1 $c2)))))

(= (Truth_Eternalize (stv $f $c))
   (stv $f (Truth_w2c $c)))

(= (Truth_Revision (stv $f1 $c1)
                   (stv $f2 $c2))
   (let* (($w1 (Truth_c2w $c1))
          ($w2 (Truth_c2w $c2))
          ($w  (+ $w1 $w2))
          ($f (/ (+ (* $w1 $f1) (* $w2 $f2)) $w))
          ($c (Truth_w2c $w)))
          (stv (min 1.00 $f) (min 0.99 (max (max $c $c1) $c2)))))

(= (Truth_Expectation (stv $f $c))
   (+ (* $c (- $f 0.5)) 0.5))

(= (Truth_Identity $X) $X)
