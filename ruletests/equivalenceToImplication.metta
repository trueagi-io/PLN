;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence ((Concept Anna) (stv 0.5 1.0)) (0))
            (sentence ((Concept Frank) (stv 0.5 1.0)) (0))))

;3. Query PLN
!(Test (PLN.Query ((sentence ((Equivalence (Concept Anna)
                                           (Concept Frank)) (stv 0.98 0.87)) (1)))
                  (Implication (Concept Anna)
                               (Concept Frank)) 1)
       ((stv 0.98989898989899 0.87) (1)))
