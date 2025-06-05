; manual test for transitive similarity

(= (STV A)
   (stv 0.333 1.0))

(= (STV B)
   (stv 0.333 1.0))

(= (STV C)
   (stv 0.333 1.0))


!(Question
   (
      (Sentence ((Similarity A B) (stv 1.0 0.89)) (0))
      (Sentence ((Similarity B C) (stv 1.0 0.5)) (1))
   )

   (Similarity A C)
   
   1)
