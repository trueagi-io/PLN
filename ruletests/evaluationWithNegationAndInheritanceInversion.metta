;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence ((Concept X) (stv 0.5 1.0)) (0))
            (sentence ((Concept D) (stv 0.5 1.0)) (0))))

;3. Query PLN
!(Test (PLN.Query (; for now just for application of rule ";Usage of inheritance for predicates"
                   (Sentence ((Evaluation (Predicate IsFat)
                                          (List (Concept X))) (stv 1.0 1.0)) (1))
                   (Sentence ((Not (Inheritance (Concept X)
                                                (Concept D))) (stv 0.2 1.0)) (2)))
                  ; |- (Inheritance (Concept X) (Concept D))  (stv 0.8 1.0)  by not elimination rule
                  ; |- (Inheritance (Concept D) (Concept X))                 by Inheritance Inversion Rule
                  ; question about evaluation of predicate
                  (Evaluation (Predicate IsFat)
                              (List (Concept D))) 4)
       ((stv 0.8 0.6) (2 1)))
