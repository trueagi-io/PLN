;; TRUTH FORMULAS

; Deduction formula: PLN book "1.4 Truth-value Formulas", page 15:
; borrowed from https://github.com/trueagi-io/hyperon-pln/blob/main/metta/pln/dependent-types/DeductionDTL.metta
(= (Truth_Deduction (stv $Ps $Pc)
                    (stv $Qs $Qc)
                    (stv $Rs $Rc)
                    (stv $PQs $PQc)
                    (stv $QRs $QRc))
   (if (and (conditional-probability-consistency $Ps $Qs $PQs)
            (conditional-probability-consistency $Qs $Rs $QRs))
       ;; Preconditions are met
       (stv (if (< 0.9999 $Qs)                  ; avoid division by 0
                ;; Qs tends to 1
                $Rs
                ;; Otherwise
                (+ (* $PQs $QRs) (/ (* (- 1 $PQs) (- $Rs (* $Qs $QRs))) (- 1 $Qs))))
            (min $Pc (min $Qc (min $Rc (min $PQc $QRc)))))
       ;; Preconditions are not met
       (stv 1 0)))

; Induction formula: PLN book "Appendix A: Comparison of PLN Rules with NARS Rules", page 307
(= (Truth_Induction (stv $sA $cA)
                    (stv $sB $cB)
                    (stv $sC $cC)
                    (stv $sAB $cAB)
                    (stv $sBC $cBC))
   (stv (+ (/ (* (* $sBA $sBC) $sB)
              $sA)
           (* (- 1 (/ (* $sBA $sB) 
                      $sA))
              (/ (- $sC (* $sB $sBC))
                 (- 1 $sB))))
        (Truth_w2c (min $cAB $cBc)))) ;confidence TODO check

; Abduction formula: PLN book "Appendix A: Comparison of PLN Rules with NARS Rules", page 307
(= (Truth_Abduction (stv $sA $cA)
                    (stv $sB $cB)
                    (stv $sC $cC)
                    (stv $sAB $cAB)
                    (stv $sBC $cBC))
   (stv (+ (/ (* (* $sAB $sCB) $sC)
              $sB)
           (/ (* sC (* (- 1 sAB) (- 1 sCB)))
              (- 1 sB)))
        (Truth_w2c (min $cAB $cBc)))) ;confidence TODO check

;Modus Ponens: PLN book "5.7.1 Modus Ponens", page 111:
(= (Truth_ModusPonens (stv $f1 $c1) (stv $f2 $c2)) 
   (stv (+ (* $f1 $f2) (* 0.02 (- 1 $f1)))
        (min $c1 $c2)))

;Revision: PLN Book "5.10.2 A Heuristic Revision Rule for Simple Truth-values", page 116:
(: Truth_c2w (-> Number Number))
(= (Truth_c2w $c)
   (/ $c (- 1 $c)))

(: Truth_w2c (-> Number Number))
(= (Truth_w2c $w)
   (/ $w (+ $w 1)))

(= (Truth_Revision (stv $f1 $c1) (stv $f2 $c2))
   (let* (($w1 (Truth_c2w $c1)) ($w2 (Truth_c2w $c2)) ($w  (+ $w1 $w2))
          ($f (/ (+ (* $w1 $f1) (* $w2 $f2)) $w)) ($c (Truth_w2c $w)))
          (stv (min 1.00 $f) 
               (min 1.0 (max (max $c $c1) $c2)))))

; negation
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/negation-introduction.scm#L41
(= (Truth_negationIntroduction (stv $s $c))
   (stv (- 1.0 $s) $c))

; negation elimination
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/not-elimination.scm#L34
(= (Truth_negationElimination (stv $s $c))
   (stv (- 1.0 $s) $c))

