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

; InsertionSort helper: insert element x into sorted list L
(= (InsertSorted $x $L)
   (if (== $L ())
       ($x)
       (let* (($head (car-atom $L))
              ($tail (cdr-atom $L)))
             (if (< $x $head)
                 (TupleConcat ($x $head) $tail)
                 (TupleConcat ($head) (InsertSorted $x $tail))))))

; InsertionSort main
(= (InsertionSort $L $Ret)
   (if (== $L ())
       $Ret
       (let* (($x (car-atom $L))
              ($rest (cdr-atom $L))
              ($newRet (InsertSorted $x $Ret)))
             (InsertionSort $rest $newRet))))

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
(= (PLN.Derive $Tasks $Beliefs $steps $maxsteps $taskqueuesize $beliefqueuesize)
   (if (or (> $steps $maxsteps) (== $Tasks ()))
       $Beliefs
       (let (Sentence $x $Ev1) (BestCandidate PriorityRank () $Tasks)
            (let $derivations
                 (collapse (superpose ((let* (((Sentence $y $Ev2) (superpose $Beliefs))
                                              ($stamp (InsertionSort (TupleConcat $Ev1 $Ev2) ())))
                                             (if (StampDisjoint $Ev1 $Ev2)
                                                 (case (superpose ((|- $x $y)
                                                                   (|- $y $x)))
                                                       ((($T $TV) (Sentence ($T $TV) $stamp)))) (empty)))
                                       (case (|- $x) ((($T3 $TV3) (Sentence ($T3 $TV3) $Ev1)))))))
                 (trace! (SELECTED $steps (Sentence $x $Ev1) (DERIVED $derivations))
                         (PLN.Derive (LimitSize (Without (Unique (TupleConcat $Tasks $derivations) ()) (Sentence $x $Ev1)) $taskqueuesize)
                                     (LimitSize (Unique (TupleConcat $Beliefs $derivations) ()) $beliefqueuesize)
                                     (+ $steps 1)
                                     $maxsteps
                                     $taskqueuesize
                                     $beliefqueuesize))))))

(= (PLN.Derive $Tasks $Beliefs $maxsteps $taskqueuesize $beliefqueuesize)
   (PLN.Derive $Tasks $Beliefs 1 $maxsteps $taskqueuesize $beliefqueuesize))

;Candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;Pose a question of a certain term to the system on some knowledge base
(= (PLN.Query $Tasks $Beliefs $term $maxsteps $taskqueuesize $beliefqueuesize)
   (BestCandidate ConfidenceRank () (collapse (let $x (PLN.Derive $Tasks $Beliefs $maxsteps $taskqueuesize $beliefqueuesize)
                                                   (case (superpose $x)
                                                         (((Sentence ($T $TV) $Ev) (case (== $T $term)
                                                                                         ((True ($TV $Ev)))))))))))

(= (PLN.Query $kb $term $maxsteps $taskqueuesize $beliefqueuesize)
   (PLN.Query $kb $kb $term $maxsteps $taskqueuesize $beliefqueuesize))

;Default usage with default resource amount for reasoning:
(= (PLN.Derive $Tasks $Beliefs $maxsteps)
   (PLN.Derive $Tasks $Beliefs $maxsteps (PLN.Config.TaskQueueSize) (PLN.Config.BeliefQueueSize)))

(= (PLN.Derive $Tasks $Beliefs)
   (PLN.Derive $Tasks $Beliefs (PLN.Config.MaxSteps)))

(= (PLN.Query $kb $term $maxsteps)
   (PLN.Query $kb $term $maxsteps (PLN.Config.TaskQueueSize) (PLN.Config.BeliefQueueSize))) ;default space bound

(= (PLN.Query $kb $term)
   (PLN.Query $kb $term (PLN.Config.MaxSteps))) ;default steps bound
