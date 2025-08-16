;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True True)))))))

;Concat stamp with sorting
(= (StampConcat $stamp $addition)
   (if (== $addition ())
       $stamp
       (InsertionSort (TupleConcat $stamp $addition) ())))

;retrieve the best candidate (PQ functionality)
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

;candidate elimination based on negated priority
(= (PriorityRankNeg (Sentence ($x (stv $f $c)) $Ev1)) (- $c))
(= (PriorityRankNeg ()) -99999.0)

;Return limited-sized version of $L (bounded PQ functionality)
(= (LimitSize $L $size)
   (if (< (TupleCount $L) $size)
       $L
       (let $lowestPriorityItem (BestCandidate PriorityRankNeg () $L)
            (LimitSize (Without $L $lowestPriorityItem) $size))))

;Priority-queue based task ranking deriver with belief buffer
(= (PLN.Derive $Tasks $Beliefs $steps $maxsteps $taskqueuesize $beliefqueuesize)
   (if (or (> $steps $maxsteps) (== $Tasks ()))
       ($Tasks $Beliefs)
       (let (Sentence $x $Ev1) (BestCandidate PriorityRank () $Tasks)
            (let $derivations
                 (collapse (superpose ((let* (((Sentence $y $Ev2) (superpose $Beliefs))
                                              ($stamp (StampConcat $Ev1 $Ev2)))
                                             (if (StampDisjoint $Ev1 $Ev2)
                                                 (case (superpose ((|-s $x $y)
                                                                   (|-s $y $x)))
                                                       ((($T $TV $impstamp)
                                                         (Sentence ($T $TV) (StampConcat $stamp $impstamp))))) (empty)))
                                       (case (|-s $x) ((($T3 $TV3 $impstamp)
                                                        (Sentence ($T3 $TV3) (StampConcat $Ev1 $impstamp))))))))
                 (trace! (SELECTED $steps (Sentence $x $Ev1) (DERIVED $derivations))
                         (PLN.Derive (LimitSize (Without (Unique (TupleConcat $Tasks $derivations) ()) (Sentence $x $Ev1)) $taskqueuesize)
                                     (LimitSize (Unique (TupleConcat $Beliefs $derivations) ()) $beliefqueuesize)
                                     (+ $steps 1)
                                     $maxsteps
                                     $taskqueuesize
                                     $beliefqueuesize))))))

(= (PLN.Derive $Tasks $Beliefs $maxsteps $taskqueuesize $beliefqueuesize)
   (PLN.Derive $Tasks $Beliefs 1 $maxsteps $taskqueuesize $beliefqueuesize))

(= (PLN.Derive $Tasks $Beliefs $maxsteps)
   (PLN.Derive $Tasks $Beliefs $maxsteps (PLN.Config.TaskQueueSize) (PLN.Config.BeliefQueueSize)))

(= (PLN.Derive $Tasks $Beliefs)
   (PLN.Derive $Tasks $Beliefs (PLN.Config.MaxSteps)))

;Candidate evaluation based on confidence
(= (ConfidenceRank ((stv $f $c) $Ev)) $c)
(= (ConfidenceRank ()) 0)

;Pose a question of a certain term to the system on some knowledge base
(= (PLN.Query $Tasks $Beliefs $term $maxsteps $taskqueuesize $beliefqueuesize)
   (BestCandidate ConfidenceRank () (collapse (let ($TasksRet $BeliefsRet) (PLN.Derive $Tasks $Beliefs $maxsteps $taskqueuesize $beliefqueuesize)
                                                   (case (superpose $BeliefsRet)
                                                         (((Sentence ($Term $TV) $Ev) (case (== $Term $term)
                                                                                            ((True ($TV $Ev)))))))))))

(= (PLN.Query $kb $term $maxsteps $taskqueuesize $beliefqueuesize)
   (PLN.Query $kb $kb $term $maxsteps $taskqueuesize $beliefqueuesize))

(= (PLN.Query $kb $term $maxsteps)
   (PLN.Query $kb $term $maxsteps (PLN.Config.TaskQueueSize) (PLN.Config.BeliefQueueSize))) ;default space bound

(= (PLN.Query $kb $term)
   (PLN.Query $kb $term (PLN.Config.MaxSteps))) ;default steps bound
