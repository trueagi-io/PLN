;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence ((Predicate IsReallyFat) (stv 0.25 1.0)) (0))
            (sentence ((List (Concept Tom)) (stv 0.25 1.0)) (0))
            (sentence ((Predicate IsFat) (stv 0.25 1.0)) (0))
            (sentence ((List (Concept Cat)) (stv 0.25 1.0)) (0))))

;3. Query PLN
!(Test (PLN.Query (; Tom is really fat
                   (sentence ((Evaluation (Predicate IsReallyFat)
                                          (List (Concept Cat))) (stv 1.0 1.0)) (1))
                   ; if something is really fat then it's fat
                   (sentence ((Implication (Predicate IsReallyFat)
                                           (Predicate IsFat)) (stv 1.0 1.0)) (2))
                   ; premise necessary for application of rule for unary predicate
                   ; Tom is a cat
                   (sentence ((Inheritance (Concept Tom)
                                           (Concept Cat)) (stv 1.0 1.0)) (3)))
                  ; are cats fat?
                  (Evaluation (Predicate IsFat)
                              (List (Concept Tom))) 10)
       ((stv 1.0 0.729) (1 2 3)))

