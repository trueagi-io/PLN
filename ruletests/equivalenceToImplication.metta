(= (STV (Concept Anna))
   (stv 0.1667 0.89))

(= (STV (Concept Frank))
   (stv 0.1667 0.89))

!(PLN.Query ((Sentence ((Equivalence (Concept Anna)
                                     (Concept Frank)) (stv 0.98 0.87)) (5)))
            (Implication (Concept Anna)
                         (Concept Frank)) 1)
