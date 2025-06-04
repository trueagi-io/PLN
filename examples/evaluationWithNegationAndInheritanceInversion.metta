

!(Question
   (
      ; for now just for application of rule ";Usage of inheritance for predicates"
      (Sentence ((Evaluation (Predicate IsFat) (List (Concept X))) (stv 1.0 1.0)) (1))

      (Sentence ((Not (Inheritance (Concept X) (Concept D))) (stv 0.2 1.0)) (2))
      ; |- (Inheritance (Concept X) (Concept D))  (stv 0.8 1.0)  by not elimination rule
      ; |- (Inheritance (Concept D) (Concept X))                 by Inheritance Inversion Rule
   )

   ; question about evaluation of predicate
   (Evaluation (Predicate IsFat) (List (Concept D)))

   3)

