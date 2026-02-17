; manual test to experiment with TV of inversion  (of implication and implication)
;
; important is that it takes Truth of target (right-side of the premise) into account

!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV A) (stv 0.5 1.0))
(= (STV B) (stv 0.5 1.0))

;2. Query PLN
!(test (PLN.Query ((Sentence ((Inheritance B
                                           A) (stv 0.87 0.81)) (1)))
                  (Inheritance A
                               B) 1)
       ((stv 0.87 0.486) (1)))
