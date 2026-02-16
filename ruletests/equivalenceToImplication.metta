!(import! &self (library lib_pln))

;1. Set up PLN reasoning context
(= (STV Anna) (stv 0.5 1.0))
(= (STV Frank) (stv 0.5 1.0))

;2. Query PLN
!(test (PLN.Query ((Sentence ((Equivalence Anna
                                           Frank) (stv 0.98 0.87)) (1)))
                  (Implication Anna
                               Frank) 1)
       ((stv 0.98989898989899 0.87) (1)))
