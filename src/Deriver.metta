;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True True)))))))

;; Exhaustive-until-depth deriver
(= (Derive $beliefs $depth $maxdepth)
   (if (> $depth $maxdepth)
       $beliefs
       (let $derivations 
            (collapse (superpose ((let* (((Sentence $x $Ev1) (superpose $beliefs))
                                         ((Sentence $y $Ev2) (superpose $beliefs))
                                         ($stamp (TupleConcat $Ev1 $Ev2)))
                                        (if (StampDisjoint $Ev1 $Ev2)
                                            (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)))) ()))
                                  (let (Sentence $z $Ev3) (superpose $beliefs)
                                        (case (|- $z) ((($T3 $TV3) (Sentence ($T3 $TV3) $Ev3))))))))
            (Derive (TupleConcat $beliefs $derivations) (+ $depth 1) $maxdepth))))

;retrieve the best candidate
(= (BestCandidate $evaluateCandidateFunction $bestCandidate $tuple)
  (if (== $tuple ())
      $bestCandidate
      (let* (($head (car-atom $tuple))
             ($tail (cdr-atom $tuple)))
            (if (> ($evaluateCandidateFunction $head)
                   ($evaluateCandidateFunction $bestCandidate))
                (BestCandidate $evaluateCandidateFunction $head $tail)
                (BestCandidate $evaluateCandidateFunction $bestCandidate $tail)))))

; setup for atomspace
(= (setup)
   ; add new atomspace to store conclusions
   (bind! &conclusions (new-space))
)

; run inference and store conclusions in atomspace
(= (runInferenceAndStoreConclusions $kb $depth)
   (add-reduct &conclusions (Derive $kb 1 $depth)))


;candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;pose a question of a certain term to the system on the conclusions
(= (Question $term)
   (BestCandidate ConfidenceRank () (collapse (let $x (get-atoms &conclusions)
                                                   (case (superpose $x)
                                                         (((Sentence ($T $TV) $Ev) (case (== $T $term)
                                                                                          ((True ($TV $Ev)))))))))))

