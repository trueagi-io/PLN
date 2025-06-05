(= (STV (Predicate IsReallyFat))
   (stv 1.0 1.0))

(= (STV (List (Concept Tom)))
   (stv 1.0 1.0))

(= (STV (Predicate IsFat))
   (stv 1.0 1.0))

(= (STV (List (Concept Cat)))
   (stv 1.0 1.0))


!(Question
   (
        ; Tom is really fat
        (Sentence ((Evaluation (Predicate IsReallyFat) (List (Concept Tom))) (stv 1.0 1.0)) (0))


        ; if something is really fat then it's fat
        (Sentence ((Implication (Predicate IsReallyFat) (Predicate IsFat)) (stv 1.0 1.0)) (1))
        

      ; premise necessary for application of rule for unary predicate
      ; Tom is a cat
      (Sentence ((Inheritance  (Concept Tom)  (Concept Cat) ) (stv 1.0 1.0)) (3))

   )

    ; are cats fat?
   (Evaluation (Predicate IsFat) (List (Concept Cat)))

   2)

