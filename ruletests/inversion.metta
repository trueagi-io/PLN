; manual test to experiment with TV of inversion  (of implication and implication)
;
; important is that it takes Truth of target (right-side of the premise) into account

(= (STV A)
   (stv 1.0 0.1))

(= (STV B)
   (stv 1.0 1.0))


!(PLN.Query ((Sentence ((Inheritance B
                                     A) (stv 0.87 0.81)) (0)))
            (Inheritance A
                         B) 1)
