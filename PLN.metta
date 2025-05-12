; MeTTa standard lib extension
(: If (-> Bool Atom Atom))
(= (If True $then) 
   $then)
(= (If False $then)
   (let $x 0 (let $x 1 $x)))

(: If (-> Bool Atom Atom Atom))
(= (If $cond $then $else)
   (if $cond $then $else))

(: (max (-> Number Number Bool)))
(= (max $1 $2)
   (if (> $1 $2) $1 $2))

(: (min (-> Number Number Bool)))
(= (min $1 $2)
   (if (< $1 $2) $1 $2))

(: (max (-> Number Number Number Number)))
(= (clamp $v $min $max)
   (min $max (max $v $min)))

(= (TupleConcat $Ev1 $Ev2)
   (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))

; Consistency Conditions: PLN book "5.2.2.2 PLN Deduction and Second-Order Probability", page 74:
(: smallest-intersection-probability (-> Number Number Number))
(= (smallest-intersection-probability $As $Bs)
   (clamp (/ (- (+ $As $Bs) 1) $As) 0 1))

(: largest-intersection-probability (-> Number Number Number))
(= (largest-intersection-probability $As $Bs)
   (clamp (/ $Bs $As) 0 1))

(: conditional-probability-consistency (-> Number Number Number Bool))
(= (conditional-probability-consistency $As $Bs $ABs)
   (and (< 0 $As)
        (and (<= (smallest-intersection-probability $As $Bs) $ABs)
             (<= $ABs (largest-intersection-probability $As $Bs)))))

;; TRUTH FORMULAS

;Deduction formula: PLN book "1.4 Truth-value Formulas", page 15:
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

;; INFERENCE RULES

;Revision
(= (|- ($T $T1) 
       ($T $T2))
       ($T (Truth_Revision $T1 $T2)))

;Modus Ponens
(= (|- ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (Truth_ModusPonens $T1 $T2)))

;Deduction
(= (|- ((Inheritance (Concept $A) (Concept $B)) $T1) 
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance $A $C) 
        (Truth_Deduction (STV $A) 
                         (STV $B)
                         (STV $C) $T1 $T2)))

;Induction
(= (|- ((Inheritance (Concept $C) 
                     (Concept $A)) $T1)
       ((Inheritance (Concept $C) 
                     (Concept $B)) $T2))
       ((Inheritance $A 
                     $B) (Truth_Induction (STV $A) 
                                          (STV $B)
                                          (STV $C) $T1 $T2)))

;Abduction
(= (|- ((Inheritance (Concept $A) (Concept $C)) $T1)
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance $A $B)
        (Truth_Abduction (STV $A) (STV $B) (STV $C) $T1 $T2)))

;Usage of inheritance for predicates
;unary arg
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C))) $T1)
       ((Inheritance (Concept $S) (Concept $C)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S))) (Truth_ModusPonens $T1 $T2)))

;binary arg1
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $C2))) $T1)
       ((Inheritance (Concept $S) (Concept $C1)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S) (Concept $C2))) (Truth_ModusPonens $T1 $T2)))

;binary arg2
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $C2))) $T1)
       ((Inheritance (Concept $S) (Concept $C2)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $S))) (Truth_ModusPonens $T1 $T2)))

;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True overlap)))))))

;; Exhaustive-until-depth deriver
(= (Derive $beliefs $depth $maxdepth)
   (If (> $depth $maxdepth)
       $beliefs
       (let $derivations 
            (collapse (let* (((Sentence $x $Ev1) (superpose $beliefs))
                             ((Sentence $y $Ev2) (superpose $beliefs))
                             ($stamp (TupleConcat $Ev1 $Ev2)))
                            (If (StampDisjoint $Ev1 $Ev2) 
                                (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)))))))
            (Derive (TupleConcat $beliefs $derivations) (+ $depth 1) $maxdepth))))

;retrieve the best candidate
(= (BestCandidate $evaluateCandidateFunction $bestCandidate $tuple)
  (If (== $tuple ())
      $bestCandidate
      (let* (($head (car-atom $tuple))
             ($tail (cdr-atom $tuple)))
            (If (> ($evaluateCandidateFunction $head)
                   ($evaluateCandidateFunction $bestCandidate))
                (BestCandidate $evaluateCandidateFunction $head $tail)
                (BestCandidate $evaluateCandidateFunction $bestCandidate $tail)))))

;candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;pose a question of a certain term to the system on some knowledge base
(= (Question $kb $term $steps)
   (BestCandidate ConfidenceRank () (collapse (let $x (Derive $kb 1 $steps) 
                                                   (case (superpose $x)
                                                         (((Sentence ($T $TV) $Ev) (case (== $T $term)
                                                                                          ((True ($TV $Ev)))))))))))

(= (STV (Concept Anna))
   (stv 0.1667 1))

(= (STV (Concept Bob))
   (stv 0.1667 1))

(= (STV (Concept Edward))
   (stv 0.1667 1))

(= (STV (Concept Frank))
   (stv 0.1667 1))

(= (STV (Concept Gary))
   (stv 0.1667 1))

(= (STV (Concept Helen))
   (stv 0.1667 1))

!(Question (
            (Sentence ((Implication (Evaluation (Predicate friend) 
                                                (List $1 $2))
                                    (Implication (Evaluation (Predicate smokes) 
                                                             (List $1)) 
                                                 (Evaluation (Predicate smokes)
                                                             (List $2))))
                       (stv 0.4 0.9)) (1))

            (Sentence ((Implication (Evaluation (Predicate smokes)
                                                (List $1)) 
                                    (Evaluation (Predicate cancerous) (List $1))) 
                       (stv 0.6 0.9)) (2))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Bob))) 
                       (stv 1.0 0.9)) (3))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Edward)))
                       (stv 1.0 0.9)) (4))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (5))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Edward)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (6))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary)
                                         (Concept Helen)))
                       (stv 1.0 0.9)) (7))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary) 
                                         (Concept Frank)))
                       (stv 0.0 0.9)) (8))

            (Sentence ((Evaluation (Predicate smokes)
                                   (List (Concept Anna)))
                       (stv 1.0 0.9)) (9))

            ;(Sentence ((Evaluation (Predicate smokes) 
            ;                       (List (Concept Edward)))
            ;          (stv 1.0 0.9)) (10))
           )

           (Evaluation (Predicate cancerous)
                       (List (Concept Edward)))

           3)
