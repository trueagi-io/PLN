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
                (+ (* $PQs $QRs) (/safe (* (- 1 $PQs) (- $Rs (* $Qs $QRs))) (- 1 $Qs))))
            (min $Pc (min $Qc (min $Rc (min $PQc $QRc)))))
       ;; Preconditions are not met
       (stv 1 0)))

; Induction formula: PLN book "Appendix A: Comparison of PLN Rules with NARS Rules", page 307
(= (Truth_Induction (stv $sA $cA)
                    (stv $sB $cB)
                    (stv $sC $cC)
                    (stv $sBA $cBA)
                    (stv $sBC $cBC))
   (stv (+ (/safe (* (* $sBA $sBC) $sB) $sA)
           (* (- 1 (/safe (* $sBA $sB) $sA))
              (/safe (- $sC (* $sB $sBC)) (- 1 $sB))))
        (Truth_w2c (min $cBA $cBC)))) ;confidence TODO check

; Abduction formula: PLN book "Appendix A: Comparison of PLN Rules with NARS Rules", page 307
(= (Truth_Abduction (stv $sA $cA)
                    (stv $sB $cB)
                    (stv $sC $cC)
                    (stv $sAB $cAB)
                    (stv $sCB $cCB))
   (stv (+ (/safe (* (* $sAB $sCB) $sC)
                  $sB)
           (/safe (* $sC (* (- 1 $sAB) (- 1 $sCB)))
                  (- 1 $sB)))
        (Truth_w2c (min $cAB $cCB)))) ;confidence TODO check

;Modus Ponens: PLN book "5.7.1 Modus Ponens", page 111:
(= (Truth_ModusPonens (stv $f1 $c1) (stv $f2 $c2)) 
   (stv (+ (* $f1 $f2) (* 0.02 (- 1 $f1)))
        (min $c1 $c2)))

; SymmetricModusPonens rule   see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (Truth_SymmetricModusPonens (stv $sA $cA) (stv $sAB $cAB))
   (let*
      (($snotAB 0.2)
       ($cnotAB 1.0))
      (stv
         (+ (* $sA $sAB) (* (* $snotAB (negate $sA)) (+ 1.0 $sAB))) 
         (min (min $cAB $cnotAB) $cA))))

;Revision: PLN Book "5.10.2 A Heuristic Revision Rule for Simple Truth-values", page 116:
(: Truth_c2w (-> Number Number))
(= (Truth_c2w $c)
   (/safe $c (- 1 $c)))

(: Truth_w2c (-> Number Number))
(= (Truth_w2c $w)
   (/safe $w (+ $w 1)))

(= (Truth_Revision (stv $f1 $c1) (stv $f2 $c2))
   (let* (($w1 (Truth_c2w $c1)) ($w2 (Truth_c2w $c2)) ($w  (+ $w1 $w2))
          ($f (/safe (+ (* $w1 $f1) (* $w2 $f2)) $w)) ($c (Truth_w2c $w)))
          (stv (min 1.00 $f)
               (min 1.0 (max (max $c $c1) $c2)))))

; negation, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/negation-introduction.scm#L41
; negation elimination, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/not-elimination.scm#L34
(= (Truth_negation (stv $s $c))
   (stv (- 1.0 $s) $c))

(= (Truth_inversion (stv $Bs $Bc) (stv $ABs $ABc))
   ; confidence depends on Truth of (target) B node, which is not according to OpenCOG classic.
   ; confidence penality not according to OpenCOG classic PLN. Is weaker in this implementation.
   (stv $ABs (* $Bc (* $ABc 0.6))))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/equivalence-to-implication.scm
(= (Truth_equivalenceToImplication (stv $As $Ac) (stv $Bs $Bc) (stv $ABs $ABc))
   (let* (($AB2s (if (< 0.99 (* $ABs $ABc)) ; HACK to work around the lack of distributional
                     $ABs                   ; TV.  If ABs is high enough, we just set AB2s as ABs
                     (/safe (* (* 1.0 (/safe $Bs $As)) $ABs) (+ 1.0 $ABs))))) ; see PLN book formula for sim2inh
         (stv $AB2s $ABc)))

(= (ImplicationImplicantConjunctionStrength $sC $sAC $sBC)
   (min (/safe (* $sAC $sBC) $sC) 1.0))

(= (ImplicationImplicantConjunctionConfidence $cAC $cBC)
   (min $cAC $cBC))

; Implication Implicant Conjunction Rule, see https://github.com/opencog/pln/blob/75815f9f21ad899f44eccba1921fa253a7c6216f/opencog/pln/rules/wip/implication-implicant-conjunction.scm
(= (Truth_ImplicationImplicantConjunction (stv $As $Ac) (stv $Bs $Bc) (stv $Cs $Cc) (stv $ACs $ACc) (stv $BCs $BCc))   
   (if (Consistency_ImplicationImplicantConjunction $As $Bs $Cs $ACs $BCs)
       (stv (ImplicationImplicantConjunctionStrength $Cs $ACs $BCs)
            (ImplicationImplicantConjunctionConfidence $ACc $BCc))
       ; Preconditions are not met
       (stv 1 0)))

