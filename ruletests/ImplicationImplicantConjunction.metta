; manual test for Implication Implicant Conjunction Rule
;
; has to behave similar to abduction but not exactly like abduction

(= (STV A)
   (stv 0.3333 1.0))

(= (STV B)
   (stv 0.30 1.0))

(= (STV C)
   (stv 0.3333 0.3))

!(Question
   (
      (Sentence ((Implication A C) (stv 0.98 0.98)) (0))
      (Sentence ((Implication B C) (stv 0.75 0.89)) (1))
   )

   (Implication (And A B) C)

   1
)

!(Question
   (
      (Sentence ((Implication A C) (stv 0.98 0.98)) (0))
      (Sentence ((Implication B C) (stv 0.75 0.89)) (1))
   )

   (Implication (Or A B) C)

   1
)
