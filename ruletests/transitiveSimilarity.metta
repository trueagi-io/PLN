; manual test for transitive similarity

;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence (A (stv 0.333 1.0)) (0))
            (sentence (B (stv 0.333 1.0)) (0))
            (sentence (C (stv 0.333 1.0)) (0))))

;3. Query PLN
!(Test (PLN.Query (;A is similar to B
                   (sentence ((Similarity A B) (stv 1.0 0.89)) (1))
                   ;B is similar to C
                   (sentence ((Similarity B C) (stv 1.0 0.5)) (2)))
                  (Similarity A C))
       ((stv 1.0 0.5) (1 2)))
