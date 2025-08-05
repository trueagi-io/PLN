; manual test to experiment with TV of inversion  (of implication and implication)
;
; important is that it takes Truth of target (right-side of the premise) into account

;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence (A (stv 0.5 1.0)) (0))
            (sentence (B (stv 0.5 1.0)) (0))))

;3. Query PLN
!(Test (PLN.Query ((Sentence ((Inheritance B
                                           A) (stv 0.87 0.81)) (1)))
                  (Inheritance A
                               B) 1)
       ((stv 0.87 0.486) (1)))
