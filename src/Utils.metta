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
