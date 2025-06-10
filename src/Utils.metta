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

(= (and5 $0 $1 $2 $3 $4) (and $0 (and $1 (and $2 (and $3 $4)))))

(= (min3 $0 $1 $2) (min $0 (min $1 $2)))
(= (min5 $0 $1 $2 $3 $4) (min $0 (min $1 (min $2 (min $3 $4)))))

(= (/safe $A $B)
   (if (> $B 0.0)
       (/ $A $B)
       (empty)))

(= (negate $arg) (- 1.0 $arg))

(= (invert $arg) (/ 1.0 $arg))

(= (abs $arg) (max $arg (- 0.0 $arg)))
