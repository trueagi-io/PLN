; MeTTa standard lib extension
;(: (max (-> Number Number Number)))
;(= (max $1 $2)
;   (if (> $1 $2) $1 $2))

;(: (min (-> Number Number Number)))
;(= (min $1 $2)
;   (if (< $1 $2) $1 $2))

;(: (clamp (-> Number Number Number Number)))
(= (clamp $v $min $max)
   (min $max (max $v $min)))

(= (TupleConcat $Ev1 $Ev2)
   (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))

(= (TupleCount $tuple)
   (if (== $tuple ()) 0 (+ 1 (TupleCount (cdr-atom $tuple)))))

(= (and5 $0 $1 $2 $3 $4)
   (and $0 (and $1 (and $2 (and $3 $4)))))

(= (min5 $0 $1 $2 $3 $4)
   (min $0 (min $1 (min $2 (min $3 $4)))))

(= (/safe $A $B)
   (if (> $B 0.0)
       (/ $A $B)
       (empty)))

(= (negate $arg)
   (- 1.0 $arg))

(= (invert $arg)
   (/safe 1.0 $arg))

(= (Test $Is $Should)
   ((Is: $Is) (Should: $Should) (Passed: (== $Is $Should))))

; Recursive function to split tuple into two lists using a boolean flag
(= (SplitTupleHelper $L $list1 $list2 $flag)
   (if (== $L ())
       ($list1 $list2)
       (let* (($head (car-atom $L))
              ($tail (cdr-atom $L)))
             (if $flag
                 (SplitTupleHelper $tail (TupleConcat $list1 ($head)) $list2 (not $flag))
                 (SplitTupleHelper $tail $list1 (TupleConcat $list2 ($head)) (not $flag))))))

(= (SplitTuple $L)
   (SplitTupleHelper $L () () True))
