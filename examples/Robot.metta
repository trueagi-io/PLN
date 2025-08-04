;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Static KB part
(= (kbstatic)
   ((sentence ((Concept person) (stv 0.125 0.9)) (0))
    (sentence ((Concept frisbee) (stv 0.125 0.9)) (0))
    (sentence ((Concept sportsball) (stv 0.125 0.9)) (0))
    (sentence ((Concept chair) (stv 0.125 0.9)) (0))
    (sentence ((Concept toy) (stv 0.125 0.9)) (0))
    (sentence ((Concept round) (stv 0.125 0.9)) (0))
    (sentence ((Concept orange) (stv 0.125 0.9)) (0))
    (sentence ((Implication (Inheritance (Concept $1)
                                         (Concept toy))
                            (Implication (Inheritance (Concept $1)
                                                      (Concept see))
                                         (Inheritance (Concept $1)
                                                      (Concept bring)))) (stv 0.99 0.99)) (0))))

;3. Init PLN reasoner
!(PLN.Init (kbstatic))

;4. Dynamic knowledge entries
(= (kbdynamic)
   ((sentence ((Inheritance (Concept frisbee)
                            (Concept toy)) (stv 0.99 0.99)) (10))
    (sentence ((Inheritance (Concept sportsball)
                            (Concept toy)) (stv 0.99 0.99)) (11))
    (sentence ((Inheritance (Concept orange)
                            (Concept round)) (stv 0.99 0.99)) (12))
    (sentence ((Inheritance (Concept sportsball)
                            (Concept round)) (stv 0.99 0.99)) (13))))

;5. Categorize observation using all prior knowledge
(= (PLNcategorizeObject $label $category)
   (PLN.Query (TupleConcat (kbdynamic)
                           ((sentence ((Inheritance (Concept $label)
                                                    (Concept see)) (stv 0.99 0.99)) (99))))
              (Inheritance (Concept $label)
                           (Concept sportsball))
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
                             bring)
       ((detection frisbee someCoords1) (detection orange someCoords4)))
