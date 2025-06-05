; manual test to use Inheritance to Member rule to answer question about member.
; also makes use of not elimination rule
; also makes use of Inheritance Inversion Rule
; also makes use of negation introduction rule

(= (STV (Not (Inheritance B A)))
   (stv 1.0 1.0))


!(Question
   (
      (Sentence ((Not (Inheritance B A)) (stv 0.87 0.81)) (0))
   )

   (Not (Member A B))

   4)







; test for premises with different given truths

!(Question
   (
      (Sentence ((Not (Inheritance B A)) (stv 0.0 0.81)) (0))
   )

   (Not (Member A B))

   4)

!(Question
   (
      (Sentence ((Not (Inheritance B A)) (stv 1.0 0.81)) (0))
   )

   (Not (Member A B))

   4)

!(Question
   (
      (Sentence ((Not (Inheritance B A)) (stv 0.0 0.1)) (0))
   )

   (Not (Member A B))

   4)

!(Question
   (
      (Sentence ((Not (Inheritance B A)) (stv 1.0 0.1)) (0))
   )

   (Not (Member A B))

   4)