; Implication Implicant Disjunction Strength Formula
(= (ImplicationImplicantDisjunctionStrength $sA $sB $sAC $sBC)
   (let* (($CinterA (* $sAC $sA))
          ($CinterB (* $sBC $sB))
          ($Numerator (+ $CinterA (+ $CinterB (* $CinterA (* $CinterB (* $sA (* $sB -1.0))))))) ; As per Scheme code
          ($Denominator (+ (+ $sA $sB) (* $sA (* $sB -1.0)))))
         (/safe $Numerator $Denominator)))

; Implication Implicant Disjunction Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/implication-implicant-disjunction.scm
(= (Truth_ImplicationImplicantDisjunction (stv $sA $cA) (stv $sB $cB) (stv $sC $cC) (stv $sAC $cAC) (stv $sBC $cBC))
   (stv (ImplicationImplicantDisjunctionStrength $sA $sB $sAC $sBC)
        (min $cAC $cBC)))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/inheritance-to-member.scm
(= (Truth_inheritanceToMember (stv $s $c))
   (stv $s (* $c 0.9)))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/term/condition-negation.scm
(= (Truth_ConditionNegation (stv $As $Ac) (stv $Bs $Bc) (stv $Ss $Sc))
   (let* (($NAs (- 1.0 $As))
          ($ConclS (if (< $As 1.0)
                       (/safe (- $Bs (* $Ss $As)) $NAs)
                       1.0))
          ($ConclC (if (< $As 1.0)
                       (min (Truth_w2c (* (Truth_c2w $Ac) $NAs)) $Sc)
                       0.0)))))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/formulas.scm#L160-L173
(= (TransitiveSimilarityStrength $sA $sB $sC $sAB $sBC)
   (let* (($T1 (/ (* (+ 1.0 (/ $sB $sA)) $sAB) (+ 1.0 $sAB)))
          ($T2 (/ (* (+ 1.0 (/ $sC $sB)) $sBC) (+ 1.0 $sBC)))
          ($T3 (/ (* (+ 1.0 (/ $sB $sC)) $sBC) (+ 1.0 $sBC)))
          ($T4 (/ (* (+ 1.0 (/ $sA $sB)) $sAB) (+ 1.0 $sAB))))
         (invert (- (+ (invert (+ (* $T1 $T2) (* (negate $T1) (/ (- $sC (* $sB $T2)) (negate $sB)))))
                       (invert (+ (* $T3 $T4) (* (negate $T3) (/ (- $sC (* $sB $T4)) (negate $sB)))))) 1.0))))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/transitive-similarity.scm
(= (Truth_transitiveSimilarity (stv $As $Ac)
                               (stv $Bs $Bc)
                               (stv $Cs $Cc)
                               (stv $ABs $ABc)
                               (stv $BCs $BCc))
   (let* (($ConclS (TransitiveSimilarityStrength $As $Bs $Cs $ABs $BCs))
          ($ConclC (min $ABc $BCc)))
         (stv $ConclS $ConclC)))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/formulas.scm
(= (simpleDeductionStrength $sA $sB $sC $sAB $sBC)
  (if (and (conditional-probability-consistency $sA $sB $sAB)
           (conditional-probability-consistency $sB $sC $sBC))
     ;; Preconditions are met
     (if (< 0.99 $sB)
        ;; sB tends to 1
        $sC
        ;; otherwise
        (+ (* $sAB $sBC) (/safe (* (- 1.0 $sAB) (- $sC (* $sB $sBC))) (- 1.0 $sB))))
     ;; Preconditions are not met
     (empty)))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/evaluation-implication.scm
(= (Truth_evaluationImplication (stv $As $Ac)
                                (stv $Bs $Bc)
                                (stv $Cs $Cc)
                                (stv $ABs $ABc)
                                (stv $ACs $ACc))
   (let* (($ConclS (simpleDeductionStrength $Bs $As $Cs $ABs $ACs))
          ($ConclC (* (* 0.9 0.9)
                      (min5 $Bc $Ac $Cc $ACc (* 0.9 $ABc)))))
         (stv $ConclS $ConclC)))

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/equivalence-to-implication.scm
(= (Truth_equivalenceToImplication (stv $As $Ac) (stv $Bs $Bc) (stv $ABs $ABc))
    (let* (($ConclS (if (< 0.99 (* $ABs $ABc)) ; Hack to work around the lack of distributional
                                               ; TV. If ABs is high enough, we just set $ConclS as $ABs
                  $ABs
                  ;; Formula based on PLN book formula for sim2inh
                  (/ (* (+ 1.0 (/ $Bs $As)) $ABs) (+ 1.0 $ABs)))))
        (stv $ConclS $ABc)))
