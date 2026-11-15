; manual test for the Induction Rule
;
; important is that the shared left-side term of the two premises is passed
; to the truth function as the middle term

!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV (Concept A)) (stv 0.5 1.0))
(= (STV (Concept B)) (stv 0.4 1.0))
(= (STV (Concept C)) (stv 0.2 1.0))

;2. Query PLN
!(test (PLN.Query ((Sentence ((Inheritance (Concept C)
                                           (Concept A)) (stv 0.8 0.9)) (1))
                   (Sentence ((Inheritance (Concept C)
                                           (Concept B)) (stv 0.6 0.9)) (2)))
                  (Inheritance (Concept A)
                               (Concept B)) 1)
       ((stv 0.43 0.3270524899057874) (1 2)))
