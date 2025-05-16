; MeTTa standard lib extension
(: (max (-> Number Number Number)))
(= (max $1 $2)
   (if (> $1 $2) $1 $2))

(: (min (-> Number Number Number)))
(= (min $1 $2)
   (if (< $1 $2) $1 $2))

(: (clamp (-> Number Number Number Number)))
(= (clamp $v $min $max)
   (min $max (max $v $min)))

(= (TupleConcat $Ev1 $Ev2)
   (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))
