!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

(= (STV person) (stv 0.125 0.9))
(= (STV frisbee) (stv 0.125 0.9))
(= (STV sportsball) (stv 0.125 0.9))
(= (STV chair) (stv 0.125 0.9))
(= (STV toy) (stv 0.125 0.9))
(= (STV round) (stv 0.125 0.9))
(= (STV orange) (stv 0.125 0.9))

;2. Static KB part
(= (kb)
   ((Sentence ((Implication (Inheritance $1
                                         toy)
                            (Implication (Inheritance $1
                                                      see)
                                         (Inheritance $1
                                                      bring))) (stv 0.99 0.99)) (1))
    (Sentence ((Inheritance frisbee
                            toy) (stv 0.99 0.99)) (2))
    (Sentence ((Inheritance sportsball
                            toy) (stv 0.99 0.99)) (3))
    (Sentence ((Inheritance orange
                            round) (stv 0.99 0.99)) (4))
    (Sentence ((Inheritance sportsball
                            round) (stv 0.99 0.99)) (5))))

;5. Categorize observation using all prior knowledge
(= (PLNcategorizeObject $label $category)
   (PLN.Query (TupleConcat (kb)
                           ((Sentence ((Inheritance $label
                                                    see) (stv 0.99 0.99)) (99))))
              (Inheritance $label
                           $category)
              )) ;13 7 17)) ;uncomment for example-specific minimal resource usage

;6. Filter objects based on PLN reasoning
(= (PLNobjectsOfCategoryHelper $objects $category)
   (let (detection $label $coord) (superpose $objects)
        (if (not (== (PLNcategorizeObject $label $category) ()))
            (detection $label $coord)
            (empty))))

;7. Ensure uniquene mentioning of objects which are determined to be qualified
(= (PLNobjectsOfCategory $objects $category)
   (let $tuple (collapse (PLNobjectsOfCategoryHelper $objects $category))
        (unique-atom $tuple)))

;8. Determine which of the observed/remembered objects to bring:
!(test (PLNobjectsOfCategory ((detection frisbee someCoords1)
                              (detection {SELF} someCoords2)
                              (detection person someCoords3)
                              (detection orange someCoords4))
                             bring)
       ((detection frisbee someCoords1) (detection orange someCoords4)))

