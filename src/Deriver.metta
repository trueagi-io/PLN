;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True True)))))))


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

;; Exhaustive-until-depth deriver
(= (Derive $beliefs $depth $maxdepth)
   (if (> $depth $maxdepth)
       $beliefs
       (let $derivations 
            (collapse (superpose ((let* (((Sentence $x $Ev1) (superpose $beliefs))
                                         ((Sentence $y $Ev2) (superpose $beliefs))
                                         ($stamp (TupleConcat $Ev1 $Ev2)))
                                        (if (StampDisjoint $Ev1 $Ev2)
                                            (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)))) (empty)))
                                  (let (Sentence $z $Ev3) (superpose $beliefs)
                                       (case (|- $z) ((($T3 $TV3) (Sentence ($T3 $TV3) $Ev3))))))))
            (Derive (Unique (TupleConcat $beliefs $derivations) ()) (+ $depth 1) $maxdepth))))

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

;candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;pose a question of a certain term to the system on some knowledge base
(= (Question $kb $term $steps)
   (BestCandidate ConfidenceRank () (collapse (let $x (Derive $kb 1 $steps) 
                                                   (case (superpose $x)
                                                         (((Sentence ($T $TV) $Ev) (case (== $T $term)
                                                                                          ((True ($TV $Ev)))))))))))

(= (Question $kb $term)
   (Question $kb $term 10))

(= (Question $kb $term $steps $x $y)
   (Question $kb $term $steps))
