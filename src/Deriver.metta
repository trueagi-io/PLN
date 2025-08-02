;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True True)))))))

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

;candidate evaluation based on priority
(= (PriorityRank (Sentence ($x (stv $f $c)) $Ev1)) $c)
(= (PriorityRank ()) -99999.0)

(= (PriorityRankNeg (Sentence ($x (stv $f $c)) $Ev1)) (- $c))
(= (PriorityRankNeg ()) -99999.0)

;Exclude item from tuple
(= (Without $Tuple $a)
   (collapse (let $x (superpose $Tuple)
                  (if (== $x $a)
                      (empty)
                      $x))))

;Whether a is an element of the tuple
(= (ElementOf $a $Tuple)
   (not (== (collapse (let $x (superpose $Tuple)
                          (if (== $x $a)
                              True
                              (empty)))) ())))

;Return limited-sized version of $L
(= (LimitSize $L $size)
   (if (< (TupleCount $L) $size)
       $L
       (let $lowestPriorityItem (BestCandidate PriorityRankNeg () $L)
            (LimitSize (Without $L $lowestPriorityItem) $size))))

;Fast but TODO use efficient native handling once available: https://github.com/trueagi-io/metta-morph/pull/27
(= (Unique $L $Ret)
   (if (== $L ())
       $Ret
       (let* (($x (car-atom $L))
              ($rest (cdr-atom $L)))
             (if (ElementOf $x $Ret)
                 (Unique $rest $Ret)
                 (Unique $rest (TupleConcat ($x) $Ret))))))

;Priority-queue based task ranking deriver with belief buffer
(= (Derive $activeBeliefs $allBeliefs $depth $maxdepth $taskqueuesize $beliefqueuesize)
   (if (or (> $depth $maxdepth) (== $activeBeliefs ()))
       $allBeliefs
       (let (Sentence $x $Ev1) (BestCandidate PriorityRank () $activeBeliefs)
            (let $derivations
                 (collapse (superpose ((let* (((Sentence $y $Ev2) (superpose $allBeliefs))
                                              ($stamp (TupleConcat $Ev1 $Ev2)))
                                             (if (StampDisjoint $Ev1 $Ev2)
                                                 (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)))) (empty)))
                                       (case (|- $x) ((($T3 $TV3) (Sentence ($T3 $TV3) $Ev1)))))))
                 (trace! (SELECTED $depth (Sentence $x $Ev1))
                         (Derive (LimitSize (Without (Unique (TupleConcat $activeBeliefs $derivations) ()) (Sentence $x $Ev1)) $taskqueuesize)
                                 (LimitSize (Unique (TupleConcat $allBeliefs $derivations) ()) $beliefqueuesize)
                                 (+ $depth 1)
                                 $maxdepth
                                 $taskqueuesize
                                 $beliefqueuesize))))))

;Candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;Pose a question of a certain term to the system on some knowledge base
(= (Question $kb $term $steps $taskqueuesize $beliefqueuesize)
   (BestCandidate ConfidenceRank () (collapse (let $x (Derive $kb $kb 1 $steps $taskqueuesize $beliefqueuesize)
                                                   (case (superpose $x)
                                                         (((Sentence ($T $TV) $Ev) (case (== $T $term)
                                                                                         ((True ($TV $Ev)))))))))))

