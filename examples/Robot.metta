;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Static KB part
(= (kbstatic)
   ((sentence ((Implication (Inheritance $1
                                         toy)
                            (Implication (Inheritance $1
                                                      (IntSet see))
                                         (Inheritance $1
                                                      (IntSet bring)))) (stv 0.99 0.99)) (0))))

;3. Init PLN reasoner
!(PLN.Init (kbstatic))

;4. Dynamic knowledge entries
(= (kbdynamic)
   ((sentence ((Inheritance frisbee
                            toy) (stv 0.99 0.99)) (10))
    (sentence ((Inheritance sportsball
                            toy) (stv 0.99 0.99)) (11))
    (sentence ((Inheritance orange
                            (IntSet round)) (stv 0.99 0.99)) (12))
    (sentence ((Inheritance sportsball
                            (IntSet round)) (stv 0.99 0.99)) (13))))

;5. Categorize observation using all prior knowledge
(= (PLNcategorizeObject $label $category)
   (PLN.Query (TupleConcat (kbdynamic)
                           ((sentence ((Inheritance $label
                                                    (IntSet see)) (stv 0.99 0.99)) (99))))
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
!(Test (PLNobjectsOfCategory ((detection frisbee someCoords1)
                              (detection {SELF} someCoords2)
                              (detection person someCoords3)
                              (detection orange someCoords4))
                             (IntSet bring))
       ((detection frisbee someCoords1) (detection orange someCoords4)))
