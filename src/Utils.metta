; MeTTa standard lib extension
;Maximum of 2 numbers
;(: (max (-> Number Number Number)))
;(= (max $1 $2)
;   (if (> $1 $2) $1 $2))

;Minimum of 2 numbers
;(: (min (-> Number Number Number)))
;(= (min $1 $2)
;   (if (< $1 $2) $1 $2))

;Clamp result into range
;(: (clamp (-> Number Number Number Number)))
(= (clamp $v $min $max)
   (min $max (max $v $min)))

;Concat tuples
(= (TupleConcat $Ev1 $Ev2)
   (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))

;Count size of tuple
(= (TupleCount $tuple)
   (if (== $tuple ()) 0 (+ 1 (TupleCount (cdr-atom $tuple)))))

;Shortcut for and with 5 args
(= (and5 $0 $1 $2 $3 $4)
   (and $0 (and $1 (and $2 (and $3 $4)))))

;Shortcut for min with 5 args
(= (min5 $0 $1 $2 $3 $4)
   (min $0 (min $1 (min $2 (min $3 $4)))))

;Exclude division by 0
(= (/safe $A $B)
   (if (> $B 0.0)
       (/ $A $B)
       (empty)))

;Negate (1 minus)
(= (negate $arg)
   (- 1.0 $arg))

;Invert (1 over)
(= (invert $arg)
   (/safe 1.0 $arg))

;Test case
(= (Test $Is $Should)
   ((Is: $Is) (Should: $Should) (Passed: (== $Is $Should))))

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

;Fast but TODO use efficient native handling once available: https://github.com/trueagi-io/metta-morph/pull/27
(= (Unique $L $Ret)
   (if (== $L ())
       $Ret
       (let* (($x (car-atom $L))
              ($rest (cdr-atom $L)))
             (if (ElementOf $x $Ret)
                 (Unique $rest $Ret)
                 (Unique $rest (TupleConcat ($x) $Ret))))))

;insert empty stamp since rules are not based on evidence
(= (|-s $A $B)
   (let ($Term $TV) (|- $A $B)
        ($Term $TV ())))

;insert empty stamp since rules are not based on evidence
(= (|-s $A)
   (let ($Term $TV) (|- $A)
        ($Term $TV ())))
