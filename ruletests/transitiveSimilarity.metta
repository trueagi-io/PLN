; manual test for transitive similarity

!(import! &self (library lib_pln))

;1. Set up PLN reasoning context
(= (STV A) (stv 0.333 1.0))
(= (STV B) (stv 0.333 1.0))
(= (STV C) (stv 0.333 1.0))

;2. Query PLN
!(test (PLN.Query (;A is similar to B
                   (Sentence ((Similarity A B) (stv 1.0 0.89)) (1))
                   ;B is similar to C
                   (Sentence ((Similarity B C) (stv 1.0 0.5)) (2)))
                  (Similarity A C))
       ((stv 1.0 0.5) (1 2)))
